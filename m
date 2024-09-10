From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Tue, 10 Sep 2024 07:43:38 +0000
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5a0b1d5dba6fb56417372c94075842fe0c698b4f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ezz0ITQCaPo="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Support CIDR on
 options and extend netbits usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ezz0ITQCaPo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail

to look at the new patch set (#2).


Change subject: Support CIDR on options and extend netbits usage
......................................................................

Support CIDR on options and extend netbits usage

Add support for CIDR notation on all suitable options (client-nat,
ifconfig, ifconfig-pull, ifconfig-push, ifconfig-push-constraint,
iroute, route, server, server-bridge). Anyway push of ifconfig is done
without CIDR in order to support older peers. Also netmask env vars have
been preserved while also introducing the corresponding netbits vars.

Some of the internal logic has also been modified to use netbits instead
of netmasks.

Change-Id: Iae04ad8715e40dfc76475c2c5b9a766c9604efc9
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/basic.h
M src/openvpn/clinat.c
M src/openvpn/clinat.h
M src/openvpn/helper.c
M src/openvpn/init.c
M src/openvpn/manage.c
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/pool.c
M src/openvpn/push.c
M src/openvpn/route.c
M src/openvpn/route.h
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/tun.c
M src/openvpn/tun.h
17 files changed, 520 insertions(+), 284 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/739/2

diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index d1075b2..6658008 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -33,5 +33,6 @@
 #define CLEAR(x) memset(&(x), 0, sizeof(x))

 #define IPV4_NETMASK_HOST 0xffffffffU
+#define IPV4_NETBITS_HOST 32U

 #endif
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 2d3b359..f565989 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -31,6 +31,7 @@
 #include "proto.h"
 #include "socket.h"
 #include "memdbg.h"
+#include "route.h"

 static bool
 add_entry(struct client_nat_option_list *dest,
@@ -60,11 +61,11 @@
         for (i =3D 0; i < list->n; ++i)
         {
             const struct client_nat_entry *e =3D &list->entries[i];
-            msg(msglevel, "  CNAT[%d] t=3D%d %s/%s/%s",
+            msg(msglevel, "  CNAT[%d] t=3D%d %s/%d %s",
                 i,
                 e->type,
                 print_in_addr_t(e->network, IA_NET_ORDER, &gc),
-                print_in_addr_t(e->netmask, IA_NET_ORDER, &gc),
+                e->netbits,
                 print_in_addr_t(e->foreign_network, IA_NET_ORDER, &gc));
         }
     }
@@ -111,6 +112,7 @@
                               int msglevel)
 {
     struct client_nat_entry e;
+    unsigned int netbits =3D 0;
     bool ok;

     if (!strcmp(type, "snat"))
@@ -127,19 +129,34 @@
         return;
     }

-    e.network =3D getaddr(0, network, 0, &ok, NULL);
+    e.network =3D getaddr(0, network, &netbits, 0, &ok, NULL);
     if (!ok)
     {
         msg(msglevel, "client-nat: bad network: %s", network);
         return;
     }
-    e.netmask =3D getaddr(0, netmask, 0, &ok, NULL);
-    if (!ok)
+    if (netmask)
     {
-        msg(msglevel, "client-nat: bad netmask: %s", netmask);
+        const in_addr_t mask =3D getaddr(0, netmask, NULL, 0, &ok, NULL);
+        const int bits =3D netmask_to_netbits2(mask);
+
+        if (!ok || bits <=3D 0)
+        {
+            msg(msglevel, "client-nat: bad netmask: %s", netmask);
+            return;
+        }
+        e.netbits =3D bits;
+    }
+    else if (netbits > 0)
+    {
+        e.netbits =3D netbits;
+    }
+    else
+    {
+        msg(msglevel, "client-nat: netmask or bits must be specified");
         return;
     }
-    e.foreign_network =3D getaddr(0, foreign_network, 0, &ok, NULL);
+    e.foreign_network =3D getaddr(0, foreign_network, NULL, 0, &ok, NULL);
     if (!ok)
     {
         msg(msglevel, "client-nat: bad foreign network: %s", foreign_netwo=
rk);
@@ -210,6 +227,7 @@
     for (i =3D 0; i < list->n; ++i)
     {
         const struct client_nat_entry *e =3D &list->entries[i]; /* current=
 NAT rule */
+        const in_addr_t netmask =3D netbits_to_netmask((int)e->netbits);
         if (e->type ^ direction)
         {
             addr =3D *(addr_ptr =3D &h->ip.daddr);
@@ -231,13 +249,13 @@
             to =3D &e->foreign_network;
         }

-        if (((addr & e->netmask) =3D=3D *from) && !(amask & alog))
+        if (((addr & netmask) =3D=3D *from) && !(amask & alog))
         {
             /* pre-adjust IP checksum */
             ADD_CHECKSUM_32(accumulate, addr);

             /* do NAT transform */
-            addr =3D (addr & ~e->netmask) | *to;
+            addr =3D (addr & ~netmask) | *to;

             /* post-adjust IP checksum */
             SUB_CHECKSUM_32(accumulate, addr);
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index 94141f5..bebd012 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -36,7 +36,7 @@
 #define CN_DNAT 1
     int type;
     in_addr_t network;
-    in_addr_t netmask;
+    unsigned int netbits;
     in_addr_t foreign_network;
 };

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index bbdbc04..30f3539 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -64,22 +64,21 @@
 }

 static const char *
-print_opt_route(const in_addr_t network, const in_addr_t netmask, struct g=
c_arena *gc)
+print_opt_route(const in_addr_t network, const int netbits, struct gc_aren=
a *gc)
 {
     struct buffer out =3D alloc_buf_gc(128, gc);
     ASSERT(network);

-    if (netmask)
-    {
-        buf_printf(&out, "route %s %s",
-                   print_in_addr_t(network, 0, gc),
-                   print_in_addr_t(netmask, 0, gc));
-    }
-    else
+    if (netbits < 0)
     {
         buf_printf(&out, "route %s",
                    print_in_addr_t(network, 0, gc));
     }
+    else
+    {
+        buf_printf(&out, "route %s/%d",
+                   print_in_addr_t(network, 0, gc), netbits);
+    }

     return BSTR(&out);
 }
@@ -111,27 +110,28 @@
 }

 static void
-helper_add_route(const in_addr_t network, const in_addr_t netmask, struct =
options *o)
+helper_add_route(const in_addr_t network, const int netbits, struct option=
s *o)
 {
     rol_check_alloc(o);
     add_route_to_option_list(o->routes,
                              print_in_addr_t(network, 0, &o->gc),
-                             print_in_addr_t(netmask, 0, &o->gc),
+                             print_in_addr_t(netbits_to_netmask(netbits), =
0, &o->gc),
                              NULL,
                              NULL);
 }

 static void
-verify_common_subnet(const char *opt, const in_addr_t a, const in_addr_t b=
, const in_addr_t subnet)
+verify_common_subnet(const char *opt, const in_addr_t a, const in_addr_t b=
, const unsigned int netbits)
 {
     struct gc_arena gc =3D gc_new();
-    if ((a & subnet) !=3D (b & subnet))
+    const unsigned int var =3D 32 - netbits;
+    if ((a >> var) !=3D (b >> var))
     {
-        msg(M_USAGE, "%s IP addresses %s and %s are not in the same %s sub=
net",
+        msg(M_USAGE, "%s IP addresses %s and %s are not in the same /%d su=
bnet",
             opt,
             print_in_addr_t(a, 0, &gc),
             print_in_addr_t(b, 0, &gc),
-            print_in_addr_t(subnet, 0, &gc));
+            netbits);
     }
     gc_free(&gc);
 }
@@ -268,9 +268,6 @@

     if (o->server_defined)
     {
-        int netbits =3D -2;
-        bool status =3D false;
-
         if (o->client)
         {
             msg(M_USAGE, "--server and --client cannot be used together");
@@ -296,34 +293,24 @@
             msg(M_USAGE, "--server directive only makes sense with --dev t=
un or --dev tap");
         }

-        status =3D netmask_to_netbits(o->server_network, o->server_netmask=
, &netbits);
-        if (!status)
-        {
-            msg(M_USAGE, "--server directive network/netmask combination i=
s invalid");
-        }
-
-        if (netbits < 0)
-        {
-            msg(M_USAGE, "--server directive netmask is invalid");
-        }
-
-        if (netbits < IFCONFIG_POOL_MIN_NETBITS)
+        if (o->server_netbits < IFCONFIG_POOL_MIN_NETBITS)
         {
             msg(M_USAGE, "--server directive netmask allows for too many h=
ost addresses (subnet must be %s or higher)",
                 print_netmask(IFCONFIG_POOL_MIN_NETBITS, &gc));
         }

+        const in_addr_t server_netmask =3D netbits_to_netmask((int)o->serv=
er_netbits);
         if (dev =3D=3D DEV_TYPE_TUN)
         {
             int pool_end_reserve =3D 4;

-            if (netbits > 29)
+            if (o->server_netbits > 29)
             {
                 msg(M_USAGE, "--server directive when used with --dev tun =
must define a subnet of %s or lower",
                     print_netmask(29, &gc));
             }

-            if (netbits =3D=3D 29)
+            if (o->server_netbits =3D=3D 29)
             {
                 pool_end_reserve =3D 0;
             }
@@ -342,14 +329,14 @@
                 {
                     o->ifconfig_pool_defined =3D true;
                     o->ifconfig_pool_start =3D o->server_network + 4;
-                    o->ifconfig_pool_end =3D (o->server_network | ~o->serv=
er_netmask) - pool_end_reserve;
+                    o->ifconfig_pool_end =3D (o->server_network | ~server_=
netmask) - pool_end_reserve;
                     ifconfig_pool_verify_range(M_USAGE, o->ifconfig_pool_s=
tart, o->ifconfig_pool_end);
                 }

-                helper_add_route(o->server_network, o->server_netmask, o);
+                helper_add_route(o->server_network, o->server_netbits, o);
                 if (o->enable_c2c)
                 {
-                    push_option(o, print_opt_route(o->server_network, o->s=
erver_netmask, &o->gc), M_USAGE);
+                    push_option(o, print_opt_route(o->server_network, o->s=
erver_netbits, &o->gc), M_USAGE);
                 }
                 else if (o->topology =3D=3D TOP_NET30)
                 {
@@ -359,16 +346,16 @@
             else if (o->topology =3D=3D TOP_SUBNET)
             {
                 o->ifconfig_local =3D print_in_addr_t(o->server_network + =
1, 0, &o->gc);
-                o->ifconfig_remote_netmask =3D print_in_addr_t(o->server_n=
etmask, 0, &o->gc);
+                o->ifconfig_remote_netmask =3D print_in_addr_t(server_netm=
ask, 0, &o->gc);

                 if (!(o->server_flags & SF_NOPOOL))
                 {
                     o->ifconfig_pool_defined =3D true;
                     o->ifconfig_pool_start =3D o->server_network + 2;
-                    o->ifconfig_pool_end =3D (o->server_network | ~o->serv=
er_netmask) - 1;
+                    o->ifconfig_pool_end =3D (o->server_network | ~server_=
netmask) - 1;
                     ifconfig_pool_verify_range(M_USAGE, o->ifconfig_pool_s=
tart, o->ifconfig_pool_end);
                 }
-                o->ifconfig_pool_netmask =3D o->server_netmask;
+                o->ifconfig_pool_netbits =3D o->server_netbits;

                 push_option(o, print_opt_route_gateway(o->server_network +=
 1, &o->gc), M_USAGE);
                 if (!o->route_default_gateway)
@@ -393,7 +380,7 @@
         }
         else if (dev =3D=3D DEV_TYPE_TAP)
         {
-            if (netbits > 30)
+            if (o->server_netbits > 30)
             {
                 msg(M_USAGE, "--server directive when used with --dev tap =
must define a subnet of %s or lower",
                     print_netmask(30, &gc));
@@ -402,16 +389,16 @@
             o->mode =3D MODE_SERVER;
             o->tls_server =3D true;
             o->ifconfig_local =3D print_in_addr_t(o->server_network + 1, 0=
, &o->gc);
-            o->ifconfig_remote_netmask =3D print_in_addr_t(o->server_netma=
sk, 0, &o->gc);
+            o->ifconfig_remote_netmask =3D print_in_addr_t(server_netmask,=
 0, &o->gc);

             if (!(o->server_flags & SF_NOPOOL))
             {
                 o->ifconfig_pool_defined =3D true;
                 o->ifconfig_pool_start =3D o->server_network + 2;
-                o->ifconfig_pool_end =3D (o->server_network | ~o->server_n=
etmask) - 1;
+                o->ifconfig_pool_end =3D (o->server_network | ~server_netm=
ask) - 1;
                 ifconfig_pool_verify_range(M_USAGE, o->ifconfig_pool_start=
, o->ifconfig_pool_end);
             }
-            o->ifconfig_pool_netmask =3D o->server_netmask;
+            o->ifconfig_pool_netbits =3D o->server_netbits;

             push_option(o, print_opt_route_gateway(o->server_network + 1, =
&o->gc), M_USAGE);
         }
@@ -425,7 +412,7 @@
         {
             o->push_ifconfig_constraint_defined =3D true;
             o->push_ifconfig_constraint_network =3D o->server_network;
-            o->push_ifconfig_constraint_netmask =3D o->server_netmask;
+            o->push_ifconfig_constraint_netbits =3D o->server_netbits;
         }
     }

@@ -478,9 +465,9 @@

         if (o->server_bridge_defined)
         {
-            verify_common_subnet("--server-bridge", o->server_bridge_ip, o=
->server_bridge_pool_start, o->server_bridge_netmask);
-            verify_common_subnet("--server-bridge", o->server_bridge_pool_=
start, o->server_bridge_pool_end, o->server_bridge_netmask);
-            verify_common_subnet("--server-bridge", o->server_bridge_ip, o=
->server_bridge_pool_end, o->server_bridge_netmask);
+            verify_common_subnet("--server-bridge", o->server_bridge_ip, o=
->server_bridge_pool_start, o->server_bridge_netbits);
+            verify_common_subnet("--server-bridge", o->server_bridge_pool_=
start, o->server_bridge_pool_end, o->server_bridge_netbits);
+            verify_common_subnet("--server-bridge", o->server_bridge_ip, o=
->server_bridge_pool_end, o->server_bridge_netbits);
         }

         o->mode =3D MODE_SERVER;
@@ -492,7 +479,7 @@
             o->ifconfig_pool_start =3D o->server_bridge_pool_start;
             o->ifconfig_pool_end =3D o->server_bridge_pool_end;
             ifconfig_pool_verify_range(M_USAGE, o->ifconfig_pool_start, o-=
>ifconfig_pool_end);
-            o->ifconfig_pool_netmask =3D o->server_bridge_netmask;
+            o->ifconfig_pool_netbits =3D o->server_bridge_netbits;
             push_option(o, print_opt_route_gateway(o->server_bridge_ip, &o=
->gc), M_USAGE);
         }
         else if (o->server_bridge_proxy_dhcp && !(o->server_flags & SF_NO_=
PUSH_ROUTE_GATEWAY))
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index dd56961..7f72f8d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -115,6 +115,7 @@
             const char *dev_type,
             int tun_mtu,
             const char *ifconfig_local,
+            const int ifconfig_netbits,
             const char *ifconfig_remote,
             const char *context,
             const char *signal_text,
@@ -144,7 +145,14 @@
     }
     if (!ifconfig_remote)
     {
-        ifconfig_remote =3D "";
+        if (ifconfig_netbits > 0)
+        {
+            ifconfig_remote =3D print_in_addr_t(netbits_to_netmask(ifconfi=
g_netbits), 0, &gc);
+        }
+        else
+        {
+            ifconfig_remote =3D "";
+        }
     }
     if (!context)
     {
@@ -1948,7 +1956,8 @@
                     dev_type_string(c->options.dev, c->options.dev_type),
                     c->c2.frame.tun_mtu,
                     print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF=
, &gc),
-                    print_in_addr_t(c->c1.tuntap->remote_netmask, IA_EMPTY=
_IF_UNDEF, &gc),
+                    c->c1.tuntap->netbits,
+                    print_in_addr_t(c->c1.tuntap->remote, IA_EMPTY_IF_UNDE=
F, &gc),
                     "init",
                     NULL,
                     "up",
@@ -1988,7 +1997,8 @@
                         dev_type_string(c->options.dev, c->options.dev_typ=
e),
                         c->c2.frame.tun_mtu,
                         print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_U=
NDEF, &gc),
-                        print_in_addr_t(c->c1.tuntap->remote_netmask, IA_E=
MPTY_IF_UNDEF, &gc),
+                        c->c1.tuntap->netbits,
+                        print_in_addr_t(c->c1.tuntap->remote, IA_EMPTY_IF_=
UNDEF, &gc),
                         "restart",
                         NULL,
                         "up",
@@ -2045,7 +2055,8 @@
     struct gc_arena gc =3D gc_new();
     const char *tuntap_actual =3D string_alloc(c->c1.tuntap->actual_name, =
&gc);
     const in_addr_t local =3D c->c1.tuntap->local;
-    const in_addr_t remote_netmask =3D c->c1.tuntap->remote_netmask;
+    const int netbits =3D c->c1.tuntap->netbits;
+    const in_addr_t remote =3D c->c1.tuntap->remote;
     unsigned long adapter_index =3D 0;
 #ifdef _WIN32
     adapter_index =3D c->c1.tuntap->adapter_index;
@@ -2077,7 +2088,8 @@
                         NULL,
                         c->c2.frame.tun_mtu,
                         print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
-                        print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF,=
 &gc),
+                        netbits,
+                        print_in_addr_t(remote, IA_EMPTY_IF_UNDEF, &gc),
                         "init",
                         signal_description(c->sig->signal_received,
                                            c->sig->signal_text),
@@ -2107,7 +2119,8 @@
                     NULL,
                     c->c2.frame.tun_mtu,
                     print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
-                    print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc=
),
+                    netbits,
+                    print_in_addr_t(remote, IA_EMPTY_IF_UNDEF, &gc),
                     "init",
                     signal_description(c->sig->signal_received,
                                        c->sig->signal_text),
@@ -2137,7 +2150,8 @@
                         NULL,
                         c->c2.frame.tun_mtu,
                         print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
-                        print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF,=
 &gc),
+                        netbits,
+                        print_in_addr_t(remote, IA_EMPTY_IF_UNDEF, &gc),
                         "restart",
                         signal_description(c->sig->signal_received,
                                            c->sig->signal_text),
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 05b5a1a..a88ee5f 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -554,7 +554,7 @@
         {
             /* IP:port specified */
             bool status;
-            const in_addr_t addr =3D getaddr(GETADDR_HOST_ORDER|GETADDR_MS=
G_VIRT_OUT, p1, 0, &status, NULL);
+            const in_addr_t addr =3D getaddr(GETADDR_HOST_ORDER|GETADDR_MS=
G_VIRT_OUT, p1, NULL, 0, &status, NULL);
             if (status)
             {
                 const int port =3D atoi(p2);
@@ -2803,6 +2803,7 @@
         "untrusted_ip=3D",
         "ifconfig_local=3D",
         "ifconfig_netmask=3D",
+        "ifconfig_netbits=3D",
         "daemon_start_time=3D",
         "daemon_pid=3D",
         "dev=3D",
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0509911..aba1a0f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1433,7 +1433,8 @@
     const struct options *o =3D &c->options;
     if (o->push_ifconfig_constraint_defined && c->c2.push_ifconfig_defined)
     {
-        return (o->push_ifconfig_constraint_netmask & c->c2.push_ifconfig_=
local) =3D=3D o->push_ifconfig_constraint_network;
+        const unsigned int var =3D 32 - o->push_ifconfig_constraint_netbit=
s;
+        return (c->c2.push_ifconfig_local >> var) =3D=3D (o->push_ifconfig=
_constraint_network >> var);
     }
     else
     {
@@ -1512,10 +1513,10 @@
                 mi->context.c2.push_ifconfig_local =3D remote;
                 if (tunnel_type =3D=3D DEV_TYPE_TAP || (tunnel_type =3D=3D=
 DEV_TYPE_TUN && tunnel_topology =3D=3D TOP_SUBNET))
                 {
-                    mi->context.c2.push_ifconfig_remote_netmask =3D mi->co=
ntext.options.ifconfig_pool_netmask;
+                    mi->context.c2.push_ifconfig_remote_netmask =3D netbit=
s_to_netmask((int)mi->context.options.ifconfig_pool_netbits);
                     if (!mi->context.c2.push_ifconfig_remote_netmask)
                     {
-                        mi->context.c2.push_ifconfig_remote_netmask =3D mi=
->context.c1.tuntap->remote_netmask;
+                        mi->context.c2.push_ifconfig_remote_netmask =3D ne=
tbits_to_netmask((int)mi->context.c1.tuntap->netbits);
                     }
                 }
                 else if (tunnel_type =3D=3D DEV_TYPE_TUN)
@@ -2425,15 +2426,14 @@
     {
         const char *ifconfig_constraint_network =3D
             print_in_addr_t(mi->context.options.push_ifconfig_constraint_n=
etwork, 0, &gc);
-        const char *ifconfig_constraint_netmask =3D
-            print_in_addr_t(mi->context.options.push_ifconfig_constraint_n=
etmask, 0, &gc);

         /* JYFIXME -- this should cause the connection to fail */
         msg(D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s) "
-            "violates tunnel network/netmask constraint (%s/%s)",
+            "violates tunnel network/subnet constraint (%s/%d)",
             multi_instance_string(mi, false, &gc),
             print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc),
-            ifconfig_constraint_network, ifconfig_constraint_netmask);
+            ifconfig_constraint_network,
+            mi->context.options.push_ifconfig_constraint_netbits);
     }

     /*
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 649f48b..b0fabe1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1075,7 +1075,7 @@
 #endif /* ifndef _WIN32 */

 static in_addr_t
-get_ip_addr(const char *ip_string, int msglevel, bool *error)
+get_ip_addr(const char *ip_string, unsigned int *netbits, int msglevel, bo=
ol *error)
 {
     unsigned int flags =3D GETADDR_HOST_ORDER;
     bool succeeded =3D false;
@@ -1086,7 +1086,7 @@
         flags |=3D GETADDR_FATAL;
     }

-    ret =3D getaddr(flags, ip_string, 0, &succeeded, NULL);
+    ret =3D getaddr(flags, ip_string, netbits, 0, &succeeded, NULL);
     if (!succeeded && error)
     {
         *error =3D true;
@@ -1333,7 +1333,7 @@
         if (ip_addr_dotted_quad_safe(parm)) /* FQDN -- IP address only */
         {
             bool error =3D false;
-            const in_addr_t addr =3D get_ip_addr(parm, msglevel, &error);
+            const in_addr_t addr =3D get_ip_addr(parm, NULL, msglevel, &er=
ror);
             if (!error)
             {
                 array[(*len)++] =3D addr;
@@ -1513,12 +1513,10 @@
 {
     struct gc_arena gc =3D gc_new();

-    msg(D_SHOW_PARMS, "  server_network =3D %s", print_in_addr_t(o->server=
_network, 0, &gc));
-    msg(D_SHOW_PARMS, "  server_netmask =3D %s", print_in_addr_t(o->server=
_netmask, 0, &gc));
+    msg(D_SHOW_PARMS, "  server_network =3D %s/%d", print_in_addr_t(o->ser=
ver_network, 0, &gc), o->server_netbits);
     msg(D_SHOW_PARMS, "  server_network_ipv6 =3D %s", print_in6_addr(o->se=
rver_network_ipv6, 0, &gc) );
     SHOW_INT(server_netbits_ipv6);
-    msg(D_SHOW_PARMS, "  server_bridge_ip =3D %s", print_in_addr_t(o->serv=
er_bridge_ip, 0, &gc));
-    msg(D_SHOW_PARMS, "  server_bridge_netmask =3D %s", print_in_addr_t(o-=
>server_bridge_netmask, 0, &gc));
+    msg(D_SHOW_PARMS, "  server_bridge_ip =3D %s/%d", print_in_addr_t(o->s=
erver_bridge_ip, 0, &gc), o->server_bridge_netbits);
     msg(D_SHOW_PARMS, "  server_bridge_pool_start =3D %s", print_in_addr_t=
(o->server_bridge_pool_start, 0, &gc));
     msg(D_SHOW_PARMS, "  server_bridge_pool_end =3D %s", print_in_addr_t(o=
->server_bridge_pool_end, 0, &gc));
     if (o->push_list.head)
@@ -1534,9 +1532,8 @@
         }
     }
     SHOW_BOOL(ifconfig_pool_defined);
-    msg(D_SHOW_PARMS, "  ifconfig_pool_start =3D %s", print_in_addr_t(o->i=
fconfig_pool_start, 0, &gc));
+    msg(D_SHOW_PARMS, "  ifconfig_pool_start =3D %s/%d", print_in_addr_t(o=
->ifconfig_pool_start, 0, &gc), o->ifconfig_pool_netbits);
     msg(D_SHOW_PARMS, "  ifconfig_pool_end =3D %s", print_in_addr_t(o->ifc=
onfig_pool_end, 0, &gc));
-    msg(D_SHOW_PARMS, "  ifconfig_pool_netmask =3D %s", print_in_addr_t(o-=
>ifconfig_pool_netmask, 0, &gc));
     SHOW_STR(ifconfig_pool_persist_filename);
     SHOW_INT(ifconfig_pool_persist_refresh_freq);
     SHOW_BOOL(ifconfig_ipv6_pool_defined);
@@ -1597,14 +1594,15 @@
               int msglevel)
 {
     struct iroute *ir;
+    unsigned int netbits =3D 0;

     ALLOC_OBJ_GC(ir, struct iroute, &o->gc);
-    ir->network =3D getaddr(GETADDR_HOST_ORDER, network_str, 0, NULL, NULL=
);
-    ir->netbits =3D 32;           /* host route if no netmask given */
+    ir->network =3D getaddr(GETADDR_HOST_ORDER, network_str, &netbits, 0, =
NULL, NULL);
+    ir->netbits =3D 32;           /* host route if no netmask or netbits g=
iven */

     if (netmask_str)
     {
-        const in_addr_t netmask =3D getaddr(GETADDR_HOST_ORDER, netmask_st=
r, 0, NULL, NULL);
+        const in_addr_t netmask =3D getaddr(GETADDR_HOST_ORDER, netmask_st=
r, NULL, 0, NULL, NULL);
         ir->netbits =3D netmask_to_netbits2(netmask);

         if (ir->netbits < 0)
@@ -1615,6 +1613,10 @@
             return;
         }
     }
+    else if (netbits)
+    {
+        ir->netbits =3D (int)netbits;
+    }

     ir->next =3D o->iroutes;
     o->iroutes =3D ir;
@@ -2631,9 +2633,9 @@
         {
             msg(M_USAGE, "--connect-freq only works with --mode server --p=
roto udp.  Try --max-clients instead.");
         }
-        if (!(dev =3D=3D DEV_TYPE_TAP || (dev =3D=3D DEV_TYPE_TUN && optio=
ns->topology =3D=3D TOP_SUBNET)) && options->ifconfig_pool_netmask)
+        if (!(dev =3D=3D DEV_TYPE_TAP || (dev =3D=3D DEV_TYPE_TUN && optio=
ns->topology =3D=3D TOP_SUBNET)) && options->ifconfig_pool_netbits > 0)
         {
-            msg(M_USAGE, "The third parameter to --ifconfig-pool (netmask)=
 is only valid in --dev tap mode");
+            msg(M_USAGE, "The netbits parameter to --ifconfig-pool is only=
 valid in --dev tap mode");
         }
         if (options->routes && (options->routes->flags & RG_ENABLE))
         {
@@ -6092,11 +6094,29 @@
         iproute_path =3D p[1];
     }
 #endif
-    else if (streq(p[0], "ifconfig") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], "ifconfig") && p[1] && !p[3])
     {
+        bool error =3D false;
+
         VERIFY_PERMISSION(OPT_P_UP);
-        if (ip_or_dns_addr_safe(p[1], options->allow_pull_fqdn) && ip_or_d=
ns_addr_safe(p[2], options->allow_pull_fqdn)) /* FQDN -- may be DNS name */
+        if (!p[2]) /* p[1] must be in CIDR format */
         {
+            unsigned int netbits =3D 0;
+            get_ip_addr(p[1], &netbits, msglevel, &error);
+            if (error || !netbits)
+            {
+                msg(msglevel, "ifconfig parm '%s' must be a valid address/=
bits", p[1]);
+                goto err;
+            }
+            options->ifconfig_local =3D strtok(p[1], "/");
+            /* convert netbits to netmask to unify the storage as string
+             * representation of in_addr_t variables and simplify parsing =
*/
+            options->ifconfig_remote_netmask =3D print_in_addr_t(netbits_t=
o_netmask((int)netbits), 0, &options->gc);
+        }
+        else if (ip_or_dns_addr_safe(p[1], options->allow_pull_fqdn) && ip=
_or_dns_addr_safe(p[2], options->allow_pull_fqdn)) /* FQDN -- may be DNS na=
me */
+        {
+            /* don't suggest CIDR usage here since we don't know if it's a
+             * remote address or a netmask */
             options->ifconfig_local =3D p[1];
             options->ifconfig_remote_netmask =3D p[2];
         }
@@ -6999,35 +7019,62 @@
         VERIFY_PERMISSION(OPT_P_PERSIST_IP);
         options->persist_remote_ip =3D true;
     }
-    else if (streq(p[0], "client-nat") && p[1] && p[2] && p[3] && p[4] && =
!p[5])
+    else if (streq(p[0], "client-nat") && p[1] && p[2] && p[3] && !p[5])
     {
+        size_t i =3D 1;
+        const char *type =3D p[i++];
+        const char *network =3D p[i++];
+        const char *netmask =3D p[i+1] ? p[i++] : NULL;
+        const char *foreign_network =3D p[i];
+
         VERIFY_PERMISSION(OPT_P_ROUTE);
         cnol_check_alloc(options);
-        add_client_nat_to_option_list(options->client_nat, p[1], p[2], p[3=
], p[4], msglevel);
+        add_client_nat_to_option_list(options->client_nat, type, network, =
netmask, foreign_network, msglevel);
     }
     else if (streq(p[0], "route") && p[1] && !p[5])
     {
+        size_t i =3D 1;
+        char *cidr =3D strchr(p[i], '/');
+        if (cidr && !no_more_than_n_args(msglevel, p, 4, NM_QUOTE_HINT))
+        {
+            goto err;
+        }
+
         VERIFY_PERMISSION(OPT_P_ROUTE);
         rol_check_alloc(options);
         if (pull_mode)
         {
-            if (!ip_or_dns_addr_safe(p[1], options->allow_pull_fqdn) && !i=
s_special_addr(p[1])) /* FQDN -- may be DNS name */
+
+            const char *network =3D strtok(p[i++], "/"); /* this modifies =
p[1] */
+            if (!ip_or_dns_addr_safe(network, options->allow_pull_fqdn) &&=
 !is_special_addr(p[1])) /* FQDN -- may be DNS name */
             {
-                msg(msglevel, "route parameter network/IP '%s' must be a v=
alid address", p[1]);
+                msg(msglevel, "route parameter network/IP '%s' must be a v=
alid address or address/bits", p[1]);
                 goto err;
             }
-            if (p[2] && !ip_addr_dotted_quad_safe(p[2])) /* FQDN -- must b=
e IP address */
+            if (!cidr && p[i])
             {
-                msg(msglevel, "route parameter netmask '%s' must be an IP =
address", p[2]);
-                goto err;
+                if (!ip_addr_dotted_quad_safe(p[i++])) /* FQDN -- must be =
IP address */
+                {
+                    msg(msglevel, "route parameter netmask '%s' must be an=
 IP address", p[2]);
+                    goto err;
+                }
             }
-            if (p[3] && !ip_or_dns_addr_safe(p[3], options->allow_pull_fqd=
n) && !is_special_addr(p[3])) /* FQDN -- may be DNS name */
+            if (p[i] && !ip_or_dns_addr_safe(p[i], options->allow_pull_fqd=
n) && !is_special_addr(p[i])) /* FQDN -- may be DNS name */
             {
-                msg(msglevel, "route parameter gateway '%s' must be a vali=
d address", p[3]);
+                msg(msglevel, "route parameter gateway '%s' must be a vali=
d address", p[i]);
                 goto err;
             }
         }
-        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4]);
+
+        if (cidr)
+        {
+            *cidr =3D (char)('/'); /* restore the original CIDR notation f=
or p[1] */
+            add_route_to_option_list(options->routes, p[1], NULL, p[2], p[=
3]);
+        }
+        else
+        {
+            add_route_to_option_list(options->routes, p[1], p[2], p[3], p[=
4]);
+        }
     }
     else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
     {
@@ -7348,33 +7395,56 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->occ =3D false;
     }
-    else if (streq(p[0], "server") && p[1] && p[2] && !p[4])
+    else if (streq(p[0], "server") && p[1] && !p[4])
     {
         const int lev =3D M_WARN;
         bool error =3D false;
-        in_addr_t network, netmask;
+        in_addr_t network;
+        unsigned int netbits =3D 0;
+        size_t i =3D 1;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        network =3D get_ip_addr(p[1], lev, &error);
-        netmask =3D get_ip_addr(p[2], lev, &error);
-        if (error || !network || !netmask)
+        network =3D get_ip_addr(p[i++], &netbits, lev, &error);
+        if (netbits)
+        {
+            if (!no_more_than_n_args(msglevel, p, 3, NM_QUOTE_HINT))
+            {
+                goto err;
+            }
+        }
+        else
+        {
+            const in_addr_t netmask =3D get_ip_addr(p[i++], NULL, lev, &er=
ror);
+            const int nb =3D netmask_to_netbits2(netmask);
+            if (netmask && nb > 0)
+            {
+                netbits =3D nb;
+            }
+            else
+            {
+                msg(M_USAGE, "--server directive network/netmask combinati=
on is invalid");
+                goto err;
+            }
+        }
+
+        if (error || !network || !netbits)
         {
             msg(msglevel, "error parsing --server parameters");
             goto err;
         }
         options->server_defined =3D true;
         options->server_network =3D network;
-        options->server_netmask =3D netmask;
+        options->server_netbits =3D netbits;

-        if (p[3])
+        if (p[i])
         {
-            if (streq(p[3], "nopool"))
+            if (streq(p[i], "nopool"))
             {
                 options->server_flags |=3D SF_NOPOOL;
             }
             else
             {
-                msg(msglevel, "error parsing --server: %s is not a recogni=
zed flag", p[3]);
+                msg(msglevel, "error parsing --server: %s is not a recogni=
zed flag", p[i]);
                 goto err;
             }
         }
@@ -7403,25 +7473,42 @@
         options->server_network_ipv6 =3D network;
         options->server_netbits_ipv6 =3D netbits;
     }
-    else if (streq(p[0], "server-bridge") && p[1] && p[2] && p[3] && p[4] =
&& !p[5])
+    else if (streq(p[0], "server-bridge") && p[1] && p[2] && p[3] && !p[5])
     {
         const int lev =3D M_WARN;
         bool error =3D false;
-        in_addr_t ip, netmask, pool_start, pool_end;
+        in_addr_t ip, pool_start, pool_end;
+        unsigned int netbits =3D 0;
+        size_t i =3D 1;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ip =3D get_ip_addr(p[1], lev, &error);
-        netmask =3D get_ip_addr(p[2], lev, &error);
-        pool_start =3D get_ip_addr(p[3], lev, &error);
-        pool_end =3D get_ip_addr(p[4], lev, &error);
-        if (error || !ip || !netmask || !pool_start || !pool_end)
+        ip =3D get_ip_addr(p[i++], &netbits, lev, &error);
+        if (netbits)
+        {
+            if (!no_more_than_n_args(msglevel, p, 4, NM_QUOTE_HINT))
+            {
+                goto err;
+            }
+        }
+        else
+        {
+            const in_addr_t netmask =3D get_ip_addr(p[i++], NULL, lev, &er=
ror);
+            const int nb =3D netmask_to_netbits2(netmask);
+            if (netmask && nb > 0)
+            {
+                netbits =3D nb;
+            }
+        }
+        pool_start =3D get_ip_addr(p[i++], NULL, lev, &error);
+        pool_end =3D get_ip_addr(p[i], NULL, lev, &error);
+        if (error || !ip || !netbits || !pool_start || !pool_end)
         {
             msg(msglevel, "error parsing --server-bridge parameters");
             goto err;
         }
         options->server_bridge_defined =3D true;
         options->server_bridge_ip =3D ip;
-        options->server_bridge_netmask =3D netmask;
+        options->server_bridge_netbits =3D netbits;
         options->server_bridge_pool_start =3D pool_start;
         options->server_bridge_pool_end =3D pool_end;
     }
@@ -7456,15 +7543,26 @@
     {
         const int lev =3D M_WARN;
         bool error =3D false;
-        in_addr_t start, end, netmask =3D 0;
+        in_addr_t start, end;
+        unsigned int netbits =3D 0;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        start =3D get_ip_addr(p[1], lev, &error);
-        end =3D get_ip_addr(p[2], lev, &error);
-        if (p[3])
+        start =3D get_ip_addr(p[1], &netbits, lev, &error);
+        end =3D get_ip_addr(p[2], NULL, lev, &error);
+        if (!netbits && p[3])
         {
-            netmask =3D get_ip_addr(p[3], lev, &error);
+            const in_addr_t netmask =3D get_ip_addr(p[3], NULL, lev, NULL);
+            const int nb =3D netmask_to_netbits2(netmask);
+            if (netmask && nb >=3D 0)
+            {
+                netbits =3D nb;
+            }
         }
+        else if (netbits && !no_more_than_n_args(msglevel, p, 3, NM_QUOTE_=
HINT))
+        {
+            goto err;
+        }
+
         if (error)
         {
             msg(msglevel, "error parsing --ifconfig-pool parameters");
@@ -7478,10 +7576,7 @@
         options->ifconfig_pool_defined =3D true;
         options->ifconfig_pool_start =3D start;
         options->ifconfig_pool_end =3D end;
-        if (netmask)
-        {
-            options->ifconfig_pool_netmask =3D netmask;
-        }
+        options->ifconfig_pool_netbits =3D netbits;
     }
     else if (streq(p[0], "ifconfig-pool-persist") && p[1] && !p[3])
     {
@@ -7802,45 +7897,76 @@
         VERIFY_PERMISSION(OPT_P_INSTANCE);
         option_iroute_ipv6(options, p[1], msglevel);
     }
-    else if (streq(p[0], "ifconfig-push") && p[1] && p[2] && !p[4])
+    else if (streq(p[0], "ifconfig-push") && p[1] && !p[4])
     {
-        in_addr_t local, remote_netmask;
+        in_addr_t local, remote_netmask =3D 0;
+        unsigned int netbits;
+        size_t i =3D 1;

         VERIFY_PERMISSION(OPT_P_INSTANCE);
-        local =3D getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[1], 0, NUL=
L, NULL);
-        remote_netmask =3D getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[2=
], 0, NULL, NULL);
+        local =3D getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[i++], &net=
bits, 0, NULL, NULL);
+        if (netbits) /* convert netbits to netmask */
+        {
+            if (!no_more_than_n_args(msglevel, p, 3, NM_QUOTE_HINT))
+            {
+                goto err;
+            }
+            remote_netmask =3D netbits_to_netmask((int)netbits);
+        }
+        else if (p[i])
+        {
+            /* don't suggest CIDR usage here since we don't know if it's a
+             * remote address or a netmask */
+            remote_netmask =3D getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE,=
 p[i++], NULL, 0, NULL, NULL);
+        }
+
         if (local && remote_netmask)
         {
             options->push_ifconfig_defined =3D true;
             options->push_ifconfig_local =3D local;
             options->push_ifconfig_remote_netmask =3D remote_netmask;
-            if (p[3])
+            if (p[i])
             {
-                options->push_ifconfig_local_alias =3D getaddr(GETADDR_HOS=
T_ORDER|GETADDR_RESOLVE, p[3], 0, NULL, NULL);
+                options->push_ifconfig_local_alias =3D getaddr(GETADDR_HOS=
T_ORDER|GETADDR_RESOLVE, p[i], NULL, 0, NULL, NULL);
             }
         }
         else
         {
-            msg(msglevel, "cannot parse --ifconfig-push addresses");
+            msg(msglevel, "cannot parse --ifconfig-push parameters");
             goto err;
         }
     }
-    else if (streq(p[0], "ifconfig-push-constraint") && p[1] && p[2] && !p=
[3])
+    else if (streq(p[0], "ifconfig-push-constraint") && p[1] && !p[3])
     {
-        in_addr_t network, netmask;
+        in_addr_t network;
+        unsigned int netbits =3D 0;
+        size_t i =3D 1;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        network =3D getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[1], 0, N=
ULL, NULL);
-        netmask =3D getaddr(GETADDR_HOST_ORDER, p[2], 0, NULL, NULL);
-        if (network && netmask)
+        network =3D getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[i++], &n=
etbits, 0, NULL, NULL);
+        if (!netbits && p[i])
+        {
+            const in_addr_t netmask =3D getaddr(GETADDR_HOST_ORDER, p[2], =
NULL, 0, NULL, NULL);
+            const int nb =3D netmask_to_netbits2(netmask);
+            if (netmask && nb > 0)
+            {
+                netbits =3D nb;
+            }
+        }
+        else if (netbits && !no_more_than_n_args(msglevel, p, 2, NM_QUOTE_=
HINT))
+        {
+            goto err;
+        }
+
+        if (network && netbits)
         {
             options->push_ifconfig_constraint_defined =3D true;
             options->push_ifconfig_constraint_network =3D network;
-            options->push_ifconfig_constraint_netmask =3D netmask;
+            options->push_ifconfig_constraint_netbits =3D netbits;
         }
         else
         {
-            msg(msglevel, "cannot parse --ifconfig-push-constraint address=
es");
+            msg(msglevel, "cannot parse --ifconfig-push-constraint paramet=
ers");
             goto err;
         }
     }
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f608cb8..88de24c 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -450,7 +450,7 @@
     const char *tmp_dir;
     bool server_defined;
     in_addr_t server_network;
-    in_addr_t server_netmask;
+    unsigned int server_netbits;
     bool server_ipv6_defined;                           /* IPv6 */
     struct in6_addr server_network_ipv6;                /* IPv6 */
     unsigned int server_netbits_ipv6;                   /* IPv6 */
@@ -464,7 +464,7 @@

     bool server_bridge_defined;
     in_addr_t server_bridge_ip;
-    in_addr_t server_bridge_netmask;
+    unsigned int server_bridge_netbits;
     in_addr_t server_bridge_pool_start;
     in_addr_t server_bridge_pool_end;

@@ -472,7 +472,7 @@
     bool ifconfig_pool_defined;
     in_addr_t ifconfig_pool_start;
     in_addr_t ifconfig_pool_end;
-    in_addr_t ifconfig_pool_netmask;
+    unsigned int ifconfig_pool_netbits;
     const char *ifconfig_pool_persist_filename;
     int ifconfig_pool_persist_refresh_freq;

@@ -499,7 +499,7 @@
     in_addr_t push_ifconfig_local_alias;
     bool push_ifconfig_constraint_defined;
     in_addr_t push_ifconfig_constraint_network;
-    in_addr_t push_ifconfig_constraint_netmask;
+    unsigned int push_ifconfig_constraint_netbits;
     bool push_ifconfig_ipv4_blocked;                    /* IPv4 */
     bool push_ifconfig_ipv6_defined;                    /* IPv6 */
     struct in6_addr push_ifconfig_ipv6_local;           /* IPv6 */
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index e3c3708..84227b6 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -652,8 +652,8 @@
             if (strlen(ip_buf) > 0)
             {
                 bool v4_ok =3D true;
-                in_addr_t addr =3D getaddr(GETADDR_HOST_ORDER, ip_buf, 0, =
&v4_ok,
-                                         NULL);
+                in_addr_t addr =3D getaddr(GETADDR_HOST_ORDER, ip_buf, NUL=
L, 0,
+                                         &v4_ok, NULL);

                 if (!v4_ok)
                 {
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6c06374..b8ab470 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -1136,9 +1136,20 @@
                 if (p[0] && !strcmp(p[0], "route") && !p[3] && o->iroutes)
                 {
                     /* get route parameters */
-                    bool status1, status2;
-                    const in_addr_t network =3D getaddr(GETADDR_HOST_ORDER=
, p[1], 0, &status1, NULL);
-                    const in_addr_t netmask =3D getaddr(GETADDR_HOST_ORDER=
, p[2] ? p[2] : "255.255.255.255", 0, &status2, NULL);
+                    bool status1, status2 =3D true;
+                    int netbits =3D -1;
+
+                    /* get netbits from CIDR or convert netmask to netbits=
 */
+                    const in_addr_t network =3D getaddr(GETADDR_HOST_ORDER=
, p[1], (unsigned int *)&netbits, 0, &status1, NULL);
+                    if (p[2])
+                    {
+                        const in_addr_t netmask =3D getaddr(GETADDR_HOST_O=
RDER, p[2], NULL, 0, &status2, NULL);
+                        netbits =3D netmask_to_netbits2(netmask);
+                    }
+                    if (netbits <=3D 0)
+                    {
+                        netbits =3D 32;
+                    }

                     /* did route parameters parse correctly? */
                     if (status1 && status2)
@@ -1148,7 +1159,7 @@
                         /* does route match an iroute? */
                         for (ir =3D o->iroutes; ir !=3D NULL; ir =3D ir->n=
ext)
                         {
-                            if (network =3D=3D ir->network && netmask =3D=
=3D netbits_to_netmask(ir->netbits >=3D 0 ? ir->netbits : 32))
+                            if (network =3D=3D ir->network && netbits =3D=
=3D (ir->netbits >=3D 0 ? ir->netbits : 32))
                             {
                                 enable =3D false;
                                 break;
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 91f2032..ee77875 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -189,9 +189,9 @@
 route_string(const struct route_ipv4 *r, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
-    buf_printf(&out, "ROUTE network %s netmask %s gateway %s",
+    buf_printf(&out, "ROUTE network %s/%d gateway %s",
                print_in_addr_t(r->network, 0, gc),
-               print_in_addr_t(r->netmask, 0, gc),
+               r->netbits,
                print_in_addr_t(r->gateway, 0, gc)
                );
     if (r->flags & RT_METRIC_DEFINED)
@@ -321,11 +321,17 @@
            const struct route_option *ro,
            const struct route_list *rl)
 {
-    const in_addr_t default_netmask =3D IPV4_NETMASK_HOST;
+    const in_addr_t default_netbits =3D IPV4_NETBITS_HOST;
     bool status;
     int ret;
     struct in_addr special =3D {0};

+    /* separate address and prefix if present */
+    char *network =3D strdup(ro->network);
+    const char *cidr =3D strchr(network, '/');
+    const char *addr =3D strtok(network, "/");
+    const char *prefix =3D strtok(NULL, "/");
+
     CLEAR(*r);
     r->option =3D ro;

@@ -355,7 +361,7 @@
     else
     {
         ret =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_WARN_ON_SIGN=
AL,
-                                  ro->network, NULL, 0, NULL, AF_INET, net=
work_list);
+                                  addr, NULL, 0, NULL, AF_INET, network_li=
st);
     }

     status =3D (ret =3D=3D 0);
@@ -365,25 +371,40 @@
         goto fail;
     }

-    /* netmask */
+    /* netbits */

+    r->netbits =3D default_netbits;
     if (is_route_parm_defined(ro->netmask))
     {
-        r->netmask =3D getaddr(
+        const in_addr_t netmask =3D getaddr(
             GETADDR_HOST_ORDER
             | GETADDR_WARN_ON_SIGNAL,
             ro->netmask,
+            NULL,
             0,
             &status,
             NULL);
-        if (!status)
+        const int netbits =3D netmask_to_netbits2(netmask);
+
+        if (!status || netbits < 0)
         {
             goto fail;
         }
+        r->netbits =3D netbits;
     }
-    else
+    else if (cidr)
     {
-        r->netmask =3D default_netmask;
+        if (!prefix) /* handle 'aa.bb.cc.dd/' case */
+        {
+            goto fail;
+        }
+        char *endp =3D NULL;
+        const unsigned long netbits =3D strtoul(prefix, &endp, 10);
+        if ((*endp !=3D '\0') || (netbits > sizeof(in_addr_t) * 8))
+        {
+            goto fail;
+        }
+        r->netbits =3D netbits;
     }

     /* gateway */
@@ -397,6 +418,7 @@
                 | GETADDR_HOST_ORDER
                 | GETADDR_WARN_ON_SIGNAL,
                 ro->gateway,
+                NULL,
                 0,
                 &status,
                 NULL);
@@ -428,7 +450,7 @@
         if (r->metric < 0)
         {
             msg(M_WARN, PACKAGE_NAME " ROUTE: route metric for network %s =
(%s) must be >=3D 0",
-                ro->network,
+                addr,
                 ro->metric);
             goto fail;
         }
@@ -442,11 +464,13 @@

     r->flags |=3D RT_DEFINED;

+    free(network);
     return true;

 fail:
     msg(M_WARN, PACKAGE_NAME " ROUTE: failed to parse/resolve route for ho=
st/network: %s",
         ro->network);
+    free(network);
     return false;
 }

@@ -516,7 +540,7 @@
     struct route_option *ro;
     ALLOC_OBJ_GC(ro, struct route_option, l->gc);
     ro->network =3D network;
-    ro->netmask =3D netmask;
+    ro->netmask =3D netmask; /* NULL if network has CIDR notation */
     ro->gateway =3D gateway;
     ro->metric =3D metric;
     ro->next =3D l->routes;
@@ -582,7 +606,7 @@
         r1->flags =3D RT_DEFINED;
         r1->gateway =3D target;
         r1->network =3D gateway->addr & gateway->netmask;
-        r1->netmask =3D ~(l2-1);
+        r1->netbits =3D netmask_to_netbits2(gateway->netmask) + 1;
         r1->next =3D rl->routes;
         rl->routes =3D r1;

@@ -681,6 +705,7 @@
             | GETADDR_HOST_ORDER
             | GETADDR_WARN_ON_SIGNAL,
             remote_endpoint,
+            NULL,
             0,
             &defined,
             NULL);
@@ -921,7 +946,7 @@

 static bool
 add_route3(in_addr_t network,
-           in_addr_t netmask,
+           unsigned int netbits,
            in_addr_t gateway,
            const struct tuntap *tt,
            unsigned int flags,
@@ -933,14 +958,14 @@
     CLEAR(r);
     r.flags =3D RT_DEFINED;
     r.network =3D network;
-    r.netmask =3D netmask;
+    r.netbits =3D netbits;
     r.gateway =3D gateway;
     return add_route(&r, tt, flags, rgi, es, ctx);
 }

 static void
 del_route3(in_addr_t network,
-           in_addr_t netmask,
+           unsigned int netbits,
            in_addr_t gateway,
            const struct tuntap *tt,
            unsigned int flags,
@@ -952,7 +977,7 @@
     CLEAR(r);
     r.flags =3D RT_DEFINED|RT_ADDED;
     r.network =3D network;
-    r.netmask =3D netmask;
+    r.netbits =3D netbits;
     r.gateway =3D gateway;
     delete_route(&r, tt, flags, rgi, es, ctx);
 }
@@ -971,7 +996,7 @@
     {
         if (rb->bypass[i])
         {
-            ret =3D add_route3(rb->bypass[i], IPV4_NETMASK_HOST, gateway, =
tt,
+            ret =3D add_route3(rb->bypass[i], IPV4_NETBITS_HOST, gateway, =
tt,
                              flags | ROUTE_REF_GW, rgi, es, ctx) && ret;
         }
     }
@@ -993,7 +1018,7 @@
         if (rb->bypass[i])
         {
             del_route3(rb->bypass[i],
-                       IPV4_NETMASK_HOST,
+                       IPV4_NETBITS_HOST,
                        gateway,
                        tt,
                        flags | ROUTE_REF_GW,
@@ -1057,7 +1082,7 @@
                 if ((rl->spec.flags & RTSA_REMOTE_HOST)
                     && rl->spec.remote_host !=3D IPV4_INVALID_ADDR)
                 {
-                    ret =3D add_route3(rl->spec.remote_host, IPV4_NETMASK_=
HOST,
+                    ret =3D add_route3(rl->spec.remote_host, IPV4_NETBITS_=
HOST,
                                      rl->rgi.gateway.addr, tt, flags | ROU=
TE_REF_GW,
                                      &rl->rgi, es, ctx);
                     rl->iflags |=3D RL_DID_LOCAL;
@@ -1078,11 +1103,11 @@
                 if (rl->flags & RG_DEF1)
                 {
                     /* add new default route (1st component) */
-                    ret =3D add_route3(0x00000000, 0x80000000, rl->spec.re=
mote_endpoint,
+                    ret =3D add_route3(0x00000000, 1, rl->spec.remote_endp=
oint,
                                      tt, flags, &rl->rgi, es, ctx) && ret;

                     /* add new default route (2nd component) */
-                    ret =3D add_route3(0x80000000, 0x80000000, rl->spec.re=
mote_endpoint,
+                    ret =3D add_route3(0x80000000, 1, rl->spec.remote_endp=
oint,
                                      tt, flags, &rl->rgi, es, ctx) && ret;
                 }
                 else
@@ -1120,7 +1145,7 @@
         if (rl->iflags & RL_DID_LOCAL)
         {
             del_route3(rl->spec.remote_host,
-                       IPV4_NETMASK_HOST,
+                       IPV4_NETBITS_HOST,
                        rl->rgi.gateway.addr,
                        tt,
                        flags | ROUTE_REF_GW,
@@ -1140,7 +1165,7 @@
             {
                 /* delete default route (1st component) */
                 del_route3(0x00000000,
-                           0x80000000,
+                           1,
                            rl->spec.remote_endpoint,
                            tt,
                            flags,
@@ -1150,7 +1175,7 @@

                 /* delete default route (2nd component) */
                 del_route3(0x80000000,
-                           0x80000000,
+                           1,
                            rl->spec.remote_endpoint,
                            tt,
                            flags,
@@ -1215,7 +1240,7 @@

         for (r =3D rl->routes; r; r =3D r->next)
         {
-            check_subnet_conflict(r->network, r->netmask, "route");
+            check_subnet_conflict(r->network, netbits_to_netmask((int)r->n=
etbits), "route");
             if (flags & ROUTE_DELETE_FIRST)
             {
                 delete_route(r, tt, flags, &rl->rgi, es, ctx);
@@ -1432,14 +1457,18 @@
     if (r->flags & RT_DEFINED)
     {
         setenv_route_addr(es, "network", r->network, i);
-        setenv_route_addr(es, "netmask", r->netmask, i);
+        setenv_route_addr(es, "netmask", netbits_to_netmask(r->netbits), i=
);
         setenv_route_addr(es, "gateway", r->gateway, i);

+        struct buffer name1 =3D alloc_buf_gc(256, &gc);
+        buf_printf(&name1, "route_netbits_%d", i);
+        setenv_int(es, BSTR(&name1), (int)r->netbits);
+
         if (r->flags & RT_METRIC_DEFINED)
         {
-            struct buffer name =3D alloc_buf_gc(256, &gc);
-            buf_printf(&name, "route_metric_%d", i);
-            setenv_int(es, BSTR(&name), r->metric);
+            struct buffer name2 =3D alloc_buf_gc(256, &gc);
+            buf_printf(&name2, "route_metric_%d", i);
+            setenv_int(es, BSTR(&name2), r->metric);
         }
     }
     gc_free(&gc);
@@ -1519,7 +1548,7 @@

 static int
 local_route(in_addr_t network,
-            in_addr_t netmask,
+            unsigned int netbits,
             in_addr_t gateway,
             const struct route_gateway_info *rgi)
 {
@@ -1528,7 +1557,7 @@
     if (rgi
         && (rgi->flags & rgi_needed) =3D=3D rgi_needed
         && gateway =3D=3D rgi->gateway.addr
-        && netmask =3D=3D 0xFFFFFFFF)
+        && netbits =3D=3D IPV4_NETBITS_HOST)
     {
         if (((network ^  rgi->gateway.addr) & rgi->gateway.netmask) =3D=3D=
 0)
         {
@@ -1583,12 +1612,12 @@
 #if !defined(TARGET_LINUX)
     const char *network =3D print_in_addr_t(r->network, 0, &gc);
 #if !defined(TARGET_AIX)
-    const char *netmask =3D print_in_addr_t(r->netmask, 0, &gc);
+    const char *netmask =3D print_in_addr_t(netbits_to_netmask((int)r->net=
bits), 0, &gc);
 #endif
     const char *gateway =3D print_in_addr_t(r->gateway, 0, &gc);
 #endif

-    is_local_route =3D local_route(r->network, r->netmask, r->gateway, rgi=
);
+    is_local_route =3D local_route(r->network, r->netbits, r->gateway, rgi=
);
     if (is_local_route =3D=3D LR_ERROR)
     {
         goto done;
@@ -1609,7 +1638,7 @@
     }

     status =3D RTA_SUCCESS;
-    int ret =3D net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->=
netmask),
+    int ret =3D net_route_v4_add(ctx, &r->network, (int)r->netbits,
                                &r->gateway, iface, 0, metric);
     if (ret =3D=3D -EEXIST)
     {
@@ -1840,10 +1869,9 @@
 #elif defined(TARGET_AIX)

     {
-        int netbits =3D netmask_to_netbits2(r->netmask);
         argv_printf(&argv, "%s add -net %s/%d %s",
                     ROUTE_PATH,
-                    network, netbits, gateway);
+                    network, r->netbits, gateway);
         argv_msg(D_ROUTE, &argv);
         bool ret =3D openvpn_execve_check(&argv, es, 0,
                                         "ERROR: AIX route add command fail=
ed");
@@ -2176,14 +2204,14 @@
 #if !defined(TARGET_LINUX)
     network =3D print_in_addr_t(r->network, 0, &gc);
 #if !defined(TARGET_AIX)
-    netmask =3D print_in_addr_t(r->netmask, 0, &gc);
+    netmask =3D print_in_addr_t(netbits_to_netmask((int)r->netbits), 0, &g=
c);
 #endif
 #if !defined(TARGET_ANDROID)
     gateway =3D print_in_addr_t(r->gateway, 0, &gc);
 #endif
 #endif

-    is_local_route =3D local_route(r->network, r->netmask, r->gateway, rgi=
);
+    is_local_route =3D local_route(r->network, r->netbits, r->gateway, rgi=
);
     if (is_local_route =3D=3D LR_ERROR)
     {
         goto done;
@@ -2196,7 +2224,7 @@
         metric =3D r->metric;
     }

-    if (net_route_v4_del(ctx, &r->network, netmask_to_netbits2(r->netmask),
+    if (net_route_v4_del(ctx, &r->network, (int)r->netbits,
                          &r->gateway, NULL, 0, metric) < 0)
     {
         msg(M_WARN, "ERROR: Linux route delete command failed");
@@ -2318,10 +2346,9 @@
 #elif defined(TARGET_AIX)

     {
-        int netbits =3D netmask_to_netbits2(r->netmask);
         argv_printf(&argv, "%s delete -net %s/%d %s",
                     ROUTE_PATH,
-                    network, netbits, gateway);
+                    network, r->netbits, gateway);
         argv_msg(D_ROUTE, &argv);
         openvpn_execve_check(&argv, es, 0, "ERROR: AIX route delete comman=
d failed");
     }
@@ -2840,13 +2867,14 @@
     int ret =3D RTA_ERROR;
     DWORD status;
     const DWORD if_index =3D (adapter_index =3D=3D TUN_ADAPTER_INDEX_INVAL=
ID) ? windows_route_find_if_index(r, tt) : adapter_index;
+    const in_addr_t netmask =3D netbits_to_netmask((int)r->netbits);

     if (if_index !=3D TUN_ADAPTER_INDEX_INVALID)
     {
         MIB_IPFORWARDROW fr;
         CLEAR(fr);
         fr.dwForwardDest =3D htonl(r->network);
-        fr.dwForwardMask =3D htonl(r->netmask);
+        fr.dwForwardMask =3D htonl(netmask);
         fr.dwForwardPolicy =3D 0;
         fr.dwForwardNextHop =3D htonl(r->gateway);
         fr.dwForwardIfIndex =3D if_index;
@@ -2860,11 +2888,11 @@
         fr.dwForwardMetric4 =3D METRIC_NOT_USED;
         fr.dwForwardMetric5 =3D METRIC_NOT_USED;

-        if ((r->network & r->netmask) !=3D r->network)
+        if ((r->network & netmask) !=3D r->network)
         {
             msg(M_WARN, "Warning: address %s is not a network address in r=
elation to netmask %s",
                 print_in_addr_t(r->network, 0, &gc),
-                print_in_addr_t(r->netmask, 0, &gc));
+                print_in_addr_t(netmask, 0, &gc));
         }

         status =3D CreateIpForwardEntry(&fr);
@@ -2932,6 +2960,7 @@
     bool ret =3D false;
     DWORD status;
     const DWORD if_index =3D windows_route_find_if_index(r, tt);
+    const in_addr_t netmask =3D netbits_to_netmask((int)r->netbits);

     if (if_index !=3D TUN_ADAPTER_INDEX_INVALID)
     {
@@ -2939,7 +2968,7 @@
         CLEAR(fr);

         fr.dwForwardDest =3D htonl(r->network);
-        fr.dwForwardMask =3D htonl(r->netmask);
+        fr.dwForwardMask =3D htonl(netmask);
         fr.dwForwardPolicy =3D 0;
         fr.dwForwardNextHop =3D htonl(r->gateway);
         fr.dwForwardIfIndex =3D if_index;
@@ -3016,7 +3045,7 @@
         .metric =3D (r->flags & RT_METRIC_DEFINED ? r->metric : -1)
     };

-    netmask_to_netbits(r->network, r->netmask, &msg.prefix_len);
+    msg.prefix_len =3D r->netbits;
     if (msg.prefix_len =3D=3D -1)
     {
         msg.prefix_len =3D 32;
@@ -3996,7 +4025,7 @@
     while (iplist)
     {
         bool succeed =3D false;
-        const in_addr_t ip =3D getaddr(GETADDR_HOST_ORDER, iplist->IpAddre=
ss.String, 0, &succeed, NULL);
+        const in_addr_t ip =3D getaddr(GETADDR_HOST_ORDER, iplist->IpAddre=
ss.String, NULL, 0, &succeed, NULL);
         if (succeed)
         {
             add_host_route_if_nonlocal(rb, ip);
@@ -4096,7 +4125,7 @@
 {
     if (rgi)
     {
-        if (local_route(addr, 0xFFFFFFFF, rgi->gateway.addr, rgi))
+        if (local_route(addr, IPV4_NETBITS_HOST, rgi->gateway.addr, rgi))
         {
             return TLA_LOCAL;
         }
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 421e7d2..a117584 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -117,7 +117,7 @@
     unsigned int flags;
     const struct route_option *option;
     in_addr_t network;
-    in_addr_t netmask;
+    unsigned int netbits;
     in_addr_t gateway;
     int metric;
 };
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 17c5e76..767036f 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -179,6 +179,7 @@
 in_addr_t
 getaddr(unsigned int flags,
         const char *hostname,
+        unsigned int *netbits,
         int resolve_retry_seconds,
         bool *succeeded,
         struct signal_info *sig_info)
@@ -186,7 +187,7 @@
     in_addr_t addr;
     int status;

-    status =3D get_addr_generic(AF_INET, flags, hostname, &addr, NULL,
+    status =3D get_addr_generic(AF_INET, flags, hostname, &addr, netbits,
                               resolve_retry_seconds, sig_info,
                               M_WARN);
     if (status=3D=3D0)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 47083ad..f6165b2 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -524,6 +524,7 @@
  */
 in_addr_t getaddr(unsigned int flags,
                   const char *hostname,
+                  unsigned int *netbits,
                   int resolve_retry_seconds,
                   bool *succeeded,
                   struct signal_info *sig_info);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 739e008..52e2464 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -113,7 +113,7 @@
     if (addr.family =3D=3D AF_INET)
     {
         addr.address.ipv4.s_addr =3D htonl(tt->local);
-        addr.prefix_len =3D netmask_to_netbits2(tt->adapter_netmask);
+        addr.prefix_len =3D tt->netbits;
         msg(D_IFCONFIG, "INET address service: %s %s/%d",
             add ? "add" : "remove",
             print_in_addr_t(tt->local, 0, &gc), addr.prefix_len);
@@ -499,17 +499,17 @@
 static const char ifconfig_warn_how_to_silence[] =3D "(silence this warnin=
g with --ifconfig-nowarn)";

 /*
- * If !tun_p2p, make sure ifconfig_remote_netmask looks
- *  like a netmask.
+ * If !tun_p2p, make sure either ifconfig_netbits is
+ * set or ifconfig_remote looks like a netmask.
  *
- * If tun_p2p, make sure ifconfig_remote_netmask looks
+ * If tun_p2p, make sure ifconfig_remote looks
  *  like an IPv4 address.
  */
 static void
-ifconfig_sanity_check(bool tun_p2p, in_addr_t addr)
+ifconfig_sanity_check(bool tun_p2p, in_addr_t addr, int netbits)
 {
     struct gc_arena gc =3D gc_new();
-    const bool looks_like_netmask =3D ((addr & 0xFF000000) =3D=3D 0xFF0000=
00);
+    const bool looks_like_netmask =3D addr && ((addr & 0xFF000000) =3D=3D =
0xFF000000);
     if (tun_p2p)
     {
         if (looks_like_netmask)
@@ -521,9 +521,11 @@
     }
     else
     {
-        if (!looks_like_netmask)
+        if (netbits < 0 || !looks_like_netmask)
         {
-            msg(M_WARN, "WARNING: Since you are using subnet topology, the=
 second argument to --ifconfig must be a netmask, for example something lik=
e 255.255.255.0. %s",
+            msg(M_WARN, "WARNING: Since you are using topology subnet, you=
 must either "
+                "provide a valid prefix length in the first argument of --=
ifconfig (eg. 10.8.0.0/24) "
+                "or a valid netmask as the second argument (eg. 255.255.25=
5.0). %s",
                 ifconfig_warn_how_to_silence);
         }
     }
@@ -539,34 +541,36 @@
                  int type,
                  in_addr_t public,
                  in_addr_t local,
-                 in_addr_t remote_netmask)
+                 in_addr_t remote,
+                 int netbits)
 {
     struct gc_arena gc =3D gc_new();
 #if 0
-    msg(M_INFO, "CHECK_ADDR_CLASH type=3D%d public=3D%s local=3D%s, remote=
_netmask=3D%s",
+    msg(M_INFO, "CHECK_ADDR_CLASH type=3D%d public=3D%s local=3D%s, netbit=
s=3D%d, remote=3D%s",
         type,
         print_in_addr_t(public, 0, &gc),
         print_in_addr_t(local, 0, &gc),
-        print_in_addr_t(remote_netmask, 0, &gc));
+        netbits,
+        print_in_addr_t(remote, 0, &gc));
 #endif

     if (public)
     {
         if (type =3D=3D DEV_TYPE_TUN)
         {
-            const in_addr_t test_netmask =3D 0xFFFFFF00;
-            const in_addr_t public_net =3D public &test_netmask;
-            const in_addr_t local_net =3D local & test_netmask;
-            const in_addr_t remote_net =3D remote_netmask & test_netmask;
+            const in_addr_t netmask =3D netbits < 0 ? 0xFFFFFF00 : netbits=
_to_netmask(netbits);
+            const in_addr_t public_net =3D public &netmask;
+            const in_addr_t local_net =3D local & netmask;
+            const in_addr_t remote_net =3D remote & netmask;

-            if (public =3D=3D local || public =3D=3D remote_netmask)
+            if (public =3D=3D local || public =3D=3D remote)
             {
                 msg(M_WARN,
                     "WARNING: --%s address [%s] conflicts with --ifconfig =
address pair [%s, %s]. %s",
                     name,
                     print_in_addr_t(public, 0, &gc),
                     print_in_addr_t(local, 0, &gc),
-                    print_in_addr_t(remote_netmask, 0, &gc),
+                    print_in_addr_t(remote, 0, &gc),
                     ifconfig_warn_how_to_silence);
             }

@@ -577,22 +581,23 @@
                     name,
                     print_in_addr_t(public, 0, &gc),
                     print_in_addr_t(local, 0, &gc),
-                    print_in_addr_t(remote_netmask, 0, &gc),
+                    print_in_addr_t(remote ? remote : netmask, 0, &gc),
                     ifconfig_warn_how_to_silence);
             }
         }
         else if (type =3D=3D DEV_TYPE_TAP)
         {
-            const in_addr_t public_network =3D public &remote_netmask;
-            const in_addr_t virtual_network =3D local & remote_netmask;
-            if (public_network =3D=3D virtual_network)
+            const in_addr_t netmask =3D netbits_to_netmask(netbits);
+            const in_addr_t public_network =3D public &netmask;
+            const in_addr_t virtual_network =3D local & netmask;
+            if (netmask && public_network =3D=3D virtual_network)
             {
                 msg(M_WARN,
-                    "WARNING: --%s address [%s] conflicts with --ifconfig =
subnet [%s, %s] -- local and remote addresses cannot be inside of the --ifc=
onfig subnet. %s",
+                    "WARNING: --%s address [%s] conflicts with --ifconfig =
subnet [%s/%d] -- local and remote addresses cannot be inside of the --ifco=
nfig subnet. %s",
                     name,
                     print_in_addr_t(public, 0, &gc),
                     print_in_addr_t(local, 0, &gc),
-                    print_in_addr_t(remote_netmask, 0, &gc),
+                    netbits,
                     ifconfig_warn_how_to_silence);
             }
         }
@@ -669,9 +674,10 @@
     {
         if (!is_tun_p2p(tt))
         {
+            const in_addr_t netmask =3D netbits_to_netmask(tt->netbits);
             buf_printf(&out, "%s %s",
-                       print_in_addr_t(tt->local & tt->remote_netmask, 0, =
gc),
-                       print_in_addr_t(tt->remote_netmask, 0, gc));
+                       print_in_addr_t(tt->local & netmask, 0, gc),
+                       print_in_addr_t(netmask, 0, gc));
         }
         else if (tt->type =3D=3D DEV_TYPE_TUN) /* tun p2p topology */
         {
@@ -679,12 +685,12 @@
             if (remote)
             {
                 r =3D print_in_addr_t(tt->local, 0, gc);
-                l =3D print_in_addr_t(tt->remote_netmask, 0, gc);
+                l =3D print_in_addr_t(tt->remote, 0, gc);
             }
             else
             {
                 l =3D print_in_addr_t(tt->local, 0, gc);
-                r =3D print_in_addr_t(tt->remote_netmask, 0, gc);
+                r =3D print_in_addr_t(tt->remote, 0, gc);
             }
             buf_printf(&out, "%s %s", r, l);
         }
@@ -765,7 +771,8 @@
 {
     struct gc_arena gc =3D gc_new();
     const char *ifconfig_local =3D print_in_addr_t(tt->local, 0, &gc);
-    const char *ifconfig_remote_netmask =3D print_in_addr_t(tt->remote_net=
mask, 0, &gc);
+    const char *ifconfig_remote =3D tt->remote ? print_in_addr_t(tt->remot=
e, 0, &gc) : NULL;
+    const char *ifconfig_netmask =3D tt->netbits >=3D 0 ? print_in_addr_t(=
netbits_to_netmask(tt->netbits), 0, &gc) : NULL;

     /*
      * Set environmental variables with ifconfig parameters.
@@ -777,11 +784,12 @@
         setenv_str(es, "ifconfig_local", ifconfig_local);
         if (tun)
         {
-            setenv_str(es, "ifconfig_remote", ifconfig_remote_netmask);
+            setenv_str(es, "ifconfig_remote", ifconfig_remote);
         }
         else
         {
-            setenv_str(es, "ifconfig_netmask", ifconfig_remote_netmask);
+            setenv_int(es, "ifconfig_netbits", tt->netbits);
+            setenv_str(es, "ifconfig_netmask", ifconfig_netmask);
         }
     }

@@ -837,7 +845,7 @@
         bool tun_p2p =3D is_tun_p2p(tt);

         /*
-         * Convert arguments to binary IPv4 addresses.
+         * Convert arguments to binary IPv4 addresses and netbits.
          */

         tt->local =3D getaddr(
@@ -846,27 +854,48 @@
             | GETADDR_FATAL_ON_SIGNAL
             | GETADDR_FATAL,
             ifconfig_local_parm,
+            NULL,
             0,
             NULL,
             NULL);

-        tt->remote_netmask =3D getaddr(
+        tt->remote =3D getaddr(
             (tun_p2p ? GETADDR_RESOLVE : 0)
             | GETADDR_HOST_ORDER
             | GETADDR_FATAL_ON_SIGNAL
             | GETADDR_FATAL,
             ifconfig_remote_netmask_parm,
+            NULL,
             0,
             NULL,
             NULL);

+        /* in p2p mode discard the netbits otherwise discard the remote */
+        if (!tun_p2p)
+        {
+            if (tt->remote)
+            {
+                tt->netbits =3D netmask_to_netbits2(tt->remote);
+                tt->remote =3D 0;
+            }
+            else
+            {
+                msg(M_FATAL, "init_tun: can not figure out the subnet from=
 the remote parameter (%s)", ifconfig_remote_netmask_parm);
+            }
+            tt->remote =3D 0;
+        }
+        else
+        {
+            tt->netbits =3D -1;
+        }
+
         /*
          * Look for common errors in --ifconfig parms
          */
         if (strict_warn)
         {
             struct addrinfo *curele;
-            ifconfig_sanity_check(tun_p2p, tt->remote_netmask);
+            ifconfig_sanity_check(tun_p2p, tt->remote, tt->netbits);

             /*
              * If local_public or remote_public addresses are defined,
@@ -877,11 +906,13 @@
             {
                 if (curele->ai_family =3D=3D AF_INET)
                 {
+                    const in_addr_t local =3D ntohl(((struct sockaddr_in *=
)curele->ai_addr)->sin_addr.s_addr);
                     check_addr_clash("local",
                                      tt->type,
-                                     ((struct sockaddr_in *)curele->ai_add=
r)->sin_addr.s_addr,
+                                     local,
                                      tt->local,
-                                     tt->remote_netmask);
+                                     tt->remote,
+                                     tt->netbits);
                 }
             }

@@ -889,17 +920,19 @@
             {
                 if (curele->ai_family =3D=3D AF_INET)
                 {
+                    const in_addr_t remote =3D ntohl(((struct sockaddr_in =
*)curele->ai_addr)->sin_addr.s_addr);
                     check_addr_clash("remote",
                                      tt->type,
-                                     ((struct sockaddr_in *)curele->ai_add=
r)->sin_addr.s_addr,
+                                     remote,
                                      tt->local,
-                                     tt->remote_netmask);
+                                     tt->remote,
+                                     tt->netbits);
                 }
             }

             if (!tun_p2p)
             {
-                check_subnet_conflict(tt->local, tt->remote_netmask, "TUN/=
TAP adapter");
+                check_subnet_conflict(tt->local, netbits_to_netmask(tt->ne=
tbits), "TUN/TAP adapter");
             }
             else
             {
@@ -914,12 +947,12 @@
          */
         if (tun_p2p)
         {
-            verify_255_255_255_252(tt->local, tt->remote_netmask);
+            verify_255_255_255_252(tt->local, tt->remote);
             tt->adapter_netmask =3D ~3;
         }
         else
         {
-            tt->adapter_netmask =3D tt->remote_netmask;
+            tt->adapter_netmask =3D netbits_to_netmask(tt->netbits);
         }
 #endif

@@ -1062,8 +1095,9 @@
 create_arbitrary_remote( struct tuntap *tt )
 {
     in_addr_t remote;
+    const in_addr_t netmask =3D netbits_to_netmask(tt->netbits);

-    remote =3D (tt->local & tt->remote_netmask) +1;
+    remote =3D (tt->local & netmask) +1;

     if (remote =3D=3D tt->local)
     {
@@ -1300,7 +1334,13 @@

 #if !defined(TARGET_LINUX)
     const char *ifconfig_local =3D NULL;
-    const char *ifconfig_remote_netmask =3D NULL;
+#if !defined(_WIN32)
+    const char *ifconfig_remote =3D NULL;
+#endif
+#if !defined(TARGET_FREEBSD) && !defined(TARGET_DRAGONFLY)
+    const char *ifconfig_netmask =3D NULL;
+    const in_addr_t netmask =3D netbits_to_netmask(tt->netbits);
+#endif
     struct argv argv =3D argv_new();
     struct gc_arena gc =3D gc_new();

@@ -1308,7 +1348,12 @@
      * Set ifconfig parameters
      */
     ifconfig_local =3D print_in_addr_t(tt->local, 0, &gc);
-    ifconfig_remote_netmask =3D print_in_addr_t(tt->remote_netmask, 0, &gc=
);
+#if !defined(_WIN32)
+    ifconfig_remote =3D print_in_addr_t(tt->remote, 0, &gc);
+#endif
+#if !defined(TARGET_FREEBSD) && !defined(TARGET_DRAGONFLY)
+    ifconfig_netmask =3D print_in_addr_t(netmask, 0, &gc);
+#endif
 #endif

 #if defined(TARGET_LINUX)
@@ -1324,16 +1369,14 @@

     if (tun_p2p)
     {
-        if (net_addr_ptp_v4_add(ctx, ifname, &tt->local,
-                                &tt->remote_netmask) < 0)
+        if (net_addr_ptp_v4_add(ctx, ifname, &tt->local, &tt->remote) < 0)
         {
             msg(M_FATAL, "Linux can't add IP to interface %s", ifname);
         }
     }
     else
     {
-        if (net_addr_v4_add(ctx, ifname, &tt->local,
-                            netmask_to_netbits2(tt->remote_netmask)) < 0)
+        if (net_addr_v4_add(ctx, ifname, &tt->local, tt->netbits) < 0)
         {
             msg(M_FATAL, "Linux can't add IP to interface %s", ifname);
         }
@@ -1341,9 +1384,14 @@
 #elif defined(TARGET_ANDROID)
     char out[64];

-    snprintf(out, sizeof(out), "%s %s %d %s", ifconfig_local,
-             ifconfig_remote_netmask, tun_mtu, print_topology(tt->topology=
));
+    snprintf(out, sizeof(out), "%s %s %d %s",
+             ifconfig_local,
+             ifconfig_remote ? ifconfig_remote : ifconfig_netmask,
+             tun_mtu,
+             print_topology(tt->topology));
     management_android_control(management, "IFCONFIG", out);
+    (void)ifconfig_netmask;
+    (void)netmask;

 #elif defined(TARGET_SOLARIS)
     /* Solaris 2.6 (and 7?) cannot set all parameters in one go...
@@ -1354,7 +1402,7 @@
     if (tun_p2p)
     {
         argv_printf(&argv, "%s %s %s %s mtu %d up", IFCONFIG_PATH, ifname,
-                    ifconfig_local, ifconfig_remote_netmask, tun_mtu);
+                    ifconfig_local, ifconfig_remote, tun_mtu);

         argv_msg(M_INFO, &argv);
         if (!openvpn_execve_check(&argv, es, 0, "Solaris ifconfig phase-1 =
failed"))
@@ -1369,13 +1417,13 @@
     {
         argv_printf(&argv, "%s %s %s %s netmask %s mtu %d up", IFCONFIG_PA=
TH,
                     ifname, ifconfig_local, ifconfig_local,
-                    ifconfig_remote_netmask, tun_mtu);
+                    ifconfig_netmask, tun_mtu);
     }
     else /* tap */
     {
         argv_printf(&argv, "%s %s %s netmask %s up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
-                    ifconfig_remote_netmask);
+                    ifconfig_netmask);
     }

     argv_msg(M_INFO, &argv);
@@ -1390,8 +1438,8 @@
         struct route_ipv4 r;
         CLEAR(r);
         r.flags =3D RT_DEFINED | RT_METRIC_DEFINED;
-        r.network =3D tt->local & tt->remote_netmask;
-        r.netmask =3D tt->remote_netmask;
+        r.network =3D tt->local & netmask;
+        r.netbits =3D tt->netbits;
         r.gateway =3D tt->local;
         r.metric =3D 0;
         add_route(&r, tt, 0, NULL, es, NULL);
@@ -1413,7 +1461,7 @@
         argv_printf(&argv,
                     "%s %s %s %s mtu %d netmask 255.255.255.255 up -link0",
                     IFCONFIG_PATH, ifname, ifconfig_local,
-                    ifconfig_remote_netmask, tun_mtu);
+                    ifconfig_remote, tun_mtu);
     }
     else if (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1421,13 +1469,13 @@
         argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up -link0",
                     IFCONFIG_PATH, ifname, ifconfig_local,
                     print_in_addr_t(remote_end, 0, &gc), tun_mtu,
-                    ifconfig_remote_netmask);
+                    ifconfig_netmask);
     }
     else /* tap */
     {
         argv_printf(&argv, "%s %s %s netmask %s mtu %d link0",
                     IFCONFIG_PATH, ifname, ifconfig_local,
-                    ifconfig_remote_netmask, tun_mtu);
+                    ifconfig_netmask, tun_mtu);
     }
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, S_FATAL, "OpenBSD ifconfig failed");
@@ -1438,8 +1486,8 @@
         struct route_ipv4 r;
         CLEAR(r);
         r.flags =3D RT_DEFINED;
-        r.network =3D tt->local & tt->remote_netmask;
-        r.netmask =3D tt->remote_netmask;
+        r.network =3D tt->local & netmask;
+        r.netbits =3D tt->netbits;
         r.gateway =3D remote_end;
         add_route(&r, tt, 0, NULL, es, NULL);
     }
@@ -1451,14 +1499,14 @@
     {
         argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
-                    ifconfig_remote_netmask, tun_mtu);
+                    ifconfig_remote, tun_mtu);
     }
     else if (tt->type =3D=3D DEV_TYPE_TUN)
     {
         remote_end =3D create_arbitrary_remote(tt);
         argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up", IFCONFIG_PA=
TH,
                     ifname, ifconfig_local, print_in_addr_t(remote_end, 0,=
 &gc),
-                    tun_mtu, ifconfig_remote_netmask);
+                    tun_mtu, ifconfig_netmask);
     }
     else /* tap */
     {
@@ -1469,7 +1517,7 @@
          */
         argv_printf(&argv, "%s %s %s netmask %s mtu %d",
                     IFCONFIG_PATH, ifname, ifconfig_local,
-                    ifconfig_remote_netmask, tun_mtu);
+                    ifconfig_netmask, tun_mtu);
     }
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, S_FATAL, "NetBSD ifconfig failed");
@@ -1480,8 +1528,8 @@
         struct route_ipv4 r;
         CLEAR(r);
         r.flags =3D RT_DEFINED;
-        r.network =3D tt->local & tt->remote_netmask;
-        r.netmask =3D tt->remote_netmask;
+        r.network =3D tt->local & netmask;
+        r.netbits =3D tt->netbits;
         r.gateway =3D remote_end;
         add_route(&r, tt, 0, NULL, es, NULL);
     }
@@ -1503,18 +1551,18 @@
     {
         argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
-                    ifconfig_remote_netmask, tun_mtu);
+                    ifconfig_remote, tun_mtu);
     }
     else if (tt->type =3D=3D DEV_TYPE_TUN)
     {
         argv_printf(&argv, "%s %s %s %s netmask %s mtu %d up",
                     IFCONFIG_PATH, ifname, ifconfig_local, ifconfig_local,
-                    ifconfig_remote_netmask, tun_mtu);
+                    ifconfig_netmask, tun_mtu);
     }
     else /* tap */
     {
         argv_printf(&argv, "%s %s %s netmask %s mtu %d up", IFCONFIG_PATH,
-                    ifname, ifconfig_local, ifconfig_remote_netmask,
+                    ifname, ifconfig_local, ifconfig_netmask,
                     tun_mtu);
     }

@@ -1527,8 +1575,8 @@
         struct route_ipv4 r;
         CLEAR(r);
         r.flags =3D RT_DEFINED;
-        r.network =3D tt->local & tt->remote_netmask;
-        r.netmask =3D tt->remote_netmask;
+        r.network =3D tt->local & netmask;
+        r.netbits =3D tt->netbits;
         r.gateway =3D tt->local;
         add_route(&r, tt, 0, NULL, es, NULL);
     }
@@ -1540,13 +1588,12 @@
     {
         argv_printf(&argv, "%s %s %s %s mtu %d netmask 255.255.255.255 up",
                     IFCONFIG_PATH, ifname, ifconfig_local,
-                    ifconfig_remote_netmask, tun_mtu);
+                    ifconfig_remote, tun_mtu);
     }
     else            /* tun with topology subnet and tap mode (always subne=
t) */
     {
-        int netbits =3D netmask_to_netbits2(tt->remote_netmask);
         argv_printf(&argv, "%s %s %s/%d mtu %d up", IFCONFIG_PATH,
-                    ifname, ifconfig_local, netbits, tun_mtu );
+                    ifname, ifconfig_local, tt->netbits, tun_mtu );
     }

     argv_msg(M_INFO, &argv);
@@ -1565,7 +1612,7 @@

         /* example: ifconfig tap0 172.30.1.1 netmask 255.255.254.0 up */
         argv_printf(&argv, "%s %s %s netmask %s mtu %d up", IFCONFIG_PATH,
-                    ifname, ifconfig_local, ifconfig_remote_netmask, tun_m=
tu);
+                    ifname, ifconfig_local, ifconfig_netmask, tun_mtu);

         argv_msg(M_INFO, &argv);
         openvpn_execve_check(&argv, aix_es, S_FATAL, "AIX ifconfig failed"=
);
@@ -1578,7 +1625,7 @@
         msg(M_INFO,
             "******** NOTE:  Please manually set the IP/netmask of '%s' to=
 %s/%s (if it is not already set)",
             ifname, ifconfig_local,
-            ifconfig_remote_netmask);
+            ifconfig_netmask);
     }
     else if (tt->options.ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ || tt->o=
ptions.ip_win32_type =3D=3D IPW32_SET_ADAPTIVE)
     {
@@ -1660,12 +1707,10 @@
 undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
-    int netbits =3D netmask_to_netbits2(tt->remote_netmask);
-
     if (is_tun_p2p(tt))
     {
         if (net_addr_ptp_v4_del(ctx, tt->actual_name, &tt->local,
-                                &tt->remote_netmask) < 0)
+                                &tt->remote) < 0)
         {
             msg(M_WARN, "Linux can't del IP from iface %s",
                 tt->actual_name);
@@ -1673,7 +1718,7 @@
     }
     else
     {
-        if (net_addr_v4_del(ctx, tt->actual_name, &tt->local, netbits) < 0)
+        if (net_addr_v4_del(ctx, tt->actual_name, &tt->local, tt->netbits)=
 < 0)
         {
             msg(M_WARN, "Linux can't del IP from iface %s",
                 tt->actual_name);
@@ -4683,8 +4728,8 @@

             if (ip_str && netmask_str && strlen(ip_str) && strlen(netmask_=
str))
             {
-                *ip =3D getaddr(getaddr_flags, ip_str, 0, &succeed1, NULL);
-                *netmask =3D getaddr(getaddr_flags, netmask_str, 0, &succe=
ed2, NULL);
+                *ip =3D getaddr(getaddr_flags, ip_str, NULL, 0, &succeed1,=
 NULL);
+                *netmask =3D getaddr(getaddr_flags, netmask_str, NULL, 0, =
&succeed2, NULL);
                 ret =3D (succeed1 =3D=3D true && succeed2 =3D=3D true);
             }
         }
@@ -5370,7 +5415,7 @@
             break;
         }

-        ip =3D getaddr(getaddr_flags, ip_str, 0, &succeed, NULL);
+        ip =3D getaddr(getaddr_flags, ip_str, NULL, 0, &succeed, NULL);
         if (!succeed)
         {
             break;
@@ -6428,11 +6473,12 @@
     if (!tt->did_ifconfig_setup || tt->topology =3D=3D TOP_SUBNET)
     {
         in_addr_t ep[3];
+        const in_addr_t netmask =3D netbits_to_netmask(tt->netbits);
         BOOL status;

         ep[0] =3D htonl(tt->local);
-        ep[1] =3D htonl(tt->local & tt->remote_netmask);
-        ep[2] =3D htonl(tt->remote_netmask);
+        ep[1] =3D htonl(tt->local & netmask);
+        ep[2] =3D htonl(netmask);

         status =3D DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_TUN,
                                  ep, sizeof(ep),
@@ -6456,7 +6502,7 @@
     {
         in_addr_t ep[2];
         ep[0] =3D htonl(tt->local);
-        ep[1] =3D htonl(tt->remote_netmask);
+        ep[1] =3D htonl(tt->remote);

         if (!DeviceIoControl(tt->hand, TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT,
                              ep, sizeof(ep),
@@ -6485,11 +6531,11 @@
     {
         if (tt->topology =3D=3D TOP_SUBNET)
         {
-            ep[2] =3D dhcp_masq_addr(tt->local, tt->remote_netmask, tt->op=
tions.dhcp_masq_custom_offset ? tt->options.dhcp_masq_offset : 0);
+            ep[2] =3D dhcp_masq_addr(tt->local, netbits_to_netmask(tt->net=
bits), tt->options.dhcp_masq_custom_offset ? tt->options.dhcp_masq_offset :=
 0);
         }
         else
         {
-            ep[2] =3D htonl(tt->remote_netmask);
+            ep[2] =3D htonl(tt->remote);
         }
     }
     else
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 33b9552..68aa3b8 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -188,7 +188,8 @@

     /* ifconfig parameters */
     in_addr_t local;
-    in_addr_t remote_netmask;
+    in_addr_t remote;
+    int netbits;

     struct in6_addr local_ipv6;
     struct in6_addr remote_ipv6;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9a766c9604efc9
Gerrit-Change-Number: 739
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--ezz0ITQCaPo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Support CIDR on options and extend netbits usage<br><br>Add support f=
or CIDR notation on all suitable options (client-nat,<br>ifconfig, ifconfig=
-pull, ifconfig-push, ifconfig-push-constraint,<br>iroute, route, server, s=
erver-bridge). Anyway push of ifconfig is done<br>without CIDR in order to =
support older peers. Also netmask env vars have<br>been preserved while als=
o introducing the corresponding netbits vars.<br><br>Some of the internal l=
ogic has also been modified to use netbits instead<br>of netmasks.<br><br>C=
hange-Id: Iae04ad8715e40dfc76475c2c5b9a766c9604efc9<br>Signed-off-by: Ralf =
Lici &lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/basic.h<br>M src/openv=
pn/clinat.c<br>M src/openvpn/clinat.h<br>M src/openvpn/helper.c<br>M src/op=
envpn/init.c<br>M src/openvpn/manage.c<br>M src/openvpn/multi.c<br>M src/op=
envpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/pool.c<br>M src=
/openvpn/push.c<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>M src/=
openvpn/socket.c<br>M src/openvpn/socket.h<br>M src/openvpn/tun.c<br>M src/=
openvpn/tun.h<br>17 files changed, 520 insertions(+), 284 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/739/2=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h</span><br><=
span>index d1075b2..6658008 100644</span><br><span>--- a/src/openvpn/basic.=
h</span><br><span>+++ b/src/openvpn/basic.h</span><br><span>@@ -33,5 +33,6 =
@@</span><br><span> #define CLEAR(x) memset(&amp;(x), 0, sizeof(x))</span><=
br><span> </span><br><span> #define IPV4_NETMASK_HOST 0xffffffffU</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define IPV4_NETBITS_HOST 32U=
</span><br><span> </span><br><span> #endif</span><br><span>diff --git a/src=
/openvpn/clinat.c b/src/openvpn/clinat.c</span><br><span>index 2d3b359..f56=
5989 100644</span><br><span>--- a/src/openvpn/clinat.c</span><br><span>+++ =
b/src/openvpn/clinat.c</span><br><span>@@ -31,6 +31,7 @@</span><br><span> #=
include &quot;proto.h&quot;</span><br><span> #include &quot;socket.h&quot;<=
/span><br><span> #include &quot;memdbg.h&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;route.h&quot;</span><br><span> </=
span><br><span> static bool</span><br><span> add_entry(struct client_nat_op=
tion_list *dest,</span><br><span>@@ -60,11 +61,11 @@</span><br><span>      =
   for (i =3D 0; i &lt; list-&gt;n; ++i)</span><br><span>         {</span><=
br><span>             const struct client_nat_entry *e =3D &amp;list-&gt;en=
tries[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
msg(msglevel, &quot;  CNAT[%d] t=3D%d %s/%s/%s&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;  CNAT[%d=
] t=3D%d %s/%d %s&quot;,</span><br><span>                 i,</span><br><spa=
n>                 e-&gt;type,</span><br><span>                 print_in_ad=
dr_t(e-&gt;network, IA_NET_ORDER, &amp;gc),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                print_in_addr_t(e-&gt;netmask, IA_NET=
_ORDER, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              e-&gt;netbits,</span><br><span>                 print_in_addr=
_t(e-&gt;foreign_network, IA_NET_ORDER, &amp;gc));</span><br><span>        =
 }</span><br><span>     }</span><br><span>@@ -111,6 +112,7 @@</span><br><sp=
an>                               int msglevel)</span><br><span> {</span><b=
r><span>     struct client_nat_entry e;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    unsigned int netbits =3D 0;</span><br><span>     bo=
ol ok;</span><br><span> </span><br><span>     if (!strcmp(type, &quot;snat&=
quot;))</span><br><span>@@ -127,19 +129,34 @@</span><br><span>         retu=
rn;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    e.network =3D getaddr(0, network, 0, &amp;ok, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e.network =
=3D getaddr(0, network, &amp;netbits, 0, &amp;ok, NULL);</span><br><span>  =
   if (!ok)</span><br><span>     {</span><br><span>         msg(msglevel, &=
quot;client-nat: bad network: %s&quot;, network);</span><br><span>         =
return;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    e.netmask =3D getaddr(0, netmask, 0, &amp;ok, NULL);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (!ok)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (netmask)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel=
, &quot;client-nat: bad netmask: %s&quot;, netmask);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const in_addr_t mask =3D getaddr(=
0, netmask, NULL, 0, &amp;ok, NULL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        const int bits =3D netmask_to_netbits2(mask);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!ok || bits &lt;=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;clie=
nt-nat: bad netmask: %s&quot;, netmask);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        e.netbits =3D bits;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (netbits &gt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        e.netbits =3D netbits;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;=
client-nat: netmask or bits must be specified&quot;);</span><br><span>     =
    return;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    e.foreign_network =3D getaddr(0, foreign_network, 0, &amp;=
ok, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e.for=
eign_network =3D getaddr(0, foreign_network, NULL, 0, &amp;ok, NULL);</span=
><br><span>     if (!ok)</span><br><span>     {</span><br><span>         ms=
g(msglevel, &quot;client-nat: bad foreign network: %s&quot;, foreign_networ=
k);</span><br><span>@@ -210,6 +227,7 @@</span><br><span>     for (i =3D 0; =
i &lt; list-&gt;n; ++i)</span><br><span>     {</span><br><span>         con=
st struct client_nat_entry *e =3D &amp;list-&gt;entries[i]; /* current NAT =
rule */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t in_addr_t netmask =3D netbits_to_netmask((int)e-&gt;netbits);</span><br><=
span>         if (e-&gt;type ^ direction)</span><br><span>         {</span>=
<br><span>             addr =3D *(addr_ptr =3D &amp;h-&gt;ip.daddr);</span>=
<br><span>@@ -231,13 +249,13 @@</span><br><span>             to =3D &amp;e-=
&gt;foreign_network;</span><br><span>         }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (((addr &amp; e-&gt;=
netmask) =3D=3D *from) &amp;&amp; !(amask &amp; alog))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (((addr &amp; netmask) =3D=3D=
 *from) &amp;&amp; !(amask &amp; alog))</span><br><span>         {</span><b=
r><span>             /* pre-adjust IP checksum */</span><br><span>         =
    ADD_CHECKSUM_32(accumulate, addr);</span><br><span> </span><br><span>  =
           /* do NAT transform */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            addr =3D (addr &amp; ~e-&gt;netmask) | *to;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            addr =3D (addr =
&amp; ~netmask) | *to;</span><br><span> </span><br><span>             /* po=
st-adjust IP checksum */</span><br><span>             SUB_CHECKSUM_32(accum=
ulate, addr);</span><br><span>diff --git a/src/openvpn/clinat.h b/src/openv=
pn/clinat.h</span><br><span>index 94141f5..bebd012 100644</span><br><span>-=
-- a/src/openvpn/clinat.h</span><br><span>+++ b/src/openvpn/clinat.h</span>=
<br><span>@@ -36,7 +36,7 @@</span><br><span> #define CN_DNAT 1</span><br><s=
pan>     int type;</span><br><span>     in_addr_t network;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    in_addr_t netmask;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    unsigned int netbits;</span><br=
><span>     in_addr_t foreign_network;</span><br><span> };</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c<=
/span><br><span>index bbdbc04..30f3539 100644</span><br><span>--- a/src/ope=
nvpn/helper.c</span><br><span>+++ b/src/openvpn/helper.c</span><br><span>@@=
 -64,22 +64,21 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-print=
_opt_route(const in_addr_t network, const in_addr_t netmask, struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_opt_rou=
te(const in_addr_t network, const int netbits, struct gc_arena *gc)</span><=
br><span> {</span><br><span>     struct buffer out =3D alloc_buf_gc(128, gc=
);</span><br><span>     ASSERT(network);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (netmask)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        buf_printf(&amp;out, &quot;route %s %s&quot;,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                   print_in=
_addr_t(network, 0, gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                   print_in_addr_t(netmask, 0, gc));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (netbits &lt; 0)</span><br><span>     {</span><br><span>     =
    buf_printf(&amp;out, &quot;route %s&quot;,</span><br><span>            =
        print_in_addr_t(network, 0, gc));</span><br><span>     }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;route %s/%d&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   pr=
int_in_addr_t(network, 0, gc), netbits);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     return BS=
TR(&amp;out);</span><br><span> }</span><br><span>@@ -111,27 +110,28 @@</spa=
n><br><span> }</span><br><span> </span><br><span> static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-helper_add_route(const in_addr_t ne=
twork, const in_addr_t netmask, struct options *o)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+helper_add_route(const in_addr_t network, co=
nst int netbits, struct options *o)</span><br><span> {</span><br><span>    =
 rol_check_alloc(o);</span><br><span>     add_route_to_option_list(o-&gt;ro=
utes,</span><br><span>                              print_in_addr_t(network=
, 0, &amp;o-&gt;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                            print_in_addr_t(netmask, 0, &amp;o-&gt;gc),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
      print_in_addr_t(netbits_to_netmask(netbits), 0, &amp;o-&gt;gc),</span=
><br><span>                              NULL,</span><br><span>            =
                  NULL);</span><br><span> }</span><br><span> </span><br><sp=
an> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-verify=
_common_subnet(const char *opt, const in_addr_t a, const in_addr_t b, const=
 in_addr_t subnet)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
erify_common_subnet(const char *opt, const in_addr_t a, const in_addr_t b, =
const unsigned int netbits)</span><br><span> {</span><br><span>     struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if ((a &amp; subnet) !=3D (b &amp; subnet))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const unsigned int var =3D 32 - netbi=
ts;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((a &gt;&=
gt; var) !=3D (b &gt;&gt; var))</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAGE, &quot;%s IP addresses=
 %s and %s are not in the same %s subnet&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;%s IP addresses %s a=
nd %s are not in the same /%d subnet&quot;,</span><br><span>             op=
t,</span><br><span>             print_in_addr_t(a, 0, &amp;gc),</span><br><=
span>             print_in_addr_t(b, 0, &amp;gc),</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            print_in_addr_t(subnet, 0, &amp;gc)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            netbi=
ts);</span><br><span>     }</span><br><span>     gc_free(&amp;gc);</span><b=
r><span> }</span><br><span>@@ -268,9 +268,6 @@</span><br><span> </span><br>=
<span>     if (o-&gt;server_defined)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        int netbits =3D -2;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        bool status =3D false;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
    if (o-&gt;client)</span><br><span>         {</span><br><span>          =
   msg(M_USAGE, &quot;--server and --client cannot be used together&quot;);=
</span><br><span>@@ -296,34 +293,24 @@</span><br><span>             msg(M_U=
SAGE, &quot;--server directive only makes sense with --dev tun or --dev tap=
&quot;);</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        status =3D netmask_to_netbits(o-&gt=
;server_network, o-&gt;server_netmask, &amp;netbits);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!status)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--server directive netwo=
rk/netmask combination is invalid&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (n=
etbits &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_U=
SAGE, &quot;--server directive netmask is invalid&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (netbits &lt; IFCONFIG_POOL_MIN_NETBITS)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;server_netbits &lt; IF=
CONFIG_POOL_MIN_NETBITS)</span><br><span>         {</span><br><span>       =
      msg(M_USAGE, &quot;--server directive netmask allows for too many hos=
t addresses (subnet must be %s or higher)&quot;,</span><br><span>          =
       print_netmask(IFCONFIG_POOL_MIN_NETBITS, &amp;gc));</span><br><span>=
         }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        const in_addr_t server_netmask =3D netbits_to_netmask((int=
)o-&gt;server_netbits);</span><br><span>         if (dev =3D=3D DEV_TYPE_TU=
N)</span><br><span>         {</span><br><span>             int pool_end_res=
erve =3D 4;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            if (netbits &gt; 29)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (o-&gt;server_netbits &gt; 29)</span><b=
r><span>             {</span><br><span>                 msg(M_USAGE, &quot;=
--server directive when used with --dev tun must define a subnet of %s or l=
ower&quot;,</span><br><span>                     print_netmask(29, &amp;gc)=
);</span><br><span>             }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (netbits =3D=3D 29)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (o-&gt;server=
_netbits =3D=3D 29)</span><br><span>             {</span><br><span>        =
         pool_end_reserve =3D 0;</span><br><span>             }</span><br><=
span>@@ -342,14 +329,14 @@</span><br><span>                 {</span><br><sp=
an>                     o-&gt;ifconfig_pool_defined =3D true;</span><br><sp=
an>                     o-&gt;ifconfig_pool_start =3D o-&gt;server_network =
+ 4;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   o-&gt;ifconfig_pool_end =3D (o-&gt;server_network | ~o-&gt;server_netmas=
k) - pool_end_reserve;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    o-&gt;ifconfig_pool_end =3D (o-&gt;server_network | =
~server_netmask) - pool_end_reserve;</span><br><span>                     i=
fconfig_pool_verify_range(M_USAGE, o-&gt;ifconfig_pool_start, o-&gt;ifconfi=
g_pool_end);</span><br><span>                 }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                helper_add_rout=
e(o-&gt;server_network, o-&gt;server_netmask, o);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                helper_add_route(o-&gt;server=
_network, o-&gt;server_netbits, o);</span><br><span>                 if (o-=
&gt;enable_c2c)</span><br><span>                 {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    push_option(o, print_opt_r=
oute(o-&gt;server_network, o-&gt;server_netmask, &amp;o-&gt;gc), M_USAGE);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
push_option(o, print_opt_route(o-&gt;server_network, o-&gt;server_netbits, =
&amp;o-&gt;gc), M_USAGE);</span><br><span>                 }</span><br><spa=
n>                 else if (o-&gt;topology =3D=3D TOP_NET30)</span><br><spa=
n>                 {</span><br><span>@@ -359,16 +346,16 @@</span><br><span>=
             else if (o-&gt;topology =3D=3D TOP_SUBNET)</span><br><span>   =
          {</span><br><span>                 o-&gt;ifconfig_local =3D print=
_in_addr_t(o-&gt;server_network + 1, 0, &amp;o-&gt;gc);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                o-&gt;ifconfig_remote_net=
mask =3D print_in_addr_t(o-&gt;server_netmask, 0, &amp;o-&gt;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                o-&gt;ifconfi=
g_remote_netmask =3D print_in_addr_t(server_netmask, 0, &amp;o-&gt;gc);</sp=
an><br><span> </span><br><span>                 if (!(o-&gt;server_flags &a=
mp; SF_NOPOOL))</span><br><span>                 {</span><br><span>        =
             o-&gt;ifconfig_pool_defined =3D true;</span><br><span>        =
             o-&gt;ifconfig_pool_start =3D o-&gt;server_network + 2;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    o-&gt;if=
config_pool_end =3D (o-&gt;server_network | ~o-&gt;server_netmask) - 1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    o-&=
gt;ifconfig_pool_end =3D (o-&gt;server_network | ~server_netmask) - 1;</spa=
n><br><span>                     ifconfig_pool_verify_range(M_USAGE, o-&gt;=
ifconfig_pool_start, o-&gt;ifconfig_pool_end);</span><br><span>            =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 o-&gt;ifconfig_pool_netmask =3D o-&gt;server_netmask;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                o-&gt;ifconfig_pool_netb=
its =3D o-&gt;server_netbits;</span><br><span> </span><br><span>           =
      push_option(o, print_opt_route_gateway(o-&gt;server_network + 1, &amp=
;o-&gt;gc), M_USAGE);</span><br><span>                 if (!o-&gt;route_def=
ault_gateway)</span><br><span>@@ -393,7 +380,7 @@</span><br><span>         =
}</span><br><span>         else if (dev =3D=3D DEV_TYPE_TAP)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (netbits &gt; 30)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (o-&gt;server_netbits &gt; 30)</span><br><span>         =
    {</span><br><span>                 msg(M_USAGE, &quot;--server directiv=
e when used with --dev tap must define a subnet of %s or lower&quot;,</span=
><br><span>                     print_netmask(30, &amp;gc));</span><br><spa=
n>@@ -402,16 +389,16 @@</span><br><span>             o-&gt;mode =3D MODE_SE=
RVER;</span><br><span>             o-&gt;tls_server =3D true;</span><br><sp=
an>             o-&gt;ifconfig_local =3D print_in_addr_t(o-&gt;server_netwo=
rk + 1, 0, &amp;o-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            o-&gt;ifconfig_remote_netmask =3D print_in_addr_t(o-&gt;se=
rver_netmask, 0, &amp;o-&gt;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            o-&gt;ifconfig_remote_netmask =3D print_in_addr_t(=
server_netmask, 0, &amp;o-&gt;gc);</span><br><span> </span><br><span>      =
       if (!(o-&gt;server_flags &amp; SF_NOPOOL))</span><br><span>         =
    {</span><br><span>                 o-&gt;ifconfig_pool_defined =3D true=
;</span><br><span>                 o-&gt;ifconfig_pool_start =3D o-&gt;serv=
er_network + 2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          o-&gt;ifconfig_pool_end =3D (o-&gt;server_network | ~o-&gt;server=
_netmask) - 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           o-&gt;ifconfig_pool_end =3D (o-&gt;server_network | ~server_netm=
ask) - 1;</span><br><span>                 ifconfig_pool_verify_range(M_USA=
GE, o-&gt;ifconfig_pool_start, o-&gt;ifconfig_pool_end);</span><br><span>  =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   o-&gt;ifconfig_pool_netmask =3D o-&gt;server_netmask;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            o-&gt;ifconfig_pool_netbit=
s =3D o-&gt;server_netbits;</span><br><span> </span><br><span>             =
push_option(o, print_opt_route_gateway(o-&gt;server_network + 1, &amp;o-&gt=
;gc), M_USAGE);</span><br><span>         }</span><br><span>@@ -425,7 +412,7=
 @@</span><br><span>         {</span><br><span>             o-&gt;push_ifco=
nfig_constraint_defined =3D true;</span><br><span>             o-&gt;push_i=
fconfig_constraint_network =3D o-&gt;server_network;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            o-&gt;push_ifconfig_constraint_=
netmask =3D o-&gt;server_netmask;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            o-&gt;push_ifconfig_constraint_netbits =3D o-&gt;=
server_netbits;</span><br><span>         }</span><br><span>     }</span><br=
><span> </span><br><span>@@ -478,9 +465,9 @@</span><br><span> </span><br><s=
pan>         if (o-&gt;server_bridge_defined)</span><br><span>         {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            verify_commo=
n_subnet(&quot;--server-bridge&quot;, o-&gt;server_bridge_ip, o-&gt;server_=
bridge_pool_start, o-&gt;server_bridge_netmask);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            verify_common_subnet(&quot;--server-=
bridge&quot;, o-&gt;server_bridge_pool_start, o-&gt;server_bridge_pool_end,=
 o-&gt;server_bridge_netmask);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            verify_common_subnet(&quot;--server-bridge&quot;, o-&g=
t;server_bridge_ip, o-&gt;server_bridge_pool_end, o-&gt;server_bridge_netma=
sk);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ver=
ify_common_subnet(&quot;--server-bridge&quot;, o-&gt;server_bridge_ip, o-&g=
t;server_bridge_pool_start, o-&gt;server_bridge_netbits);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            verify_common_subnet(&quo=
t;--server-bridge&quot;, o-&gt;server_bridge_pool_start, o-&gt;server_bridg=
e_pool_end, o-&gt;server_bridge_netbits);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            verify_common_subnet(&quot;--server-bridg=
e&quot;, o-&gt;server_bridge_ip, o-&gt;server_bridge_pool_end, o-&gt;server=
_bridge_netbits);</span><br><span>         }</span><br><span> </span><br><s=
pan>         o-&gt;mode =3D MODE_SERVER;</span><br><span>@@ -492,7 +479,7 @=
@</span><br><span>             o-&gt;ifconfig_pool_start =3D o-&gt;server_b=
ridge_pool_start;</span><br><span>             o-&gt;ifconfig_pool_end =3D =
o-&gt;server_bridge_pool_end;</span><br><span>             ifconfig_pool_ve=
rify_range(M_USAGE, o-&gt;ifconfig_pool_start, o-&gt;ifconfig_pool_end);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;ifconf=
ig_pool_netmask =3D o-&gt;server_bridge_netmask;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            o-&gt;ifconfig_pool_netbits =3D o-=
&gt;server_bridge_netbits;</span><br><span>             push_option(o, prin=
t_opt_route_gateway(o-&gt;server_bridge_ip, &amp;o-&gt;gc), M_USAGE);</span=
><br><span>         }</span><br><span>         else if (o-&gt;server_bridge=
_proxy_dhcp &amp;&amp; !(o-&gt;server_flags &amp; SF_NO_PUSH_ROUTE_GATEWAY)=
)</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</spa=
n><br><span>index dd56961..7f72f8d 100644</span><br><span>--- a/src/openvpn=
/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -115,6 =
+115,7 @@</span><br><span>             const char *dev_type,</span><br><spa=
n>             int tun_mtu,</span><br><span>             const char *ifconf=
ig_local,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  const int ifconfig_netbits,</span><br><span>             const char *ifco=
nfig_remote,</span><br><span>             const char *context,</span><br><s=
pan>             const char *signal_text,</span><br><span>@@ -144,7 +145,14=
 @@</span><br><span>     }</span><br><span>     if (!ifconfig_remote)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    ifconfig_remote =3D &quot;&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (ifconfig_netbits &gt; 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            ifconfig_remote =3D print_in_addr_t(ne=
tbits_to_netmask(ifconfig_netbits), 0, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            ifconfig_remote =3D &quot;&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><spa=
n>     if (!context)</span><br><span>     {</span><br><span>@@ -1948,7 +195=
6,8 @@</span><br><span>                     dev_type_string(c-&gt;options.d=
ev, c-&gt;options.dev_type),</span><br><span>                     c-&gt;c2.=
frame.tun_mtu,</span><br><span>                     print_in_addr_t(c-&gt;c=
1.tuntap-&gt;local, IA_EMPTY_IF_UNDEF, &amp;gc),</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    print_in_addr_t(c-&gt;c1.tun=
tap-&gt;remote_netmask, IA_EMPTY_IF_UNDEF, &amp;gc),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    c-&gt;c1.tuntap-&gt;n=
etbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        print_in_addr_t(c-&gt;c1.tuntap-&gt;remote, IA_EMPTY_IF_UNDEF, &amp=
;gc),</span><br><span>                     &quot;init&quot;,</span><br><spa=
n>                     NULL,</span><br><span>                     &quot;up&=
quot;,</span><br><span>@@ -1988,7 +1997,8 @@</span><br><span>              =
           dev_type_string(c-&gt;options.dev, c-&gt;options.dev_type),</spa=
n><br><span>                         c-&gt;c2.frame.tun_mtu,</span><br><spa=
n>                         print_in_addr_t(c-&gt;c1.tuntap-&gt;local, IA_EM=
PTY_IF_UNDEF, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        print_in_addr_t(c-&gt;c1.tuntap-&gt;remote_netmas=
k, IA_EMPTY_IF_UNDEF, &amp;gc),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        c-&gt;c1.tuntap-&gt;netbits,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        print_=
in_addr_t(c-&gt;c1.tuntap-&gt;remote, IA_EMPTY_IF_UNDEF, &amp;gc),</span><b=
r><span>                         &quot;restart&quot;,</span><br><span>     =
                    NULL,</span><br><span>                         &quot;up=
&quot;,</span><br><span>@@ -2045,7 +2055,8 @@</span><br><span>     struct g=
c_arena gc =3D gc_new();</span><br><span>     const char *tuntap_actual =3D=
 string_alloc(c-&gt;c1.tuntap-&gt;actual_name, &amp;gc);</span><br><span>  =
   const in_addr_t local =3D c-&gt;c1.tuntap-&gt;local;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const in_addr_t remote_netmask =3D c-=
&gt;c1.tuntap-&gt;remote_netmask;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const int netbits =3D c-&gt;c1.tuntap-&gt;netbits;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const in_addr_t remote=
 =3D c-&gt;c1.tuntap-&gt;remote;</span><br><span>     unsigned long adapter=
_index =3D 0;</span><br><span> #ifdef _WIN32</span><br><span>     adapter_i=
ndex =3D c-&gt;c1.tuntap-&gt;adapter_index;</span><br><span>@@ -2077,7 +208=
8,8 @@</span><br><span>                         NULL,</span><br><span>     =
                    c-&gt;c2.frame.tun_mtu,</span><br><span>               =
          print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &amp;gc),</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        print_in_ad=
dr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &amp;gc),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        netbits,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        print_in=
_addr_t(remote, IA_EMPTY_IF_UNDEF, &amp;gc),</span><br><span>              =
           &quot;init&quot;,</span><br><span>                         signa=
l_description(c-&gt;sig-&gt;signal_received,</span><br><span>              =
                              c-&gt;sig-&gt;signal_text),</span><br><span>@=
@ -2107,7 +2119,8 @@</span><br><span>                     NULL,</span><br><=
span>                     c-&gt;c2.frame.tun_mtu,</span><br><span>         =
            print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &amp;gc),</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    print_in_addr=
_t(remote_netmask, IA_EMPTY_IF_UNDEF, &amp;gc),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    netbits,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    print_in_addr_t(re=
mote, IA_EMPTY_IF_UNDEF, &amp;gc),</span><br><span>                     &qu=
ot;init&quot;,</span><br><span>                     signal_description(c-&g=
t;sig-&gt;signal_received,</span><br><span>                                =
        c-&gt;sig-&gt;signal_text),</span><br><span>@@ -2137,7 +2150,8 @@</=
span><br><span>                         NULL,</span><br><span>             =
            c-&gt;c2.frame.tun_mtu,</span><br><span>                       =
  print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &amp;gc),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        print_in_addr_t(rem=
ote_netmask, IA_EMPTY_IF_UNDEF, &amp;gc),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        netbits,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        print_in_addr_t(=
remote, IA_EMPTY_IF_UNDEF, &amp;gc),</span><br><span>                      =
   &quot;restart&quot;,</span><br><span>                         signal_des=
cription(c-&gt;sig-&gt;signal_received,</span><br><span>                   =
                         c-&gt;sig-&gt;signal_text),</span><br><span>diff -=
-git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index 05=
b5a1a..a88ee5f 100644</span><br><span>--- a/src/openvpn/manage.c</span><br>=
<span>+++ b/src/openvpn/manage.c</span><br><span>@@ -554,7 +554,7 @@</span>=
<br><span>         {</span><br><span>             /* IP:port specified */</=
span><br><span>             bool status;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            const in_addr_t addr =3D getaddr(GETADDR_HOS=
T_ORDER|GETADDR_MSG_VIRT_OUT, p1, 0, &amp;status, NULL);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            const in_addr_t addr =3D g=
etaddr(GETADDR_HOST_ORDER|GETADDR_MSG_VIRT_OUT, p1, NULL, 0, &amp;status, N=
ULL);</span><br><span>             if (status)</span><br><span>            =
 {</span><br><span>                 const int port =3D atoi(p2);</span><br>=
<span>@@ -2803,6 +2803,7 @@</span><br><span>         &quot;untrusted_ip=3D&=
quot;,</span><br><span>         &quot;ifconfig_local=3D&quot;,</span><br><s=
pan>         &quot;ifconfig_netmask=3D&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        &quot;ifconfig_netbits=3D&quot;,</span><b=
r><span>         &quot;daemon_start_time=3D&quot;,</span><br><span>        =
 &quot;daemon_pid=3D&quot;,</span><br><span>         &quot;dev=3D&quot;,</s=
pan><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span>=
<br><span>index 0509911..aba1a0f 100644</span><br><span>--- a/src/openvpn/m=
ulti.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1433,7=
 +1433,8 @@</span><br><span>     const struct options *o =3D &amp;c-&gt;opt=
ions;</span><br><span>     if (o-&gt;push_ifconfig_constraint_defined &amp;=
&amp; c-&gt;c2.push_ifconfig_defined)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        return (o-&gt;push_ifconfig_=
constraint_netmask &amp; c-&gt;c2.push_ifconfig_local) =3D=3D o-&gt;push_if=
config_constraint_network;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        const unsigned int var =3D 32 - o-&gt;push_ifconfig_constrai=
nt_netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return (c-&gt;c2.push_ifconfig_local &gt;&gt; var) =3D=3D (o-&gt;push_ifcon=
fig_constraint_network &gt;&gt; var);</span><br><span>     }</span><br><spa=
n>     else</span><br><span>     {</span><br><span>@@ -1512,10 +1513,10 @@<=
/span><br><span>                 mi-&gt;context.c2.push_ifconfig_local =3D =
remote;</span><br><span>                 if (tunnel_type =3D=3D DEV_TYPE_TA=
P || (tunnel_type =3D=3D DEV_TYPE_TUN &amp;&amp; tunnel_topology =3D=3D TOP=
_SUBNET))</span><br><span>                 {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    mi-&gt;context.c2.push_ifconfig_=
remote_netmask =3D mi-&gt;context.options.ifconfig_pool_netmask;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;con=
text.c2.push_ifconfig_remote_netmask =3D netbits_to_netmask((int)mi-&gt;con=
text.options.ifconfig_pool_netbits);</span><br><span>                     i=
f (!mi-&gt;context.c2.push_ifconfig_remote_netmask)</span><br><span>       =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  mi-&gt;context.c2.push_ifconfig_remote_netmask =3D mi-&gt=
;context.c1.tuntap-&gt;remote_netmask;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        mi-&gt;context.c2.push_ifconfig_=
remote_netmask =3D netbits_to_netmask((int)mi-&gt;context.c1.tuntap-&gt;net=
bits);</span><br><span>                     }</span><br><span>             =
    }</span><br><span>                 else if (tunnel_type =3D=3D DEV_TYPE=
_TUN)</span><br><span>@@ -2425,15 +2426,14 @@</span><br><span>     {</span>=
<br><span>         const char *ifconfig_constraint_network =3D</span><br><s=
pan>             print_in_addr_t(mi-&gt;context.options.push_ifconfig_const=
raint_network, 0, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        const char *ifconfig_constraint_netmask =3D</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            print_in_addr_t(mi-&gt;cont=
ext.options.push_ifconfig_constraint_netmask, 0, &amp;gc);</span><br><span>=
 </span><br><span>         /* JYFIXME -- this should cause the connection t=
o fail */</span><br><span>         msg(D_MULTI_ERRORS, &quot;MULTI ERROR: p=
rimary virtual IP for %s (%s) &quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            &quot;violates tunnel network/netmask constraint=
 (%s/%s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        &quot;violates tunnel network/subnet constraint (%s/%d)&quot;,</spa=
n><br><span>             multi_instance_string(mi, false, &amp;gc),</span><=
br><span>             print_in_addr_t(mi-&gt;context.c2.push_ifconfig_local=
, 0, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     ifconfig_constraint_network, ifconfig_constraint_netmask);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            ifconfig_constraint=
_network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  mi-&gt;context.options.push_ifconfig_constraint_netbits);</span><br><span=
>     }</span><br><span> </span><br><span>     /*</span><br><span>diff --gi=
t a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 649=
f48b..b0fabe1 100644</span><br><span>--- a/src/openvpn/options.c</span><br>=
<span>+++ b/src/openvpn/options.c</span><br><span>@@ -1075,7 +1075,7 @@</sp=
an><br><span> #endif /* ifndef _WIN32 */</span><br><span> </span><br><span>=
 static in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_=
ip_addr(const char *ip_string, int msglevel, bool *error)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+get_ip_addr(const char *ip_string, un=
signed int *netbits, int msglevel, bool *error)</span><br><span> {</span><b=
r><span>     unsigned int flags =3D GETADDR_HOST_ORDER;</span><br><span>   =
  bool succeeded =3D false;</span><br><span>@@ -1086,7 +1086,7 @@</span><br=
><span>         flags |=3D GETADDR_FATAL;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D ge=
taddr(flags, ip_string, 0, &amp;succeeded, NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ret =3D getaddr(flags, ip_string, netbits=
, 0, &amp;succeeded, NULL);</span><br><span>     if (!succeeded &amp;&amp; =
error)</span><br><span>     {</span><br><span>         *error =3D true;</sp=
an><br><span>@@ -1333,7 +1333,7 @@</span><br><span>         if (ip_addr_dot=
ted_quad_safe(parm)) /* FQDN -- IP address only */</span><br><span>        =
 {</span><br><span>             bool error =3D false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            const in_addr_t addr =3D get_ip=
_addr(parm, msglevel, &amp;error);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            const in_addr_t addr =3D get_ip_addr(parm, NULL,=
 msglevel, &amp;error);</span><br><span>             if (!error)</span><br>=
<span>             {</span><br><span>                 array[(*len)++] =3D a=
ddr;</span><br><span>@@ -1513,12 +1513,10 @@</span><br><span> {</span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  server=
_network =3D %s&quot;, print_in_addr_t(o-&gt;server_network, 0, &amp;gc));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, =
&quot;  server_netmask =3D %s&quot;, print_in_addr_t(o-&gt;server_netmask, =
0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ms=
g(D_SHOW_PARMS, &quot;  server_network =3D %s/%d&quot;, print_in_addr_t(o-&=
gt;server_network, 0, &amp;gc), o-&gt;server_netbits);</span><br><span>    =
 msg(D_SHOW_PARMS, &quot;  server_network_ipv6 =3D %s&quot;, print_in6_addr=
(o-&gt;server_network_ipv6, 0, &amp;gc) );</span><br><span>     SHOW_INT(se=
rver_netbits_ipv6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  msg(D_SHOW_PARMS, &quot;  server_bridge_ip =3D %s&quot;, print_in_addr_t(=
o-&gt;server_bridge_ip, 0, &amp;gc));</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  server_bridge_netmask =3D %s&=
quot;, print_in_addr_t(o-&gt;server_bridge_netmask, 0, &amp;gc));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_SHOW_PARMS, &quot; =
 server_bridge_ip =3D %s/%d&quot;, print_in_addr_t(o-&gt;server_bridge_ip, =
0, &amp;gc), o-&gt;server_bridge_netbits);</span><br><span>     msg(D_SHOW_=
PARMS, &quot;  server_bridge_pool_start =3D %s&quot;, print_in_addr_t(o-&gt=
;server_bridge_pool_start, 0, &amp;gc));</span><br><span>     msg(D_SHOW_PA=
RMS, &quot;  server_bridge_pool_end =3D %s&quot;, print_in_addr_t(o-&gt;ser=
ver_bridge_pool_end, 0, &amp;gc));</span><br><span>     if (o-&gt;push_list=
.head)</span><br><span>@@ -1534,9 +1532,8 @@</span><br><span>         }</sp=
an><br><span>     }</span><br><span>     SHOW_BOOL(ifconfig_pool_defined);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, =
&quot;  ifconfig_pool_start =3D %s&quot;, print_in_addr_t(o-&gt;ifconfig_po=
ol_start, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    msg(D_SHOW_PARMS, &quot;  ifconfig_pool_start =3D %s/%d&quot;, prin=
t_in_addr_t(o-&gt;ifconfig_pool_start, 0, &amp;gc), o-&gt;ifconfig_pool_net=
bits);</span><br><span>     msg(D_SHOW_PARMS, &quot;  ifconfig_pool_end =3D=
 %s&quot;, print_in_addr_t(o-&gt;ifconfig_pool_end, 0, &amp;gc));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_SHOW_PARMS, &quot;  i=
fconfig_pool_netmask =3D %s&quot;, print_in_addr_t(o-&gt;ifconfig_pool_netm=
ask, 0, &amp;gc));</span><br><span>     SHOW_STR(ifconfig_pool_persist_file=
name);</span><br><span>     SHOW_INT(ifconfig_pool_persist_refresh_freq);</=
span><br><span>     SHOW_BOOL(ifconfig_ipv6_pool_defined);</span><br><span>=
@@ -1597,14 +1594,15 @@</span><br><span>               int msglevel)</span>=
<br><span> {</span><br><span>     struct iroute *ir;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int netbits =3D 0;</span><br=
><span> </span><br><span>     ALLOC_OBJ_GC(ir, struct iroute, &amp;o-&gt;gc=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ir-&gt;network =
=3D getaddr(GETADDR_HOST_ORDER, network_str, 0, NULL, NULL);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    ir-&gt;netbits =3D 32;          =
 /* host route if no netmask given */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ir-&gt;network =3D getaddr(GETADDR_HOST_ORDER, networ=
k_str, &amp;netbits, 0, NULL, NULL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ir-&gt;netbits =3D 32;           /* host route if no n=
etmask or netbits given */</span><br><span> </span><br><span>     if (netma=
sk_str)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        const in_addr_t netmask =3D getaddr(GETADDR_HOST_ORDER, ne=
tmask_str, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        const in_addr_t netmask =3D getaddr(GETADDR_HOST_ORDER, netm=
ask_str, NULL, 0, NULL, NULL);</span><br><span>         ir-&gt;netbits =3D =
netmask_to_netbits2(netmask);</span><br><span> </span><br><span>         if=
 (ir-&gt;netbits &lt; 0)</span><br><span>@@ -1615,6 +1613,10 @@</span><br><=
span>             return;</span><br><span>         }</span><br><span>     }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (netbit=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        ir-&gt;netbits =3D (int=
)netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span> </span><br><span>     ir-&gt;next =3D o-&gt;iroutes;</span><br=
><span>     o-&gt;iroutes =3D ir;</span><br><span>@@ -2631,9 +2633,9 @@</sp=
an><br><span>         {</span><br><span>             msg(M_USAGE, &quot;--c=
onnect-freq only works with --mode server --proto udp.  Try --max-clients i=
nstead.&quot;);</span><br><span>         }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (!(dev =3D=3D DEV_TYPE_TAP || (dev =3D=3D D=
EV_TYPE_TUN &amp;&amp; options-&gt;topology =3D=3D TOP_SUBNET)) &amp;&amp; =
options-&gt;ifconfig_pool_netmask)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!(dev =3D=3D DEV_TYPE_TAP || (dev =3D=3D DEV_TYP=
E_TUN &amp;&amp; options-&gt;topology =3D=3D TOP_SUBNET)) &amp;&amp; option=
s-&gt;ifconfig_pool_netbits &gt; 0)</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;The=
 third parameter to --ifconfig-pool (netmask) is only valid in --dev tap mo=
de&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_USAGE, &quot;The netbits parameter to --ifconfig-pool is only vali=
d in --dev tap mode&quot;);</span><br><span>         }</span><br><span>    =
     if (options-&gt;routes &amp;&amp; (options-&gt;routes-&gt;flags &amp; =
RG_ENABLE))</span><br><span>         {</span><br><span>@@ -6092,11 +6094,29=
 @@</span><br><span>         iproute_path =3D p[1];</span><br><span>     }<=
/span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else if (streq(p[0], &quot;ifconfig&quot;) &amp;&amp; p[1] &amp;&amp;=
 p[2] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else if (streq(p[0], &quot;ifconfig&quot;) &amp;&amp; p[1] &amp;&am=
p; !p[3])</span><br><span>     {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        bool error =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>         VERIFY_PERMISSION(OPT_P_UP=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ip_or_d=
ns_addr_safe(p[1], options-&gt;allow_pull_fqdn) &amp;&amp; ip_or_dns_addr_s=
afe(p[2], options-&gt;allow_pull_fqdn)) /* FQDN -- may be DNS name */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!p[2]) /* p[1=
] must be in CIDR format */</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            unsigned int netbits =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            get_ip_a=
ddr(p[1], &amp;netbits, msglevel, &amp;error);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (error || !netbits)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;ifc=
onfig parm &#39;%s&#39; must be a valid address/bits&quot;, p[1]);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                goto err;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;ifco=
nfig_local =3D strtok(p[1], &quot;/&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* convert netbits to netmask to unify =
the storage as string</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+             * representation of in_addr_t variables and simplify parsing=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            opti=
ons-&gt;ifconfig_remote_netmask =3D print_in_addr_t(netbits_to_netmask((int=
)netbits), 0, &amp;options-&gt;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        else if (ip_or_dns_addr_safe(p[1], options-&gt;allow_pull_fqd=
n) &amp;&amp; ip_or_dns_addr_safe(p[2], options-&gt;allow_pull_fqdn)) /* FQ=
DN -- may be DNS name */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* don&#39;t suggest CIDR usage here since we don&#39;t know if it&#=
39;s a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
* remote address or a netmask */</span><br><span>             options-&gt;i=
fconfig_local =3D p[1];</span><br><span>             options-&gt;ifconfig_r=
emote_netmask =3D p[2];</span><br><span>         }</span><br><span>@@ -6999=
,35 +7019,62 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_PERSIST_IP=
);</span><br><span>         options-&gt;persist_remote_ip =3D true;</span><=
br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    el=
se if (streq(p[0], &quot;client-nat&quot;) &amp;&amp; p[1] &amp;&amp; p[2] =
&amp;&amp; p[3] &amp;&amp; p[4] &amp;&amp; !p[5])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;client-nat&quo=
t;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[5])</span=
><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      size_t i =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        const char *type =3D p[i++];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        const char *network =3D p[i++];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const char *netmask =3D p[i+=
1] ? p[i++] : NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        const char *foreign_network =3D p[i];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>         VERIFY_PERMISSION(OPT_P=
_ROUTE);</span><br><span>         cnol_check_alloc(options);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        add_client_nat_to_option_lis=
t(options-&gt;client_nat, p[1], p[2], p[3], p[4], msglevel);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        add_client_nat_to_option_l=
ist(options-&gt;client_nat, type, network, netmask, foreign_network, msglev=
el);</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot=
;route&quot;) &amp;&amp; p[1] &amp;&amp; !p[5])</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t i =3D 1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *cidr =
=3D strchr(p[i], &#39;/&#39;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (cidr &amp;&amp; !no_more_than_n_args(msglevel, p, 4,=
 NM_QUOTE_HINT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            g=
oto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
     VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span>         rol_check_all=
oc(options);</span><br><span>         if (pull_mode)</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!=
ip_or_dns_addr_safe(p[1], options-&gt;allow_pull_fqdn) &amp;&amp; !is_speci=
al_addr(p[1])) /* FQDN -- may be DNS name */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            const char *network =3D strtok(p[i++], &quot;/&quot;); /*=
 this modifies p[1] */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (!ip_or_dns_addr_safe(network, options-&gt;allow_pull_fqd=
n) &amp;&amp; !is_special_addr(p[1])) /* FQDN -- may be DNS name */</span><=
br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                msg(msglevel, &quot;route parameter network/IP &#39;%s&#3=
9; must be a valid address&quot;, p[1]);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                msg(msglevel, &quot;route parameter ne=
twork/IP &#39;%s&#39; must be a valid address or address/bits&quot;, p[1]);=
</span><br><span>                 goto err;</span><br><span>             }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (p[2] &=
amp;&amp; !ip_addr_dotted_quad_safe(p[2])) /* FQDN -- must be IP address */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!ci=
dr &amp;&amp; p[i])</span><br><span>             {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                msg(msglevel, &quot;route para=
meter netmask &#39;%s&#39; must be an IP address&quot;, p[2]);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                goto err;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                if (!ip_addr=
_dotted_quad_safe(p[i++])) /* FQDN -- must be IP address */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    msg(msglevel, &qu=
ot;route parameter netmask &#39;%s&#39; must be an IP address&quot;, p[2]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       }</span><br><span>             }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if (p[3] &amp;&amp; !ip_or_dns_addr_safe(p[3]=
, options-&gt;allow_pull_fqdn) &amp;&amp; !is_special_addr(p[3])) /* FQDN -=
- may be DNS name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (p[i] &amp;&amp; !ip_or_dns_addr_safe(p[i], options-&gt;all=
ow_pull_fqdn) &amp;&amp; !is_special_addr(p[i])) /* FQDN -- may be DNS name=
 */</span><br><span>             {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                msg(msglevel, &quot;route parameter gateway &#=
39;%s&#39; must be a valid address&quot;, p[3]);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;route para=
meter gateway &#39;%s&#39; must be a valid address&quot;, p[i]);</span><br>=
<span>                 goto err;</span><br><span>             }</span><br><=
span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  add_route_to_option_list(options-&gt;routes, p[1], p[2], p[3], p[4]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (cidr)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            *cidr =3D (char)(&#39;/&#39;); /* resto=
re the original CIDR notation for p[1] */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            add_route_to_option_list(options-&gt;rout=
es, p[1], NULL, p[2], p[3]);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            add_ro=
ute_to_option_list(options-&gt;routes, p[1], p[2], p[3], p[4]);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     =
}</span><br><span>     else if (streq(p[0], &quot;route-ipv6&quot;) &amp;&a=
mp; p[1] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>@@ -7348,=
33 +7395,56 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</=
span><br><span>         options-&gt;occ =3D false;</span><br><span>     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0]=
, &quot;server&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0]=
, &quot;server&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><span>   =
  {</span><br><span>         const int lev =3D M_WARN;</span><br><span>    =
     bool error =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        in_addr_t network, netmask;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        in_addr_t network;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        unsigned int netbits =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        size_t i =3D 1;</span><=
br><span> </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        network =3D get_ip_=
addr(p[1], lev, &amp;error);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        netmask =3D get_ip_addr(p[2], lev, &amp;error);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (error || !network || !=
netmask)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        net=
work =3D get_ip_addr(p[i++], &amp;netbits, lev, &amp;error);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (netbits)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!no_more_than_n_args(msgl=
evel, p, 3, NM_QUOTE_HINT))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                goto err;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            const in_addr=
_t netmask =3D get_ip_addr(p[i++], NULL, lev, &amp;error);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            const int nb =3D netmask=
_to_netbits2(netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (netmask &amp;&amp; nb &gt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                netbits =3D nb;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                msg(M_USAGE, &quot;--server directive n=
etwork/netmask combination is invalid&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (error || !network || !netbits)</span><br><span>         {</span>=
<br><span>             msg(msglevel, &quot;error parsing --server parameter=
s&quot;);</span><br><span>             goto err;</span><br><span>         }=
</span><br><span>         options-&gt;server_defined =3D true;</span><br><s=
pan>         options-&gt;server_network =3D network;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;server_netmask =3D netm=
ask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options=
-&gt;server_netbits =3D netbits;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (p[3])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (p[i])</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (streq(p[3=
], &quot;nopool&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (streq(p[i], &quot;nopool&quot;))</span><br><span>      =
       {</span><br><span>                 options-&gt;server_flags |=3D SF_=
NOPOOL;</span><br><span>             }</span><br><span>             else</s=
pan><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                msg(msglevel, &quot;error parsing --server: %s is no=
t a recognized flag&quot;, p[3]);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                msg(msglevel, &quot;error parsing --server: %=
s is not a recognized flag&quot;, p[i]);</span><br><span>                 g=
oto err;</span><br><span>             }</span><br><span>         }</span><b=
r><span>@@ -7403,25 +7473,42 @@</span><br><span>         options-&gt;server=
_network_ipv6 =3D network;</span><br><span>         options-&gt;server_netb=
its_ipv6 =3D netbits;</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;server-bridge&quot;) =
&amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; p[4] &amp;&amp; =
!p[5])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (=
streq(p[0], &quot;server-bridge&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp=
;&amp; p[3] &amp;&amp; !p[5])</span><br><span>     {</span><br><span>      =
   const int lev =3D M_WARN;</span><br><span>         bool error =3D false;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in_addr_t ip,=
 netmask, pool_start, pool_end;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        in_addr_t ip, pool_start, pool_end;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        unsigned int netbits =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t i =3D 1;=
</span><br><span> </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ip =3D get_=
ip_addr(p[1], lev, &amp;error);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        netmask =3D get_ip_addr(p[2], lev, &amp;error);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        pool_start =3D get_ip_a=
ddr(p[3], lev, &amp;error);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        pool_end =3D get_ip_addr(p[4], lev, &amp;error);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (error || !ip || !netma=
sk || !pool_start || !pool_end)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ip =3D get_ip_addr(p[i++], &amp;netbits, lev, &amp;erro=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (netb=
its)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!no_more_=
than_n_args(msglevel, p, 4, NM_QUOTE_HINT))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                goto err;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   const in_addr_t netmask =3D get_ip_addr(p[i++], NULL, lev, &amp;error);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const in=
t nb =3D netmask_to_netbits2(netmask);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (netmask &amp;&amp; nb &gt; 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                netbits =3D nb;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        pool_start =3D get_ip_addr(p[i++=
], NULL, lev, &amp;error);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        pool_end =3D get_ip_addr(p[i], NULL, lev, &amp;error);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (error || !ip =
|| !netbits || !pool_start || !pool_end)</span><br><span>         {</span><=
br><span>             msg(msglevel, &quot;error parsing --server-bridge par=
ameters&quot;);</span><br><span>             goto err;</span><br><span>    =
     }</span><br><span>         options-&gt;server_bridge_defined =3D true;=
</span><br><span>         options-&gt;server_bridge_ip =3D ip;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;server_bridge_=
netmask =3D netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        options-&gt;server_bridge_netbits =3D netbits;</span><br><span>   =
      options-&gt;server_bridge_pool_start =3D pool_start;</span><br><span>=
         options-&gt;server_bridge_pool_end =3D pool_end;</span><br><span> =
    }</span><br><span>@@ -7456,15 +7543,26 @@</span><br><span>     {</span>=
<br><span>         const int lev =3D M_WARN;</span><br><span>         bool =
error =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   in_addr_t start, end, netmask =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        in_addr_t start, end;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        unsigned int netbits =3D 0;</span><br=
><span> </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        start =3D get_ip_addr=
(p[1], lev, &amp;error);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        end =3D get_ip_addr(p[2], lev, &amp;error);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (p[3])</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        start =3D get_ip_addr(p[1], &amp;net=
bits, lev, &amp;error);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        end =3D get_ip_addr(p[2], NULL, lev, &amp;error);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (!netbits &amp;&amp; p=
[3])</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            netmask =3D get_ip_addr(p[3], lev, &amp;error);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            const in_addr=
_t netmask =3D get_ip_addr(p[3], NULL, lev, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            const int nb =3D netmask_to_netb=
its2(netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (netmask &amp;&amp; nb &gt;=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                netbits =3D nb;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span>         }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (netbits=
 &amp;&amp; !no_more_than_n_args(msglevel, p, 3, NM_QUOTE_HINT))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>         if (error)</span><br><=
span>         {</span><br><span>             msg(msglevel, &quot;error pars=
ing --ifconfig-pool parameters&quot;);</span><br><span>@@ -7478,10 +7576,7 =
@@</span><br><span>         options-&gt;ifconfig_pool_defined =3D true;</sp=
an><br><span>         options-&gt;ifconfig_pool_start =3D start;</span><br>=
<span>         options-&gt;ifconfig_pool_end =3D end;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (netmask)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            options-&gt;ifconfig_pool_netmask =3D netma=
sk;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ifconfig=
_pool_netbits =3D netbits;</span><br><span>     }</span><br><span>     else=
 if (streq(p[0], &quot;ifconfig-pool-persist&quot;) &amp;&amp; p[1] &amp;&a=
mp; !p[3])</span><br><span>     {</span><br><span>@@ -7802,45 +7897,76 @@</=
span><br><span>         VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span>=
         option_iroute_ipv6(options, p[1], msglevel);</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p=
[0], &quot;ifconfig-push&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; =
!p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (=
streq(p[0], &quot;ifconfig-push&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       in_addr_t local, remote_netmask;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        in_addr_t local, remote_netmask =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int netbits=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t i =
=3D 1;</span><br><span> </span><br><span>         VERIFY_PERMISSION(OPT_P_I=
NSTANCE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        loca=
l =3D getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[1], 0, NULL, NULL);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        remote_netmask =
=3D getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[2], 0, NULL, NULL);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        local =3D getaddr=
(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[i++], &amp;netbits, 0, NULL, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (netbits)=
 /* convert netbits to netmask */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (!no_more_than_n_args(msglevel, p, 3, NM_QUOTE_HINT))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                goto err;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            remote_netmask =
=3D netbits_to_netmask((int)netbits);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        else if (p[i])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* don&#39;t suggest CIDR usage here since we don&#39;t know i=
f it&#39;s a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      * remote address or a netmask */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            remote_netmask =3D getaddr(GETADDR_HOST_ORDE=
R|GETADDR_RESOLVE, p[i++], NULL, 0, NULL, NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>         if (local &amp;&amp; remote_ne=
tmask)</span><br><span>         {</span><br><span>             options-&gt;=
push_ifconfig_defined =3D true;</span><br><span>             options-&gt;pu=
sh_ifconfig_local =3D local;</span><br><span>             options-&gt;push_=
ifconfig_remote_netmask =3D remote_netmask;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            if (p[3])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (p[i])</span><br><span>             =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                opti=
ons-&gt;push_ifconfig_local_alias =3D getaddr(GETADDR_HOST_ORDER|GETADDR_RE=
SOLVE, p[3], 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                options-&gt;push_ifconfig_local_alias =3D getaddr(=
GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[i], NULL, 0, NULL, NULL);</span><br><=
span>             }</span><br><span>         }</span><br><span>         els=
e</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(msglevel, &quot;cannot parse --ifconfig-push address=
es&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(msglevel, &quot;cannot parse --ifconfig-push parameters&quot;);</spa=
n><br><span>             goto err;</span><br><span>         }</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if =
(streq(p[0], &quot;ifconfig-push-constraint&quot;) &amp;&amp; p[1] &amp;&am=
p; p[2] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else if (streq(p[0], &quot;ifconfig-push-constraint&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        in_addr_t network, netmask;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        in_addr_t network;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int ne=
tbits =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 size_t i =3D 1;</span><br><span> </span><br><span>         VERIFY_PERMISSI=
ON(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     network =3D getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[1], 0, NULL,=
 NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        netmas=
k =3D getaddr(GETADDR_HOST_ORDER, p[2], 0, NULL, NULL);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (network &amp;&amp; netmask)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        network =3D g=
etaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[i++], &amp;netbits, 0, NULL, N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!n=
etbits &amp;&amp; p[i])</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      const in_addr_t netmask =3D getaddr(GETADDR_HOST_ORDER, p[2], NULL, 0=
, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       const int nb =3D netmask_to_netbits2(netmask);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (netmask &amp;&amp; nb &gt=
; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                netbi=
ts =3D nb;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (netbits =
&amp;&amp; !no_more_than_n_args(msglevel, p, 2, NM_QUOTE_HINT))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (network &amp;&amp; netbits)</span><br><span>         {</=
span><br><span>             options-&gt;push_ifconfig_constraint_defined =
=3D true;</span><br><span>             options-&gt;push_ifconfig_constraint=
_network =3D network;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            options-&gt;push_ifconfig_constraint_netmask =3D netmask;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;p=
ush_ifconfig_constraint_netbits =3D netbits;</span><br><span>         }</sp=
an><br><span>         else</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;cannot pars=
e --ifconfig-push-constraint addresses&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;cannot parse --i=
fconfig-push-constraint parameters&quot;);</span><br><span>             got=
o err;</span><br><span>         }</span><br><span>     }</span><br><span>di=
ff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>in=
dex f608cb8..88de24c 100644</span><br><span>--- a/src/openvpn/options.h</sp=
an><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -450,7 +450,7 @=
@</span><br><span>     const char *tmp_dir;</span><br><span>     bool serve=
r_defined;</span><br><span>     in_addr_t server_network;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    in_addr_t server_netmask;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int server_netbi=
ts;</span><br><span>     bool server_ipv6_defined;                         =
  /* IPv6 */</span><br><span>     struct in6_addr server_network_ipv6;     =
           /* IPv6 */</span><br><span>     unsigned int server_netbits_ipv6=
;                   /* IPv6 */</span><br><span>@@ -464,7 +464,7 @@</span><b=
r><span> </span><br><span>     bool server_bridge_defined;</span><br><span>=
     in_addr_t server_bridge_ip;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    in_addr_t server_bridge_netmask;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    unsigned int server_bridge_netbits;</span><=
br><span>     in_addr_t server_bridge_pool_start;</span><br><span>     in_a=
ddr_t server_bridge_pool_end;</span><br><span> </span><br><span>@@ -472,7 +=
472,7 @@</span><br><span>     bool ifconfig_pool_defined;</span><br><span> =
    in_addr_t ifconfig_pool_start;</span><br><span>     in_addr_t ifconfig_=
pool_end;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in_addr_=
t ifconfig_pool_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    unsigned int ifconfig_pool_netbits;</span><br><span>     const cha=
r *ifconfig_pool_persist_filename;</span><br><span>     int ifconfig_pool_p=
ersist_refresh_freq;</span><br><span> </span><br><span>@@ -499,7 +499,7 @@<=
/span><br><span>     in_addr_t push_ifconfig_local_alias;</span><br><span> =
    bool push_ifconfig_constraint_defined;</span><br><span>     in_addr_t p=
ush_ifconfig_constraint_network;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    in_addr_t push_ifconfig_constraint_netmask;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    unsigned int push_ifconfig_const=
raint_netbits;</span><br><span>     bool push_ifconfig_ipv4_blocked;       =
             /* IPv4 */</span><br><span>     bool push_ifconfig_ipv6_define=
d;                    /* IPv6 */</span><br><span>     struct in6_addr push_=
ifconfig_ipv6_local;           /* IPv6 */</span><br><span>diff --git a/src/=
openvpn/pool.c b/src/openvpn/pool.c</span><br><span>index e3c3708..84227b6 =
100644</span><br><span>--- a/src/openvpn/pool.c</span><br><span>+++ b/src/o=
penvpn/pool.c</span><br><span>@@ -652,8 +652,8 @@</span><br><span>         =
    if (strlen(ip_buf) &gt; 0)</span><br><span>             {</span><br><sp=
an>                 bool v4_ok =3D true;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                in_addr_t addr =3D getaddr(GETADDR_HOST_=
ORDER, ip_buf, 0, &amp;v4_ok,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                         NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                in_addr_t addr =3D geta=
ddr(GETADDR_HOST_ORDER, ip_buf, NULL, 0,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                         &amp;v4_ok, N=
ULL);</span><br><span> </span><br><span>                 if (!v4_ok)</span>=
<br><span>                 {</span><br><span>diff --git a/src/openvpn/push.=
c b/src/openvpn/push.c</span><br><span>index 6c06374..b8ab470 100644</span>=
<br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c=
</span><br><span>@@ -1136,9 +1136,20 @@</span><br><span>                 if=
 (p[0] &amp;&amp; !strcmp(p[0], &quot;route&quot;) &amp;&amp; !p[3] &amp;&a=
mp; o-&gt;iroutes)</span><br><span>                 {</span><br><span>     =
                /* get route parameters */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    bool status1, status2;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    const in_addr=
_t network =3D getaddr(GETADDR_HOST_ORDER, p[1], 0, &amp;status1, NULL);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    cons=
t in_addr_t netmask =3D getaddr(GETADDR_HOST_ORDER, p[2] ? p[2] : &quot;255=
.255.255.255&quot;, 0, &amp;status2, NULL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    bool status1, status2 =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 int netbits =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  /* get netbits from CIDR or convert netmask to netbits */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    const in_addr_t=
 network =3D getaddr(GETADDR_HOST_ORDER, p[1], (unsigned int *)&amp;netbits=
, 0, &amp;status1, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    if (p[2])</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        const in_addr_t netmask =3D getad=
dr(GETADDR_HOST_ORDER, p[2], NULL, 0, &amp;status2, NULL);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        netbits =3D =
netmask_to_netbits2(netmask);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    if (netbits &lt;=3D 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        netbits =3D 32=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  }</span><br><span> </span><br><span>                     /* did route par=
ameters parse correctly? */</span><br><span>                     if (status=
1 &amp;&amp; status2)</span><br><span>@@ -1148,7 +1159,7 @@</span><br><span=
>                         /* does route match an iroute? */</span><br><span=
>                         for (ir =3D o-&gt;iroutes; ir !=3D NULL; ir =3D i=
r-&gt;next)</span><br><span>                         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                            if (network =
=3D=3D ir-&gt;network &amp;&amp; netmask =3D=3D netbits_to_netmask(ir-&gt;n=
etbits &gt;=3D 0 ? ir-&gt;netbits : 32))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                            if (network =3D=3D ir-&gt;=
network &amp;&amp; netbits =3D=3D (ir-&gt;netbits &gt;=3D 0 ? ir-&gt;netbit=
s : 32))</span><br><span>                             {</span><br><span>   =
                              enable =3D false;</span><br><span>           =
                      break;</span><br><span>diff --git a/src/openvpn/route=
.c b/src/openvpn/route.c</span><br><span>index 91f2032..ee77875 100644</spa=
n><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/rou=
te.c</span><br><span>@@ -189,9 +189,9 @@</span><br><span> route_string(cons=
t struct route_ipv4 *r, struct gc_arena *gc)</span><br><span> {</span><br><=
span>     struct buffer out =3D alloc_buf_gc(256, gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;out, &quot;ROUTE netwo=
rk %s netmask %s gateway %s&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_printf(&amp;out, &quot;ROUTE network %s/%d gateway %=
s&quot;,</span><br><span>                print_in_addr_t(r-&gt;network, 0, =
gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               pr=
int_in_addr_t(r-&gt;netmask, 0, gc),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+               r-&gt;netbits,</span><br><span>            =
    print_in_addr_t(r-&gt;gateway, 0, gc)</span><br><span>                )=
;</span><br><span>     if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><br><=
span>@@ -321,11 +321,17 @@</span><br><span>            const struct route_o=
ption *ro,</span><br><span>            const struct route_list *rl)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
in_addr_t default_netmask =3D IPV4_NETMASK_HOST;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const in_addr_t default_netbits =3D IPV4_N=
ETBITS_HOST;</span><br><span>     bool status;</span><br><span>     int ret=
;</span><br><span>     struct in_addr special =3D {0};</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* separate addres=
s and prefix if present */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char *network =3D strdup(ro-&gt;network);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *cidr =3D strchr(network, =
&#39;/&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *addr =3D strtok(network, &quot;/&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *prefix =3D strtok(NULL, &quo=
t;/&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     CLEAR(*r);</span><br><span>     r-&gt;option =3D ro;</span><b=
r><span> </span><br><span>@@ -355,7 +361,7 @@</span><br><span>     else</sp=
an><br><span>     {</span><br><span>         ret =3D openvpn_getaddrinfo(GE=
TADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                  ro-&gt;network, NULL, 0=
, NULL, AF_INET, network_list);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                  addr, NULL, 0, NULL, AF_INET,=
 network_list);</span><br><span>     }</span><br><span> </span><br><span>  =
   status =3D (ret =3D=3D 0);</span><br><span>@@ -365,25 +371,40 @@</span><=
br><span>         goto fail;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* netmask */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* netbits */</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;net=
bits =3D default_netbits;</span><br><span>     if (is_route_parm_defined(ro=
-&gt;netmask))</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        r-&gt;netmask =3D getaddr(</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        const in_addr_t netmask =3D getaddr(=
</span><br><span>             GETADDR_HOST_ORDER</span><br><span>          =
   | GETADDR_WARN_ON_SIGNAL,</span><br><span>             ro-&gt;netmask,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            NULL,</sp=
an><br><span>             0,</span><br><span>             &amp;status,</spa=
n><br><span>             NULL);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (!status)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const int netbits =3D netmask_to_netbits2(netmask);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!status || netbits &lt; 0)</s=
pan><br><span>         {</span><br><span>             goto fail;</span><br>=
<span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     r-&gt;netbits =3D netbits;</span><br><span>     }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (cidr)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        r-&gt;netmask =3D default=
_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (!prefix) /* handle &#39;aa.bb.cc.dd/&#39; case */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            goto fail;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        char *endp =3D NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        const unsigned long netbits =3D strtoul(p=
refix, &amp;endp, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if ((*endp !=3D &#39;\0&#39;) || (netbits &gt; sizeof(in_addr_t)=
 * 8))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto fail;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        r-&gt;netbits =3D netb=
its;</span><br><span>     }</span><br><span> </span><br><span>     /* gatew=
ay */</span><br><span>@@ -397,6 +418,7 @@</span><br><span>                 =
| GETADDR_HOST_ORDER</span><br><span>                 | GETADDR_WARN_ON_SIG=
NAL,</span><br><span>                 ro-&gt;gateway,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                NULL,</span><br><span>   =
              0,</span><br><span>                 &amp;status,</span><br><s=
pan>                 NULL);</span><br><span>@@ -428,7 +450,7 @@</span><br><=
span>         if (r-&gt;metric &lt; 0)</span><br><span>         {</span><br=
><span>             msg(M_WARN, PACKAGE_NAME &quot; ROUTE: route metric for=
 network %s (%s) must be &gt;=3D 0&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                ro-&gt;network,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                addr,</span><br><span>   =
              ro-&gt;metric);</span><br><span>             goto fail;</span=
><br><span>         }</span><br><span>@@ -442,11 +464,13 @@</span><br><span=
> </span><br><span>     r-&gt;flags |=3D RT_DEFINED;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(network);</span=
><br><span>     return true;</span><br><span> </span><br><span> fail:</span=
><br><span>     msg(M_WARN, PACKAGE_NAME &quot; ROUTE: failed to parse/reso=
lve route for host/network: %s&quot;,</span><br><span>         ro-&gt;netwo=
rk);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(networ=
k);</span><br><span>     return false;</span><br><span> }</span><br><span> =
</span><br><span>@@ -516,7 +540,7 @@</span><br><span>     struct route_opti=
on *ro;</span><br><span>     ALLOC_OBJ_GC(ro, struct route_option, l-&gt;gc=
);</span><br><span>     ro-&gt;network =3D network;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ro-&gt;netmask =3D netmask;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ro-&gt;netmask =3D netmask;=
 /* NULL if network has CIDR notation */</span><br><span>     ro-&gt;gatewa=
y =3D gateway;</span><br><span>     ro-&gt;metric =3D metric;</span><br><sp=
an>     ro-&gt;next =3D l-&gt;routes;</span><br><span>@@ -582,7 +606,7 @@</=
span><br><span>         r1-&gt;flags =3D RT_DEFINED;</span><br><span>      =
   r1-&gt;gateway =3D target;</span><br><span>         r1-&gt;network =3D g=
ateway-&gt;addr &amp; gateway-&gt;netmask;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        r1-&gt;netmask =3D ~(l2-1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        r1-&gt;netbits =3D netmask_to_=
netbits2(gateway-&gt;netmask) + 1;</span><br><span>         r1-&gt;next =3D=
 rl-&gt;routes;</span><br><span>         rl-&gt;routes =3D r1;</span><br><s=
pan> </span><br><span>@@ -681,6 +705,7 @@</span><br><span>             | GE=
TADDR_HOST_ORDER</span><br><span>             | GETADDR_WARN_ON_SIGNAL,</sp=
an><br><span>             remote_endpoint,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            NULL,</span><br><span>             0,</s=
pan><br><span>             &amp;defined,</span><br><span>             NULL)=
;</span><br><span>@@ -921,7 +946,7 @@</span><br><span> </span><br><span> st=
atic bool</span><br><span> add_route3(in_addr_t network,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-           in_addr_t netmask,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+           unsigned int netbit=
s,</span><br><span>            in_addr_t gateway,</span><br><span>         =
   const struct tuntap *tt,</span><br><span>            unsigned int flags,=
</span><br><span>@@ -933,14 +958,14 @@</span><br><span>     CLEAR(r);</span=
><br><span>     r.flags =3D RT_DEFINED;</span><br><span>     r.network =3D =
network;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r.netmask=
 =3D netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r.=
netbits =3D netbits;</span><br><span>     r.gateway =3D gateway;</span><br>=
<span>     return add_route(&amp;r, tt, flags, rgi, es, ctx);</span><br><sp=
an> }</span><br><span> </span><br><span> static void</span><br><span> del_r=
oute3(in_addr_t network,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-           in_addr_t netmask,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+           unsigned int netbits,</span><br><span>            i=
n_addr_t gateway,</span><br><span>            const struct tuntap *tt,</spa=
n><br><span>            unsigned int flags,</span><br><span>@@ -952,7 +977,=
7 @@</span><br><span>     CLEAR(r);</span><br><span>     r.flags =3D RT_DEF=
INED|RT_ADDED;</span><br><span>     r.network =3D network;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    r.netmask =3D netmask;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    r.netbits =3D netbits;</spa=
n><br><span>     r.gateway =3D gateway;</span><br><span>     delete_route(&=
amp;r, tt, flags, rgi, es, ctx);</span><br><span> }</span><br><span>@@ -971=
,7 +996,7 @@</span><br><span>     {</span><br><span>         if (rb-&gt;byp=
ass[i])</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            ret =3D add_route3(rb-&gt;bypass[i], IPV4_NETMASK_=
HOST, gateway, tt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           ret =3D add_route3(rb-&gt;bypass[i], IPV4_NETBITS_HOST, gateway,=
 tt,</span><br><span>                              flags | ROUTE_REF_GW, rg=
i, es, ctx) &amp;&amp; ret;</span><br><span>         }</span><br><span>    =
 }</span><br><span>@@ -993,7 +1018,7 @@</span><br><span>         if (rb-&gt=
;bypass[i])</span><br><span>         {</span><br><span>             del_rou=
te3(rb-&gt;bypass[i],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                       IPV4_NETMASK_HOST,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                       IPV4_NETBITS_HOST,</span><br><=
span>                        gateway,</span><br><span>                     =
   tt,</span><br><span>                        flags | ROUTE_REF_GW,</span>=
<br><span>@@ -1057,7 +1082,7 @@</span><br><span>                 if ((rl-&g=
t;spec.flags &amp; RTSA_REMOTE_HOST)</span><br><span>                     &=
amp;&amp; rl-&gt;spec.remote_host !=3D IPV4_INVALID_ADDR)</span><br><span> =
                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                ret =3D add_route3(rl-&gt;spec.remote_host, IPV4_NETMASK_HO=
ST,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    ret =3D add_route3(rl-&gt;spec.remote_host, IPV4_NETBITS_HOST,</span><b=
r><span>                                      rl-&gt;rgi.gateway.addr, tt, =
flags | ROUTE_REF_GW,</span><br><span>                                     =
 &amp;rl-&gt;rgi, es, ctx);</span><br><span>                     rl-&gt;ifl=
ags |=3D RL_DID_LOCAL;</span><br><span>@@ -1078,11 +1103,11 @@</span><br><s=
pan>                 if (rl-&gt;flags &amp; RG_DEF1)</span><br><span>      =
           {</span><br><span>                     /* add new default route =
(1st component) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 ret =3D add_route3(0x00000000, 0x80000000, rl-&gt;spec.rem=
ote_endpoint,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              ret =3D add_route3(0x00000000, 1, rl-&gt;spec.remote_endpoint=
,</span><br><span>                                      tt, flags, &amp;rl-=
&gt;rgi, es, ctx) &amp;&amp; ret;</span><br><span> </span><br><span>       =
              /* add new default route (2nd component) */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    ret =3D add_route3(=
0x80000000, 0x80000000, rl-&gt;spec.remote_endpoint,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    ret =3D add_route3(0x=
80000000, 1, rl-&gt;spec.remote_endpoint,</span><br><span>                 =
                     tt, flags, &amp;rl-&gt;rgi, es, ctx) &amp;&amp; ret;</=
span><br><span>                 }</span><br><span>                 else</sp=
an><br><span>@@ -1120,7 +1145,7 @@</span><br><span>         if (rl-&gt;ifla=
gs &amp; RL_DID_LOCAL)</span><br><span>         {</span><br><span>         =
    del_route3(rl-&gt;spec.remote_host,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                       IPV4_NETMASK_HOST,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                       IPV4_NETBITS=
_HOST,</span><br><span>                        rl-&gt;rgi.gateway.addr,</sp=
an><br><span>                        tt,</span><br><span>                  =
      flags | ROUTE_REF_GW,</span><br><span>@@ -1140,7 +1165,7 @@</span><br=
><span>             {</span><br><span>                 /* delete default ro=
ute (1st component) */</span><br><span>                 del_route3(0x000000=
00,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
         0x80000000,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                           1,</span><br><span>                            =
rl-&gt;spec.remote_endpoint,</span><br><span>                            tt=
,</span><br><span>                            flags,</span><br><span>@@ -11=
50,7 +1175,7 @@</span><br><span> </span><br><span>                 /* delet=
e default route (2nd component) */</span><br><span>                 del_rou=
te3(0x80000000,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                     0x80000000,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                           1,</span><br><span>                =
            rl-&gt;spec.remote_endpoint,</span><br><span>                  =
          tt,</span><br><span>                            flags,</span><br>=
<span>@@ -1215,7 +1240,7 @@</span><br><span> </span><br><span>         for =
(r =3D rl-&gt;routes; r; r =3D r-&gt;next)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            check_subnet_co=
nflict(r-&gt;network, r-&gt;netmask, &quot;route&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            check_subnet_conflict(r-&g=
t;network, netbits_to_netmask((int)r-&gt;netbits), &quot;route&quot;);</spa=
n><br><span>             if (flags &amp; ROUTE_DELETE_FIRST)</span><br><spa=
n>             {</span><br><span>                 delete_route(r, tt, flags=
, &amp;rl-&gt;rgi, es, ctx);</span><br><span>@@ -1432,14 +1457,18 @@</span>=
<br><span>     if (r-&gt;flags &amp; RT_DEFINED)</span><br><span>     {</sp=
an><br><span>         setenv_route_addr(es, &quot;network&quot;, r-&gt;netw=
ork, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        seten=
v_route_addr(es, &quot;netmask&quot;, r-&gt;netmask, i);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        setenv_route_addr(es, &quot;ne=
tmask&quot;, netbits_to_netmask(r-&gt;netbits), i);</span><br><span>       =
  setenv_route_addr(es, &quot;gateway&quot;, r-&gt;gateway, i);</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t buffer name1 =3D alloc_buf_gc(256, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        buf_printf(&amp;name1, &quot;route_netbi=
ts_%d&quot;, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     setenv_int(es, BSTR(&amp;name1), (int)r-&gt;netbits);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (r-&gt;=
flags &amp; RT_METRIC_DEFINED)</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            struct buffer name =3D allo=
c_buf_gc(256, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            buf_printf(&amp;name, &quot;route_metric_%d&quot;, i);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            setenv_int(es, B=
STR(&amp;name), r-&gt;metric);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            struct buffer name2 =3D alloc_buf_gc(256, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_prin=
tf(&amp;name2, &quot;route_metric_%d&quot;, i);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            setenv_int(es, BSTR(&amp;name2), r-=
&gt;metric);</span><br><span>         }</span><br><span>     }</span><br><s=
pan>     gc_free(&amp;gc);</span><br><span>@@ -1519,7 +1548,7 @@</span><br>=
<span> </span><br><span> static int</span><br><span> local_route(in_addr_t =
network,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
n_addr_t netmask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          unsigned int netbits,</span><br><span>             in_addr_t gate=
way,</span><br><span>             const struct route_gateway_info *rgi)</sp=
an><br><span> {</span><br><span>@@ -1528,7 +1557,7 @@</span><br><span>     =
if (rgi</span><br><span>         &amp;&amp; (rgi-&gt;flags &amp; rgi_needed=
) =3D=3D rgi_needed</span><br><span>         &amp;&amp; gateway =3D=3D rgi-=
&gt;gateway.addr</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   &amp;&amp; netmask =3D=3D 0xFFFFFFFF)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        &amp;&amp; netbits =3D=3D IPV4_NETBITS_HOST)</=
span><br><span>     {</span><br><span>         if (((network ^  rgi-&gt;gat=
eway.addr) &amp; rgi-&gt;gateway.netmask) =3D=3D 0)</span><br><span>       =
  {</span><br><span>@@ -1583,12 +1612,12 @@</span><br><span> #if !defined(T=
ARGET_LINUX)</span><br><span>     const char *network =3D print_in_addr_t(r=
-&gt;network, 0, &amp;gc);</span><br><span> #if !defined(TARGET_AIX)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *netmask =3D =
print_in_addr_t(r-&gt;netmask, 0, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *netmask =3D print_in_addr_t(netbits=
_to_netmask((int)r-&gt;netbits), 0, &amp;gc);</span><br><span> #endif</span=
><br><span>     const char *gateway =3D print_in_addr_t(r-&gt;gateway, 0, &=
amp;gc);</span><br><span> #endif</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    is_local_route =3D local_route(r-&gt;netwo=
rk, r-&gt;netmask, r-&gt;gateway, rgi);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    is_local_route =3D local_route(r-&gt;network, r-&gt=
;netbits, r-&gt;gateway, rgi);</span><br><span>     if (is_local_route =3D=
=3D LR_ERROR)</span><br><span>     {</span><br><span>         goto done;</s=
pan><br><span>@@ -1609,7 +1638,7 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     status =3D RTA_SUCCESS;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int ret =3D net_route_v4_add(ctx, &amp;r-&gt;n=
etwork, netmask_to_netbits2(r-&gt;netmask),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int ret =3D net_route_v4_add(ctx, &amp;r-&gt;ne=
twork, (int)r-&gt;netbits,</span><br><span>                                =
&amp;r-&gt;gateway, iface, 0, metric);</span><br><span>     if (ret =3D=3D =
-EEXIST)</span><br><span>     {</span><br><span>@@ -1840,10 +1869,9 @@</spa=
n><br><span> #elif defined(TARGET_AIX)</span><br><span> </span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int netbi=
ts =3D netmask_to_netbits2(r-&gt;netmask);</span><br><span>         argv_pr=
intf(&amp;argv, &quot;%s add -net %s/%d %s&quot;,</span><br><span>         =
            ROUTE_PATH,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    network, netbits, gateway);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    network, r-&gt;netbits, g=
ateway);</span><br><span>         argv_msg(D_ROUTE, &amp;argv);</span><br><=
span>         bool ret =3D openvpn_execve_check(&amp;argv, es, 0,</span><br=
><span>                                         &quot;ERROR: AIX route add =
command failed&quot;);</span><br><span>@@ -2176,14 +2204,14 @@</span><br><s=
pan> #if !defined(TARGET_LINUX)</span><br><span>     network =3D print_in_a=
ddr_t(r-&gt;network, 0, &amp;gc);</span><br><span> #if !defined(TARGET_AIX)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    netmask =3D print=
_in_addr_t(r-&gt;netmask, 0, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    netmask =3D print_in_addr_t(netbits_to_netmask((int)=
r-&gt;netbits), 0, &amp;gc);</span><br><span> #endif</span><br><span> #if !=
defined(TARGET_ANDROID)</span><br><span>     gateway =3D print_in_addr_t(r-=
&gt;gateway, 0, &amp;gc);</span><br><span> #endif</span><br><span> #endif</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
s_local_route =3D local_route(r-&gt;network, r-&gt;netmask, r-&gt;gateway, =
rgi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    is_local_r=
oute =3D local_route(r-&gt;network, r-&gt;netbits, r-&gt;gateway, rgi);</sp=
an><br><span>     if (is_local_route =3D=3D LR_ERROR)</span><br><span>     =
{</span><br><span>         goto done;</span><br><span>@@ -2196,7 +2224,7 @@=
</span><br><span>         metric =3D r-&gt;metric;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (net_route_v4_del(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netm=
ask),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (net_ro=
ute_v4_del(ctx, &amp;r-&gt;network, (int)r-&gt;netbits,</span><br><span>   =
                       &amp;r-&gt;gateway, NULL, 0, metric) &lt; 0)</span><=
br><span>     {</span><br><span>         msg(M_WARN, &quot;ERROR: Linux rou=
te delete command failed&quot;);</span><br><span>@@ -2318,10 +2346,9 @@</sp=
an><br><span> #elif defined(TARGET_AIX)</span><br><span> </span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int netb=
its =3D netmask_to_netbits2(r-&gt;netmask);</span><br><span>         argv_p=
rintf(&amp;argv, &quot;%s delete -net %s/%d %s&quot;,</span><br><span>     =
                ROUTE_PATH,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    network, netbits, gateway);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    network, r-&gt;netbit=
s, gateway);</span><br><span>         argv_msg(D_ROUTE, &amp;argv);</span><=
br><span>         openvpn_execve_check(&amp;argv, es, 0, &quot;ERROR: AIX r=
oute delete command failed&quot;);</span><br><span>     }</span><br><span>@=
@ -2840,13 +2867,14 @@</span><br><span>     int ret =3D RTA_ERROR;</span><b=
r><span>     DWORD status;</span><br><span>     const DWORD if_index =3D (a=
dapter_index =3D=3D TUN_ADAPTER_INDEX_INVALID) ? windows_route_find_if_inde=
x(r, tt) : adapter_index;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const in_addr_t netmask =3D netbits_to_netmask((int)r-&gt;netbits=
);</span><br><span> </span><br><span>     if (if_index !=3D TUN_ADAPTER_IND=
EX_INVALID)</span><br><span>     {</span><br><span>         MIB_IPFORWARDRO=
W fr;</span><br><span>         CLEAR(fr);</span><br><span>         fr.dwFor=
wardDest =3D htonl(r-&gt;network);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        fr.dwForwardMask =3D htonl(r-&gt;netmask);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        fr.dwForwardMask =3D ht=
onl(netmask);</span><br><span>         fr.dwForwardPolicy =3D 0;</span><br>=
<span>         fr.dwForwardNextHop =3D htonl(r-&gt;gateway);</span><br><spa=
n>         fr.dwForwardIfIndex =3D if_index;</span><br><span>@@ -2860,11 +2=
888,11 @@</span><br><span>         fr.dwForwardMetric4 =3D METRIC_NOT_USED;=
</span><br><span>         fr.dwForwardMetric5 =3D METRIC_NOT_USED;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
(r-&gt;network &amp; r-&gt;netmask) !=3D r-&gt;network)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if ((r-&gt;network &amp; netmas=
k) !=3D r-&gt;network)</span><br><span>         {</span><br><span>         =
    msg(M_WARN, &quot;Warning: address %s is not a network address in relat=
ion to netmask %s&quot;,</span><br><span>                 print_in_addr_t(r=
-&gt;network, 0, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                print_in_addr_t(r-&gt;netmask, 0, &amp;gc));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                print_in_addr=
_t(netmask, 0, &amp;gc));</span><br><span>         }</span><br><span> </spa=
n><br><span>         status =3D CreateIpForwardEntry(&amp;fr);</span><br><s=
pan>@@ -2932,6 +2960,7 @@</span><br><span>     bool ret =3D false;</span><b=
r><span>     DWORD status;</span><br><span>     const DWORD if_index =3D wi=
ndows_route_find_if_index(r, tt);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const in_addr_t netmask =3D netbits_to_netmask((int)r-&gt=
;netbits);</span><br><span> </span><br><span>     if (if_index !=3D TUN_ADA=
PTER_INDEX_INVALID)</span><br><span>     {</span><br><span>@@ -2939,7 +2968=
,7 @@</span><br><span>         CLEAR(fr);</span><br><span> </span><br><span=
>         fr.dwForwardDest =3D htonl(r-&gt;network);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        fr.dwForwardMask =3D htonl(r-&gt;ne=
tmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fr.d=
wForwardMask =3D htonl(netmask);</span><br><span>         fr.dwForwardPolic=
y =3D 0;</span><br><span>         fr.dwForwardNextHop =3D htonl(r-&gt;gatew=
ay);</span><br><span>         fr.dwForwardIfIndex =3D if_index;</span><br><=
span>@@ -3016,7 +3045,7 @@</span><br><span>         .metric =3D (r-&gt;flag=
s &amp; RT_METRIC_DEFINED ? r-&gt;metric : -1)</span><br><span>     };</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    netm=
ask_to_netbits(r-&gt;network, r-&gt;netmask, &amp;msg.prefix_len);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg.prefix_len =3D r-&gt=
;netbits;</span><br><span>     if (msg.prefix_len =3D=3D -1)</span><br><spa=
n>     {</span><br><span>         msg.prefix_len =3D 32;</span><br><span>@@=
 -3996,7 +4025,7 @@</span><br><span>     while (iplist)</span><br><span>   =
  {</span><br><span>         bool succeed =3D false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const in_addr_t ip =3D getaddr(GETA=
DDR_HOST_ORDER, iplist-&gt;IpAddress.String, 0, &amp;succeed, NULL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        const in_addr_t ip=
 =3D getaddr(GETADDR_HOST_ORDER, iplist-&gt;IpAddress.String, NULL, 0, &amp=
;succeed, NULL);</span><br><span>         if (succeed)</span><br><span>    =
     {</span><br><span>             add_host_route_if_nonlocal(rb, ip);</sp=
an><br><span>@@ -4096,7 +4125,7 @@</span><br><span> {</span><br><span>     =
if (rgi)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (local_route(addr, 0xFFFFFFFF, rgi-&gt;gateway.addr, r=
gi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (loc=
al_route(addr, IPV4_NETBITS_HOST, rgi-&gt;gateway.addr, rgi))</span><br><sp=
an>         {</span><br><span>             return TLA_LOCAL;</span><br><spa=
n>         }</span><br><span>diff --git a/src/openvpn/route.h b/src/openvpn=
/route.h</span><br><span>index 421e7d2..a117584 100644</span><br><span>--- =
a/src/openvpn/route.h</span><br><span>+++ b/src/openvpn/route.h</span><br><=
span>@@ -117,7 +117,7 @@</span><br><span>     unsigned int flags;</span><br=
><span>     const struct route_option *option;</span><br><span>     in_addr=
_t network;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in_add=
r_t netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uns=
igned int netbits;</span><br><span>     in_addr_t gateway;</span><br><span>=
     int metric;</span><br><span> };</span><br><span>diff --git a/src/openv=
pn/socket.c b/src/openvpn/socket.c</span><br><span>index 17c5e76..767036f 1=
00644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/=
openvpn/socket.c</span><br><span>@@ -179,6 +179,7 @@</span><br><span> in_ad=
dr_t</span><br><span> getaddr(unsigned int flags,</span><br><span>         =
const char *hostname,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        unsigned int *netbits,</span><br><span>         int resolve_retry=
_seconds,</span><br><span>         bool *succeeded,</span><br><span>       =
  struct signal_info *sig_info)</span><br><span>@@ -186,7 +187,7 @@</span><=
br><span>     in_addr_t addr;</span><br><span>     int status;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D g=
et_addr_generic(AF_INET, flags, hostname, &amp;addr, NULL,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    status =3D get_addr_generic(AF_I=
NET, flags, hostname, &amp;addr, netbits,</span><br><span>                 =
              resolve_retry_seconds, sig_info,</span><br><span>            =
                   M_WARN);</span><br><span>     if (status=3D=3D0)</span><=
br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br=
><span>index 47083ad..f6165b2 100644</span><br><span>--- a/src/openvpn/sock=
et.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -524,6 +=
524,7 @@</span><br><span>  */</span><br><span> in_addr_t getaddr(unsigned i=
nt flags,</span><br><span>                   const char *hostname,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                  unsigned i=
nt *netbits,</span><br><span>                   int resolve_retry_seconds,<=
/span><br><span>                   bool *succeeded,</span><br><span>       =
            struct signal_info *sig_info);</span><br><span>diff --git a/src=
/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 739e008..52e2464 1=
00644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/ope=
nvpn/tun.c</span><br><span>@@ -113,7 +113,7 @@</span><br><span>     if (add=
r.family =3D=3D AF_INET)</span><br><span>     {</span><br><span>         ad=
dr.address.ipv4.s_addr =3D htonl(tt-&gt;local);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        addr.prefix_len =3D netmask_to_netbits2(t=
t-&gt;adapter_netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        addr.prefix_len =3D tt-&gt;netbits;</span><br><span>         ms=
g(D_IFCONFIG, &quot;INET address service: %s %s/%d&quot;,</span><br><span> =
            add ? &quot;add&quot; : &quot;remove&quot;,</span><br><span>   =
          print_in_addr_t(tt-&gt;local, 0, &amp;gc), addr.prefix_len);</spa=
n><br><span>@@ -499,17 +499,17 @@</span><br><span> static const char ifconf=
ig_warn_how_to_silence[] =3D &quot;(silence this warning with --ifconfig-no=
warn)&quot;;</span><br><span> </span><br><span> /*</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * If !tun_p2p, make sure ifconfig_remote_netm=
ask looks</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  like a n=
etmask.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If !tun_p=
2p, make sure either ifconfig_netbits is</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * set or ifconfig_remote looks like a netmask.</span>=
<br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If tu=
n_p2p, make sure ifconfig_remote_netmask looks</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * If tun_p2p, make sure ifconfig_remote looks</=
span><br><span>  *  like an IPv4 address.</span><br><span>  */</span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifcon=
fig_sanity_check(bool tun_p2p, in_addr_t addr)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ifconfig_sanity_check(bool tun_p2p, in_addr_t ad=
dr, int netbits)</span><br><span> {</span><br><span>     struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st bool looks_like_netmask =3D ((addr &amp; 0xFF000000) =3D=3D 0xFF000000);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const bool look=
s_like_netmask =3D addr &amp;&amp; ((addr &amp; 0xFF000000) =3D=3D 0xFF0000=
00);</span><br><span>     if (tun_p2p)</span><br><span>     {</span><br><sp=
an>         if (looks_like_netmask)</span><br><span>@@ -521,9 +521,11 @@</s=
pan><br><span>     }</span><br><span>     else</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!looks_like_net=
mask)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ne=
tbits &lt; 0 || !looks_like_netmask)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WAR=
NING: Since you are using subnet topology, the second argument to --ifconfi=
g must be a netmask, for example something like 255.255.255.0. %s&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN=
, &quot;WARNING: Since you are using topology subnet, you must either &quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &q=
uot;provide a valid prefix length in the first argument of --ifconfig (eg. =
10.8.0.0/24) &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &quot;or a valid netmask as the second argument (eg. 255.25=
5.255.0). %s&quot;,</span><br><span>                 ifconfig_warn_how_to_s=
ilence);</span><br><span>         }</span><br><span>     }</span><br><span>=
@@ -539,34 +541,36 @@</span><br><span>                  int type,</span><br=
><span>                  in_addr_t public,</span><br><span>                =
  in_addr_t local,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
              in_addr_t remote_netmask)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                 in_addr_t remote,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                 int netbits)</span><br>=
<span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><s=
pan> #if 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_I=
NFO, &quot;CHECK_ADDR_CLASH type=3D%d public=3D%s local=3D%s, remote_netmas=
k=3D%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ms=
g(M_INFO, &quot;CHECK_ADDR_CLASH type=3D%d public=3D%s local=3D%s, netbits=
=3D%d, remote=3D%s&quot;,</span><br><span>         type,</span><br><span>  =
       print_in_addr_t(public, 0, &amp;gc),</span><br><span>         print_=
in_addr_t(local, 0, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        print_in_addr_t(remote_netmask, 0, &amp;gc));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        netbits,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        print_in_addr_t(remote, 0, &=
amp;gc));</span><br><span> #endif</span><br><span> </span><br><span>     if=
 (public)</span><br><span>     {</span><br><span>         if (type =3D=3D D=
EV_TYPE_TUN)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            const in_addr_t test_netmask =3D 0xFFFFFF00;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const in_a=
ddr_t public_net =3D public &amp;test_netmask;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            const in_addr_t local_net =3D local &a=
mp; test_netmask;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        const in_addr_t remote_net =3D remote_netmask &amp; test_netmask;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const in_=
addr_t netmask =3D netbits &lt; 0 ? 0xFFFFFF00 : netbits_to_netmask(netbits=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const=
 in_addr_t public_net =3D public &amp;netmask;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            const in_addr_t local_net =3D local =
&amp; netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       const in_addr_t remote_net =3D remote &amp; netmask;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (pub=
lic =3D=3D local || public =3D=3D remote_netmask)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (public =3D=3D local || public=
 =3D=3D remote)</span><br><span>             {</span><br><span>            =
     msg(M_WARN,</span><br><span>                     &quot;WARNING: --%s a=
ddress [%s] conflicts with --ifconfig address pair [%s, %s]. %s&quot;,</spa=
n><br><span>                     name,</span><br><span>                    =
 print_in_addr_t(public, 0, &amp;gc),</span><br><span>                     =
print_in_addr_t(local, 0, &amp;gc),</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    print_in_addr_t(remote_netmask, 0, &amp;g=
c),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    print_in_addr_t(remote, 0, &amp;gc),</span><br><span>                  =
   ifconfig_warn_how_to_silence);</span><br><span>             }</span><br>=
<span> </span><br><span>@@ -577,22 +581,23 @@</span><br><span>             =
        name,</span><br><span>                     print_in_addr_t(public, =
0, &amp;gc),</span><br><span>                     print_in_addr_t(local, 0,=
 &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         print_in_addr_t(remote_netmask, 0, &amp;gc),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    print_in_addr_t(remot=
e ? remote : netmask, 0, &amp;gc),</span><br><span>                     ifc=
onfig_warn_how_to_silence);</span><br><span>             }</span><br><span>=
         }</span><br><span>         else if (type =3D=3D DEV_TYPE_TAP)</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            const in_addr_t public_network =3D public &amp;remote_netmask;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const in_=
addr_t virtual_network =3D local &amp; remote_netmask;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (public_network =3D=3D virt=
ual_network)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     const in_addr_t netmask =3D netbits_to_netmask(netbits);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            const in_addr_t publi=
c_network =3D public &amp;netmask;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            const in_addr_t virtual_network =3D local &amp; =
netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (netmask &amp;&amp; public_network =3D=3D virtual_network)</span><br><s=
pan>             {</span><br><span>                 msg(M_WARN,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;WARNING=
: --%s address [%s] conflicts with --ifconfig subnet [%s, %s] -- local and =
remote addresses cannot be inside of the --ifconfig subnet. %s&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot=
;WARNING: --%s address [%s] conflicts with --ifconfig subnet [%s/%d] -- loc=
al and remote addresses cannot be inside of the --ifconfig subnet. %s&quot;=
,</span><br><span>                     name,</span><br><span>              =
       print_in_addr_t(public, 0, &amp;gc),</span><br><span>               =
      print_in_addr_t(local, 0, &amp;gc),</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    print_in_addr_t(remote_netmask, 0, =
&amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          netbits,</span><br><span>                     ifconfig_warn_how_t=
o_silence);</span><br><span>             }</span><br><span>         }</span=
><br><span>@@ -669,9 +674,10 @@</span><br><span>     {</span><br><span>    =
     if (!is_tun_p2p(tt))</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            const in_addr_t netmask =3D n=
etbits_to_netmask(tt-&gt;netbits);</span><br><span>             buf_printf(=
&amp;out, &quot;%s %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                       print_in_addr_t(tt-&gt;local &amp; tt-&gt;rem=
ote_netmask, 0, gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                      print_in_addr_t(tt-&gt;remote_netmask, 0, gc));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                       pr=
int_in_addr_t(tt-&gt;local &amp; netmask, 0, gc),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                       print_in_addr_t(netmas=
k, 0, gc));</span><br><span>         }</span><br><span>         else if (tt=
-&gt;type =3D=3D DEV_TYPE_TUN) /* tun p2p topology */</span><br><span>     =
    {</span><br><span>@@ -679,12 +685,12 @@</span><br><span>             if=
 (remote)</span><br><span>             {</span><br><span>                 r=
 =3D print_in_addr_t(tt-&gt;local, 0, gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                l =3D print_in_addr_t(tt-&gt;remote_ne=
tmask, 0, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           l =3D print_in_addr_t(tt-&gt;remote, 0, gc);</span><br><span>   =
          }</span><br><span>             else</span><br><span>             =
{</span><br><span>                 l =3D print_in_addr_t(tt-&gt;local, 0, g=
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                r =
=3D print_in_addr_t(tt-&gt;remote_netmask, 0, gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                r =3D print_in_addr_t(tt-&gt=
;remote, 0, gc);</span><br><span>             }</span><br><span>           =
  buf_printf(&amp;out, &quot;%s %s&quot;, r, l);</span><br><span>         }=
</span><br><span>@@ -765,7 +771,8 @@</span><br><span> {</span><br><span>   =
  struct gc_arena gc =3D gc_new();</span><br><span>     const char *ifconfi=
g_local =3D print_in_addr_t(tt-&gt;local, 0, &amp;gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const char *ifconfig_remote_netmask =
=3D print_in_addr_t(tt-&gt;remote_netmask, 0, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *ifconfig_remote =3D tt-=
&gt;remote ? print_in_addr_t(tt-&gt;remote, 0, &amp;gc) : NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char *ifconfig_netmas=
k =3D tt-&gt;netbits &gt;=3D 0 ? print_in_addr_t(netbits_to_netmask(tt-&gt;=
netbits), 0, &amp;gc) : NULL;</span><br><span> </span><br><span>     /*</sp=
an><br><span>      * Set environmental variables with ifconfig parameters.<=
/span><br><span>@@ -777,11 +784,12 @@</span><br><span>         setenv_str(e=
s, &quot;ifconfig_local&quot;, ifconfig_local);</span><br><span>         if=
 (tun)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            setenv_str(es, &quot;ifconfig_remote&quot;, ifconfi=
g_remote_netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           setenv_str(es, &quot;ifconfig_remote&quot;, ifconfig_remote);</s=
pan><br><span>         }</span><br><span>         else</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            set=
env_str(es, &quot;ifconfig_netmask&quot;, ifconfig_remote_netmask);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            setenv_int(es, =
&quot;ifconfig_netbits&quot;, tt-&gt;netbits);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            setenv_str(es, &quot;ifconfig_netmas=
k&quot;, ifconfig_netmask);</span><br><span>         }</span><br><span>    =
 }</span><br><span> </span><br><span>@@ -837,7 +845,7 @@</span><br><span>  =
       bool tun_p2p =3D is_tun_p2p(tt);</span><br><span> </span><br><span> =
        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * =
Convert arguments to binary IPv4 addresses.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         * Convert arguments to binary IPv4 address=
es and netbits.</span><br><span>          */</span><br><span> </span><br><s=
pan>         tt-&gt;local =3D getaddr(</span><br><span>@@ -846,27 +854,48 @=
@</span><br><span>             | GETADDR_FATAL_ON_SIGNAL</span><br><span>  =
           | GETADDR_FATAL,</span><br><span>             ifconfig_local_par=
m,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            NULL,=
</span><br><span>             0,</span><br><span>             NULL,</span><=
br><span>             NULL);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        tt-&gt;remote_netmask =3D getaddr(</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;remote =3D g=
etaddr(</span><br><span>             (tun_p2p ? GETADDR_RESOLVE : 0)</span>=
<br><span>             | GETADDR_HOST_ORDER</span><br><span>             | =
GETADDR_FATAL_ON_SIGNAL</span><br><span>             | GETADDR_FATAL,</span=
><br><span>             ifconfig_remote_netmask_parm,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            NULL,</span><br><span>       =
      0,</span><br><span>             NULL,</span><br><span>             NU=
LL);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* in p2p mode discard the netbits otherwise discard the remote =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!tun_=
p2p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (tt-&gt;re=
mote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                tt-&=
gt;netbits =3D netmask_to_netbits2(tt-&gt;remote);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                tt-&gt;remote =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(M_FATAL, &quot;init_t=
un: can not figure out the subnet from the remote parameter (%s)&quot;, ifc=
onfig_remote_netmask_parm);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            tt-&gt;remote =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
tt-&gt;netbits =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>         /*</span><br><span>          * Look for common errors in=
 --ifconfig parms</span><br><span>          */</span><br><span>         if =
(strict_warn)</span><br><span>         {</span><br><span>             struc=
t addrinfo *curele;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          ifconfig_sanity_check(tun_p2p, tt-&gt;remote_netmask);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            ifconfig_sanity_ch=
eck(tun_p2p, tt-&gt;remote, tt-&gt;netbits);</span><br><span> </span><br><s=
pan>             /*</span><br><span>              * If local_public or remo=
te_public addresses are defined,</span><br><span>@@ -877,11 +906,13 @@</spa=
n><br><span>             {</span><br><span>                 if (curele-&gt;=
ai_family =3D=3D AF_INET)</span><br><span>                 {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    const in_addr_=
t local =3D ntohl(((struct sockaddr_in *)curele-&gt;ai_addr)-&gt;sin_addr.s=
_addr);</span><br><span>                     check_addr_clash(&quot;local&q=
uot;,</span><br><span>                                      tt-&gt;type,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
             ((struct sockaddr_in *)curele-&gt;ai_addr)-&gt;sin_addr.s_addr=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                   local,</span><br><span>                                 =
     tt-&gt;local,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                                  tt-&gt;remote_netmask);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
tt-&gt;remote,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                tt-&gt;netbits);</span><br><span>          =
       }</span><br><span>             }</span><br><span> </span><br><span>@=
@ -889,17 +920,19 @@</span><br><span>             {</span><br><span>       =
          if (curele-&gt;ai_family =3D=3D AF_INET)</span><br><span>        =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           const in_addr_t remote =3D ntohl(((struct sockaddr_in *)curele-&=
gt;ai_addr)-&gt;sin_addr.s_addr);</span><br><span>                     chec=
k_addr_clash(&quot;remote&quot;,</span><br><span>                          =
            tt-&gt;type,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                     ((struct sockaddr_in *)curele-&gt;a=
i_addr)-&gt;sin_addr.s_addr,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                     remote,</span><br><span>     =
                                 tt-&gt;local,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                     tt-&gt;remote=
_netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                            tt-&gt;remote,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                     tt-&gt;netbits)=
;</span><br><span>                 }</span><br><span>             }</span><=
br><span> </span><br><span>             if (!tun_p2p)</span><br><span>     =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    check_subnet_conflict(tt-&gt;local, tt-&gt;remote_netmask, &quot;TUN/TA=
P adapter&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              check_subnet_conflict(tt-&gt;local, netbits_to_netmask(tt-&gt=
;netbits), &quot;TUN/TAP adapter&quot;);</span><br><span>             }</sp=
an><br><span>             else</span><br><span>             {</span><br><sp=
an>@@ -914,12 +947,12 @@</span><br><span>          */</span><br><span>     =
    if (tun_p2p)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            verify_255_255_255_252(tt-&gt;local, tt-&=
gt;remote_netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            verify_255_255_255_252(tt-&gt;local, tt-&gt;remote);</span><br>=
<span>             tt-&gt;adapter_netmask =3D ~3;</span><br><span>         =
}</span><br><span>         else</span><br><span>         {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            tt-&gt;adapter_netmask =3D=
 tt-&gt;remote_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            tt-&gt;adapter_netmask =3D netbits_to_netmask(tt-&gt;netbit=
s);</span><br><span>         }</span><br><span> #endif</span><br><span> </s=
pan><br><span>@@ -1062,8 +1095,9 @@</span><br><span> create_arbitrary_remot=
e( struct tuntap *tt )</span><br><span> {</span><br><span>     in_addr_t re=
mote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const in_a=
ddr_t netmask =3D netbits_to_netmask(tt-&gt;netbits);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    remote =3D (tt-&gt;lo=
cal &amp; tt-&gt;remote_netmask) +1;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    remote =3D (tt-&gt;local &amp; netmask) +1;</span><br>=
<span> </span><br><span>     if (remote =3D=3D tt-&gt;local)</span><br><spa=
n>     {</span><br><span>@@ -1300,7 +1334,13 @@</span><br><span> </span><br=
><span> #if !defined(TARGET_LINUX)</span><br><span>     const char *ifconfi=
g_local =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
const char *ifconfig_remote_netmask =3D NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if !defined(_WIN32)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *ifconfig_remote =3D NULL;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_FREEBSD) &amp;&amp;=
 !defined(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *ifconfig_netmask =3D NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const in_addr_t netmask =3D netbits_to_n=
etmask(tt-&gt;netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span>     struct argv argv =3D argv_new();</span><br>=
<span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><sp=
an>@@ -1308,7 +1348,12 @@</span><br><span>      * Set ifconfig parameters</=
span><br><span>      */</span><br><span>     ifconfig_local =3D print_in_ad=
dr_t(tt-&gt;local, 0, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    ifconfig_remote_netmask =3D print_in_addr_t(tt-&gt;remote_net=
mask, 0, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if !defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ifconfig_remote =3D print_in_addr_t(tt-&gt;remote, 0, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if !defined(TARGET_FREEBSD) &amp;&amp; =
!defined(TARGET_DRAGONFLY)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ifconfig_netmask =3D print_in_addr_t(netmask, 0, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> #=
endif</span><br><span> </span><br><span> #if defined(TARGET_LINUX)</span><b=
r><span>@@ -1324,16 +1369,14 @@</span><br><span> </span><br><span>     if (=
tun_p2p)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (net_addr_ptp_v4_add(ctx, ifname, &amp;tt-&gt;local,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
         &amp;tt-&gt;remote_netmask) &lt; 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (net_addr_ptp_v4_add(ctx, ifname, &amp;=
tt-&gt;local, &amp;tt-&gt;remote) &lt; 0)</span><br><span>         {</span>=
<br><span>             msg(M_FATAL, &quot;Linux can&#39;t add IP to interfa=
ce %s&quot;, ifname);</span><br><span>         }</span><br><span>     }</sp=
an><br><span>     else</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (net_addr_v4_add(ctx, ifname, &amp;tt-&g=
t;local,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
               netmask_to_netbits2(tt-&gt;remote_netmask)) &lt; 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (net_addr_v4_add(=
ctx, ifname, &amp;tt-&gt;local, tt-&gt;netbits) &lt; 0)</span><br><span>   =
      {</span><br><span>             msg(M_FATAL, &quot;Linux can&#39;t add=
 IP to interface %s&quot;, ifname);</span><br><span>         }</span><br><s=
pan>@@ -1341,9 +1384,14 @@</span><br><span> #elif defined(TARGET_ANDROID)</=
span><br><span>     char out[64];</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    snprintf(out, sizeof(out), &quot;%s %s =
%d %s&quot;, ifconfig_local,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-             ifconfig_remote_netmask, tun_mtu, print_topology(tt-&gt=
;topology));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snp=
rintf(out, sizeof(out), &quot;%s %s %d %s&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             ifconfig_local,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+             ifconfig_remote ? ifconf=
ig_remote : ifconfig_netmask,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+             tun_mtu,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+             print_topology(tt-&gt;topology));</span><br><span>=
     management_android_control(management, &quot;IFCONFIG&quot;, out);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)ifconfig_netm=
ask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)netma=
sk;</span><br><span> </span><br><span> #elif defined(TARGET_SOLARIS)</span>=
<br><span>     /* Solaris 2.6 (and 7?) cannot set all parameters in one go.=
..</span><br><span>@@ -1354,7 +1402,7 @@</span><br><span>     if (tun_p2p)<=
/span><br><span>     {</span><br><span>         argv_printf(&amp;argv, &quo=
t;%s %s %s %s mtu %d up&quot;, IFCONFIG_PATH, ifname,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    ifconfig_local, ifconfi=
g_remote_netmask, tun_mtu);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    ifconfig_local, ifconfig_remote, tun_mtu);</spa=
n><br><span> </span><br><span>         argv_msg(M_INFO, &amp;argv);</span><=
br><span>         if (!openvpn_execve_check(&amp;argv, es, 0, &quot;Solaris=
 ifconfig phase-1 failed&quot;))</span><br><span>@@ -1369,13 +1417,13 @@</s=
pan><br><span>     {</span><br><span>         argv_printf(&amp;argv, &quot;=
%s %s %s %s netmask %s mtu %d up&quot;, IFCONFIG_PATH,</span><br><span>    =
                 ifname, ifconfig_local, ifconfig_local,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    ifconfig_remote_netm=
ask, tun_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               ifconfig_netmask, tun_mtu);</span><br><span>     }</span><br=
><span>     else /* tap */</span><br><span>     {</span><br><span>         =
argv_printf(&amp;argv, &quot;%s %s %s netmask %s up&quot;,</span><br><span>=
                     IFCONFIG_PATH, ifname, ifconfig_local,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    ifconfig_remote_n=
etmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         ifconfig_netmask);</span><br><span>     }</span><br><span> </span>=
<br><span>     argv_msg(M_INFO, &amp;argv);</span><br><span>@@ -1390,8 +143=
8,8 @@</span><br><span>         struct route_ipv4 r;</span><br><span>      =
   CLEAR(r);</span><br><span>         r.flags =3D RT_DEFINED | RT_METRIC_DE=
FINED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r.netwo=
rk =3D tt-&gt;local &amp; tt-&gt;remote_netmask;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        r.netmask =3D tt-&gt;remote_netmask;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        r.network =3D t=
t-&gt;local &amp; netmask;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        r.netbits =3D tt-&gt;netbits;</span><br><span>         r.gat=
eway =3D tt-&gt;local;</span><br><span>         r.metric =3D 0;</span><br><=
span>         add_route(&amp;r, tt, 0, NULL, es, NULL);</span><br><span>@@ =
-1413,7 +1461,7 @@</span><br><span>         argv_printf(&amp;argv,</span><b=
r><span>                     &quot;%s %s %s %s mtu %d netmask 255.255.255.2=
55 up -link0&quot;,</span><br><span>                     IFCONFIG_PATH, ifn=
ame, ifconfig_local,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   ifconfig_remote_netmask, tun_mtu);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    ifconfig_remote, tun_=
mtu);</span><br><span>     }</span><br><span>     else if (tt-&gt;type =3D=
=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>@@ -1421,13 +1469,=
13 @@</span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s mtu=
 %d netmask %s up -link0&quot;,</span><br><span>                     IFCONF=
IG_PATH, ifname, ifconfig_local,</span><br><span>                     print=
_in_addr_t(remote_end, 0, &amp;gc), tun_mtu,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    ifconfig_remote_netmask);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    ifconf=
ig_netmask);</span><br><span>     }</span><br><span>     else /* tap */</sp=
an><br><span>     {</span><br><span>         argv_printf(&amp;argv, &quot;%=
s %s %s netmask %s mtu %d link0&quot;,</span><br><span>                    =
 IFCONFIG_PATH, ifname, ifconfig_local,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    ifconfig_remote_netmask, tun_mtu);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    if=
config_netmask, tun_mtu);</span><br><span>     }</span><br><span>     argv_=
msg(M_INFO, &amp;argv);</span><br><span>     openvpn_execve_check(&amp;argv=
, es, S_FATAL, &quot;OpenBSD ifconfig failed&quot;);</span><br><span>@@ -14=
38,8 +1486,8 @@</span><br><span>         struct route_ipv4 r;</span><br><sp=
an>         CLEAR(r);</span><br><span>         r.flags =3D RT_DEFINED;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        r.network =3D tt-&=
gt;local &amp; tt-&gt;remote_netmask;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        r.netmask =3D tt-&gt;remote_netmask;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        r.network =3D tt-&gt;local=
 &amp; netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    r.netbits =3D tt-&gt;netbits;</span><br><span>         r.gateway =3D re=
mote_end;</span><br><span>         add_route(&amp;r, tt, 0, NULL, es, NULL)=
;</span><br><span>     }</span><br><span>@@ -1451,14 +1499,14 @@</span><br>=
<span>     {</span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s=
 %s mtu %d netmask 255.255.255.255 up&quot;,</span><br><span>              =
       IFCONFIG_PATH, ifname, ifconfig_local,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    ifconfig_remote_netmask, tun_mt=
u);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    ifconfig_remote, tun_mtu);</span><br><span>     }</span><br><span>     =
else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br>=
<span>         remote_end =3D create_arbitrary_remote(tt);</span><br><span>=
         argv_printf(&amp;argv, &quot;%s %s %s %s mtu %d netmask %s up&quot=
;, IFCONFIG_PATH,</span><br><span>                     ifname, ifconfig_loc=
al, print_in_addr_t(remote_end, 0, &amp;gc),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    tun_mtu, ifconfig_remote_netmask=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   tun_mtu, ifconfig_netmask);</span><br><span>     }</span><br><span>     =
else /* tap */</span><br><span>     {</span><br><span>@@ -1469,7 +1517,7 @@=
</span><br><span>          */</span><br><span>         argv_printf(&amp;arg=
v, &quot;%s %s %s netmask %s mtu %d&quot;,</span><br><span>                =
     IFCONFIG_PATH, ifname, ifconfig_local,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    ifconfig_remote_netmask, tun_mtu)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  ifconfig_netmask, tun_mtu);</span><br><span>     }</span><br><span>     a=
rgv_msg(M_INFO, &amp;argv);</span><br><span>     openvpn_execve_check(&amp;=
argv, es, S_FATAL, &quot;NetBSD ifconfig failed&quot;);</span><br><span>@@ =
-1480,8 +1528,8 @@</span><br><span>         struct route_ipv4 r;</span><br>=
<span>         CLEAR(r);</span><br><span>         r.flags =3D RT_DEFINED;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r.network =3D t=
t-&gt;local &amp; tt-&gt;remote_netmask;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        r.netmask =3D tt-&gt;remote_netmask;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        r.network =3D tt-&gt;lo=
cal &amp; netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       r.netbits =3D tt-&gt;netbits;</span><br><span>         r.gateway =3D=
 remote_end;</span><br><span>         add_route(&amp;r, tt, 0, NULL, es, NU=
LL);</span><br><span>     }</span><br><span>@@ -1503,18 +1551,18 @@</span><=
br><span>     {</span><br><span>         argv_printf(&amp;argv, &quot;%s %s=
 %s %s mtu %d netmask 255.255.255.255 up&quot;,</span><br><span>           =
          IFCONFIG_PATH, ifname, ifconfig_local,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    ifconfig_remote_netmask, tun=
_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       ifconfig_remote, tun_mtu);</span><br><span>     }</span><br><span>  =
   else if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><=
br><span>         argv_printf(&amp;argv, &quot;%s %s %s %s netmask %s mtu %=
d up&quot;,</span><br><span>                     IFCONFIG_PATH, ifname, ifc=
onfig_local, ifconfig_local,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    ifconfig_remote_netmask, tun_mtu);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    ifconfig_netm=
ask, tun_mtu);</span><br><span>     }</span><br><span>     else /* tap */</=
span><br><span>     {</span><br><span>         argv_printf(&amp;argv, &quot=
;%s %s %s netmask %s mtu %d up&quot;, IFCONFIG_PATH,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    ifname, ifconfig_local,=
 ifconfig_remote_netmask,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    ifname, ifconfig_local, ifconfig_netmask,</span><=
br><span>                     tun_mtu);</span><br><span>     }</span><br><s=
pan> </span><br><span>@@ -1527,8 +1575,8 @@</span><br><span>         struct=
 route_ipv4 r;</span><br><span>         CLEAR(r);</span><br><span>         =
r.flags =3D RT_DEFINED;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        r.network =3D tt-&gt;local &amp; tt-&gt;remote_netmask;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        r.netmask =3D tt-&gt;re=
mote_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  r.network =3D tt-&gt;local &amp; netmask;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        r.netbits =3D tt-&gt;netbits;</span><br><sp=
an>         r.gateway =3D tt-&gt;local;</span><br><span>         add_route(=
&amp;r, tt, 0, NULL, es, NULL);</span><br><span>     }</span><br><span>@@ -=
1540,13 +1588,12 @@</span><br><span>     {</span><br><span>         argv_pr=
intf(&amp;argv, &quot;%s %s %s %s mtu %d netmask 255.255.255.255 up&quot;,<=
/span><br><span>                     IFCONFIG_PATH, ifname, ifconfig_local,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    i=
fconfig_remote_netmask, tun_mtu);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    ifconfig_remote, tun_mtu);</span><br><spa=
n>     }</span><br><span>     else            /* tun with topology subnet a=
nd tap mode (always subnet) */</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        int netbits =3D netmask_to_netbits2=
(tt-&gt;remote_netmask);</span><br><span>         argv_printf(&amp;argv, &q=
uot;%s %s %s/%d mtu %d up&quot;, IFCONFIG_PATH,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    ifname, ifconfig_local, netbi=
ts, tun_mtu );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               ifname, ifconfig_local, tt-&gt;netbits, tun_mtu );</span><br=
><span>     }</span><br><span> </span><br><span>     argv_msg(M_INFO, &amp;=
argv);</span><br><span>@@ -1565,7 +1612,7 @@</span><br><span> </span><br><s=
pan>         /* example: ifconfig tap0 172.30.1.1 netmask 255.255.254.0 up =
*/</span><br><span>         argv_printf(&amp;argv, &quot;%s %s %s netmask %=
s mtu %d up&quot;, IFCONFIG_PATH,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    ifname, ifconfig_local, ifconfig_remote_net=
mask, tun_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                ifname, ifconfig_local, ifconfig_netmask, tun_mtu);</span><=
br><span> </span><br><span>         argv_msg(M_INFO, &amp;argv);</span><br>=
<span>         openvpn_execve_check(&amp;argv, aix_es, S_FATAL, &quot;AIX i=
fconfig failed&quot;);</span><br><span>@@ -1578,7 +1625,7 @@</span><br><spa=
n>         msg(M_INFO,</span><br><span>             &quot;******** NOTE:  P=
lease manually set the IP/netmask of &#39;%s&#39; to %s/%s (if it is not al=
ready set)&quot;,</span><br><span>             ifname, ifconfig_local,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            ifconfig_remot=
e_netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    ifconfig_netmask);</span><br><span>     }</span><br><span>     else if =
(tt-&gt;options.ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ || tt-&gt;options.=
ip_win32_type =3D=3D IPW32_SET_ADAPTIVE)</span><br><span>     {</span><br><=
span>@@ -1660,12 +1707,10 @@</span><br><span> undo_ifconfig_ipv4(struct tun=
tap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span> #if de=
fined(TARGET_LINUX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int netbits =3D netmask_to_netbits2(tt-&gt;remote_netmask);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (is_tun_p2=
p(tt))</span><br><span>     {</span><br><span>         if (net_addr_ptp_v4_=
del(ctx, tt-&gt;actual_name, &amp;tt-&gt;local,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                &amp;tt-&gt;remot=
e_netmask) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                               &amp;tt-&gt;remote) &lt; 0)</span><br><span>=
         {</span><br><span>             msg(M_WARN, &quot;Linux can&#39;t d=
el IP from iface %s&quot;,</span><br><span>                 tt-&gt;actual_n=
ame);</span><br><span>@@ -1673,7 +1718,7 @@</span><br><span>     }</span><b=
r><span>     else</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (net_addr_v4_del(ctx, tt-&gt;actual_name, &am=
p;tt-&gt;local, netbits) &lt; 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (net_addr_v4_del(ctx, tt-&gt;actual_name, &amp;tt-&=
gt;local, tt-&gt;netbits) &lt; 0)</span><br><span>         {</span><br><spa=
n>             msg(M_WARN, &quot;Linux can&#39;t del IP from iface %s&quot;=
,</span><br><span>                 tt-&gt;actual_name);</span><br><span>@@ =
-4683,8 +4728,8 @@</span><br><span> </span><br><span>             if (ip_st=
r &amp;&amp; netmask_str &amp;&amp; strlen(ip_str) &amp;&amp; strlen(netmas=
k_str))</span><br><span>             {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                *ip =3D getaddr(getaddr_flags, ip_str, 0, =
&amp;succeed1, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                *netmask =3D getaddr(getaddr_flags, netmask_str, 0, &amp;su=
cceed2, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           *ip =3D getaddr(getaddr_flags, ip_str, NULL, 0, &amp;succeed1, N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  *netmask =3D getaddr(getaddr_flags, netmask_str, NULL, 0, &amp;succeed2, =
NULL);</span><br><span>                 ret =3D (succeed1 =3D=3D true &amp;=
&amp; succeed2 =3D=3D true);</span><br><span>             }</span><br><span=
>         }</span><br><span>@@ -5370,7 +5415,7 @@</span><br><span>         =
    break;</span><br><span>         }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        ip =3D getaddr(getaddr_flags, ip_=
str, 0, &amp;succeed, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        ip =3D getaddr(getaddr_flags, ip_str, NULL, 0, &amp;succee=
d, NULL);</span><br><span>         if (!succeed)</span><br><span>         {=
</span><br><span>             break;</span><br><span>@@ -6428,11 +6473,12 @=
@</span><br><span>     if (!tt-&gt;did_ifconfig_setup || tt-&gt;topology =
=3D=3D TOP_SUBNET)</span><br><span>     {</span><br><span>         in_addr_=
t ep[3];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st in_addr_t netmask =3D netbits_to_netmask(tt-&gt;netbits);</span><br><spa=
n>         BOOL status;</span><br><span> </span><br><span>         ep[0] =
=3D htonl(tt-&gt;local);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        ep[1] =3D htonl(tt-&gt;local &amp; tt-&gt;remote_netmask);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        ep[2] =3D htonl(tt-=
&gt;remote_netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ep[1] =3D htonl(tt-&gt;local &amp; netmask);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ep[2] =3D htonl(netmask);</span><=
br><span> </span><br><span>         status =3D DeviceIoControl(tt-&gt;hand,=
 TAP_WIN_IOCTL_CONFIG_TUN,</span><br><span>                                =
  ep, sizeof(ep),</span><br><span>@@ -6456,7 +6502,7 @@</span><br><span>   =
  {</span><br><span>         in_addr_t ep[2];</span><br><span>         ep[0=
] =3D htonl(tt-&gt;local);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        ep[1] =3D htonl(tt-&gt;remote_netmask);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ep[1] =3D htonl(tt-&gt;remote);</=
span><br><span> </span><br><span>         if (!DeviceIoControl(tt-&gt;hand,=
 TAP_WIN_IOCTL_CONFIG_POINT_TO_POINT,</span><br><span>                     =
         ep, sizeof(ep),</span><br><span>@@ -6485,11 +6531,11 @@</span><br>=
<span>     {</span><br><span>         if (tt-&gt;topology =3D=3D TOP_SUBNET=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            ep[2] =3D dhcp_masq_addr(tt-&gt;local, tt-&gt;remote_net=
mask, tt-&gt;options.dhcp_masq_custom_offset ? tt-&gt;options.dhcp_masq_off=
set : 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  ep[2] =3D dhcp_masq_addr(tt-&gt;local, netbits_to_netmask(tt-&gt;netbits)=
, tt-&gt;options.dhcp_masq_custom_offset ? tt-&gt;options.dhcp_masq_offset =
: 0);</span><br><span>         }</span><br><span>         else</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     ep[2] =3D htonl(tt-&gt;remote_netmask);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            ep[2] =3D htonl(tt-&gt;remote);</span>=
<br><span>         }</span><br><span>     }</span><br><span>     else</span=
><br><span>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><sp=
an>index 33b9552..68aa3b8 100644</span><br><span>--- a/src/openvpn/tun.h</s=
pan><br><span>+++ b/src/openvpn/tun.h</span><br><span>@@ -188,7 +188,8 @@</=
span><br><span> </span><br><span>     /* ifconfig parameters */</span><br><=
span>     in_addr_t local;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    in_addr_t remote_netmask;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    in_addr_t remote;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int netbits;</span><br><span> </span><br><span>     st=
ruct in6_addr local_ipv6;</span><br><span>     struct in6_addr remote_ipv6;=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/739?usp=3Demail">change 739</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/739?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9=
a766c9604efc9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 739 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ezz0ITQCaPo=--

