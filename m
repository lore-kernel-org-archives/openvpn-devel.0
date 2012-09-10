From: Andrea Bonomi <a.bonomi@...1028...>
Date: Mon, 10 Sep 2012 15:38:52 +0200
Message-Id: <29D21832-CC91-4783-A015-D8AE7C7D0E9D@...1028...>
Mime-Version: 1.0 (Apple Message framework v1278)
Subject: [Openvpn-devel] [PATCH] Add 1:1 network mapping option (--netmap)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Dear Developers,
I developed a patch for implementing 1:1 NAT (something similar to the ipta=
bles NETMAP target).
This is useful in situations when you have the same (private) network addre=
ss behind clients.
For example, consider the following scenario:

 -lan1--192.168.0.0/24--      -lan2--192.168.0.0/24--
          |                             |
    gw1 192.168.0.1              gw2 192.168.0.1
          |                             |=20
       [tunnel]-----OpenVPN server---[tunnel]
                        |
                     [tunnel]
                        |
                    clients=85

The clients have to access to both the machines in lan1 and lan2,
This patch allow to map all the address of a network, e.g.
[to g1] push "netmap 172.16.1.0/24 192.168.0.0/24"
[to g2] push "netmap 172.16.2.0/24 192.168.0.0/24"
The clients can access to, e.g. 192.168.0.79 on lan1 using the IP 172.16.1.=
79.

Regards,
Andrea

:: e n d i a n
:: security with passion

:: andrea bonomi
:: http://www.endian.com  :: a.bonomi@...1028...


Signed-off-by: Andrea Bonomi <a.bonomi@...1028...>
---
 src/openvpn/Makefile.am             |    1 +
 src/openvpn/forward.c               |   10 +-
 src/openvpn/netmap.c                |  238 +++++++++++++++++++++++++++++++=
++++
 src/openvpn/netmap.h                |   53 ++++++++
 src/openvpn/openvpn.vcxproj         |    1 +
 src/openvpn/openvpn.vcxproj.filters |    3 +
 src/openvpn/options.c               |   19 +++
 src/openvpn/options.h               |   10 ++
 8 files changed, 333 insertions(+), 2 deletions(-)
 create mode 100644 src/openvpn/netmap.c
 create mode 100644 src/openvpn/netmap.h

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 5d38628..eee5117 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -73,6 +73,7 @@ openvpn_SOURCES =3D \
 	mtu.c mtu.h \
 	mudp.c mudp.h \
 	multi.c multi.h \
+	netmap.c netmap.h \
 	ntlm.c ntlm.h \
 	occ.c occ.h occ-inline.h \
 	pkcs11.c pkcs11.h pkcs11_backend.h \
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 57c7846..fc52cae 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1026,15 +1026,21 @@ process_ipv4_header (struct context *c, unsigned in=
t flags, struct buffer *buf)
        * The --passtos and --mssfix options require
        * us to examine the IPv4 header.
        */
+
 #if PASSTOS_CAPABILITY
-      if (flags & (PIPV4_PASSTOS|PIPV4_MSSFIX))
+      if (flags & (PIPV4_PASSTOS|PIPV4_MSSFIX) || c->options.netmap_enable=
d)
 #else
-      if (flags & PIPV4_MSSFIX)
+      if (flags & PIPV4_MSSFIX || c->options.netmap_enabled)
 #endif
 	{
 	  struct buffer ipbuf =3D *buf;
 	  if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
 	    {
+              if (c->options.netmap_enabled)
+                {
+	          do_netmap(&c->options.netmaps, flags, &ipbuf);
+	        }
+
 #if PASSTOS_CAPABILITY
 	      /* extract TOS from IP header */
 	      if (flags & PIPV4_PASSTOS)
diff --git a/src/openvpn/netmap.c b/src/openvpn/netmap.c
new file mode 100644
index 0000000..52fe25b
--- /dev/null
+++ b/src/openvpn/netmap.c
@@ -0,0 +1,238 @@
+/*
+ *  Copyright (c) 2012 Endian
+ *      Endian GmbH/Srl
+ *      Bergweg 41 Via Monte
+ *      39057 Eppan/Appiano
+ *      ITALIEN/ITALIA
+ *      info@...1028...
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  Author: Andrea Bonomi <a.bonomi@...1028...>=20
+ */
+
+#include "syshead.h"
+#include "common.h"
+#include "error.h"
+#include "netmap.h"
+#include "socket.h"
+#include "proto.h"
+#include "forward.h"
+
+
+/**
+ * Parse a network address in CIDR notation or an IP address
+ */
+static bool
+parse_cidr (const char *cidr, int *addr, int *mask, bool *has_mask)
+{
+  unsigned int a, b, c, d, netmask, l;
+  *addr =3D 0;
+  *mask =3D 0;
+  *has_mask =3D false;
+  l =3D sscanf (cidr, "%u.%u.%u.%u/%u", &a, &b, &c, &d, &netmask);
+  if (l =3D=3D 4 || l =3D=3D 5) {
+    if (l =3D=3D 4) {
+      netmask =3D 0;
+    }
+    if (a < 256 && b < 256 && c < 256 && d < 256 && netmask <=3D 32) {
+      uint32_t uaddr =3D a<<24 | b<<16 | c<<8 | d;
+      if (l =3D=3D 4) { /* the netmask was not specified */
+        *addr =3D htonl (uaddr);
+      } else {
+        *mask =3D htonl((0xffffffff >> (32 - netmask )) << (32 - netmask));
+        *addr =3D htonl (uaddr) & *mask;
+        *has_mask =3D true;
+      }
+      return true;=20
+    }
+  }
+  return false;
+}
+
+/*=20
+ * Calculate the IP checksum and update the IP header
+ */
+
+static void
+update_ip_checksum(struct openvpn_iphdr *iph) {
+  const char *t =3D (const char *)iph;
+  const char *end =3D t + OPENVPN_IPH_GET_LEN (iph->version_len) - 1;
+  uint32_t sum =3D 0;
+  iph->check =3D 0;
+=20=20=20=20=20=20
+  while (t < end) {
+    sum +=3D (((char)*t << 8) & 0xff00);
+    t++;
+    sum +=3D (char)*t & 0xff;
+    t++;
+    if (sum > 0xffff)
+      sum =3D (sum & 0xffff) + (sum >> 16);
+  }
+
+  iph->check =3D htons((uint16_t) ~sum);
+}
+
+/*=20
+ * Check if the source/destination address have to be remapped.
+ * If the package direction is outgoing change the source address,
+ * otherwise change the destination address.
+ */
+
+void
+do_netmap (struct netmap_option_list *netmaps, unsigned int flags, struct =
buffer *ipbuf) {
+  struct openvpn_iphdr *iph =3D (struct openvpn_iphdr *) BPTR (ipbuf);
+  struct netmap_option *n;
+  bool package_updated =3D false;
+  int i;
+
+#ifdef NETMAP_DEBUG
+  struct in_addr s;
+  struct in_addr d;
+  s.s_addr =3D iph->saddr;
+  d.s_addr =3D iph->daddr;
+  msg (M_INFO, "outgoing: %c", flags & PIPV4_OUTGOING ? 'y' : 'n');
+  msg (M_INFO, "source: %s 0x%08x", inet_ntoa(s), iph->saddr);
+  msg (M_INFO, "destination: %s 0x%08x", inet_ntoa(d), iph->daddr);
+  msg (M_INFO, "netmaps size: %d", netmaps ? netmaps->size : -1);
+#endif
+
+  if (!netmaps) {
+    return;
+  }
+=20=20=20=20
+  if (flags & PIPV4_OUTGOING) { /* outgoing (received package) */
+    for (i =3D 0, n =3D netmaps->netmaps; i < netmaps->size; i++, n++) {
+
+#ifdef NETMAP_DEBUG
+      msg (M_INFO, "netmap %d#: destination: 0x%08x source: 0x%08x netmap:=
 0x%08x", i, n->destination, n->source, n->netmap_mask);
+#endif
+
+      if (n->destination =3D=3D (iph->saddr & n->netmap_mask)) {
+        iph->saddr =3D n->source | (iph->saddr & ~n->netmap_mask);
+        package_updated =3D true;
+#ifdef NETMAP_DEBUG
+        s.s_addr =3D iph->saddr;
+        msg (M_INFO, "netmap %d#: source changed to: %s 0x%08x", i, inet_n=
toa(s), iph->saddr);
+#endif
+      }
+=20=20=20=20=20=20
+      if (n->destination =3D=3D (iph->daddr & n->netmap_mask)) {
+        iph->daddr =3D n->source | (iph->daddr & ~n->netmap_mask);
+        package_updated =3D true;
+#ifdef NETMAP_DEBUG
+        d.s_addr =3D iph->daddr;
+        msg (M_INFO, "netmap %d#: destination changed to: %s 0x%08x", i, i=
net_ntoa(d), iph->daddr);
+#endif
+      }
+
+    }=20
+  } else { /* incoming (package to be sent) */
+
+    for (i =3D 0, n =3D netmaps->netmaps; i < netmaps->size; i++, n++) {
+
+#ifdef NETMAP_DEBUG
+      msg (M_INFO, "netmap %d#: destination: 0x%08x source: 0x%08x netmap:=
 0x%08x", i, n->destination, n->source, n->netmap_mask);
+#endif
+
+      if (n->source =3D=3D (iph->saddr & n->netmap_mask)) {
+        iph->saddr =3D n->destination | (iph->saddr & ~n->netmap_mask);
+        package_updated =3D true;
+#ifdef NETMAP_DEBUG
+        s.s_addr =3D iph->saddr;
+        msg (M_INFO, "netmap %d#: source changed to: %s 0x%08x", i, inet_n=
toa(s), iph->saddr);
+#endif
+      }
+
+      if (n->source =3D=3D (iph->daddr & n->netmap_mask)) {
+        iph->daddr =3D n->destination | (iph->daddr & ~n->netmap_mask);=20
+        package_updated =3D true;
+#ifdef NETMAP_DEBUG
+        d.s_addr =3D iph->daddr;
+        msg (M_INFO, "netmap %d#: destination changed to: %s 0x%08x", i, i=
net_ntoa(d), iph->daddr);
+#endif
+      }
+
+    }
+
+  }
+=20=20
+  if (package_updated) {
+    update_ip_checksum(iph);
+  }
+=20=20
+}
+
+/*
+ * Add a new netmap option
+ */
+bool
+add_netmap_to_option_list (struct netmap_option_list *netmaps, const char =
*source,
+			  const char *destination, const char *netmask, int msglevel)
+{
+  struct netmap_option *no;
+  int netmask1;
+  bool has_netmask1;
+  int netmask2;
+  bool has_netmask2;
+  if (netmaps->size >=3D MAX_NETMAPS_DEFAULT) {
+    msg (M_FATAL, PACKAGE_NAME " NETMAP: cannot add more than %d netmaps",=
 MAX_NETMAPS_DEFAULT);
+  }
+  no =3D &netmaps->netmaps[netmaps->size];
+
+  if (!source || !parse_cidr(source, &no->source, &netmask1, &has_netmask1=
)) {
+    msg (msglevel, " NETMAP: Cannot parse source IP: %s", source);
+    return false;
+  }
+
+  if (!destination || !parse_cidr(destination, &no->destination, &netmask2=
, &has_netmask2)) {
+    msg (msglevel, " NETMAP: Cannot parse destination IP: %s", destination=
);
+    return false;
+  }
+=20=20
+  if (netmask1 !=3D netmask2) {
+    msg (msglevel, " NETMAP: Source and destination netmasks must be the s=
ame");
+    return false;
+  }
+
+  if (!netmask) {
+    /* netmap not specified, use the netmask from the cidr or the default =
netmask */
+    if (has_netmask1) {
+      no->netmap_mask =3D netmask1;
+    } else {
+      /* default netmask 255.255.255.255 */
+      no->netmap_mask =3D 0xffffffff;
+    }
+=20=20=20=20
+  } else {
+    struct in_addr addr;
+    if (openvpn_inet_aton(netmask, &addr) !=3D OIA_IP) {
+      msg (msglevel, " NETMAP: Cannot parse netmask: %s", netmask);
+      return false;
+    }
+=20=20=20=20
+    if (netmask1 !=3D -1 && htonl((0xffffffff >> (32 - netmask1 )) << (32 =
- netmask1) !=3D addr.s_addr)) {
+      msg (msglevel, " NETMAP: You canot use both CIDR and dot-decimal net=
masks");
+      return false;
+    }
+=20=20=20=20
+    no->netmap_mask =3D addr.s_addr;
+    no->source =3D no->source & no->netmap_mask;
+    no->destination =3D no->destination & no->netmap_mask;
+  }
+
+  netmaps->size++;
+  return true;
+}
diff --git a/src/openvpn/netmap.h b/src/openvpn/netmap.h
new file mode 100644
index 0000000..24f9a2b
--- /dev/null
+++ b/src/openvpn/netmap.h
@@ -0,0 +1,53 @@
+/*
+ *  Copyright (c) 2012 Endian
+ *      Endian GmbH/Srl
+ *      Bergweg 41 Via Monte
+ *      39057 Eppan/Appiano
+ *      ITALIEN/ITALIA
+ *      info@...1028...
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  Author: Andrea Bonomi <a.bonomi@...1028...>=20
+ */
+
+/*
+ * Support routines for adding/deleting network maps.
+ */
+
+#ifndef NETMAP_H
+#define NETMAP_H
+
+#include "buffer.h"
+
+/* #define NETMAP_DEBUG */
+
+#define MAX_NETMAPS_DEFAULT 32
+
+struct netmap_option {
+  uint32_t source;
+  uint32_t destination;
+  uint32_t netmap_mask;
+};
+
+struct netmap_option_list {
+  int size;
+  struct netmap_option netmaps[MAX_NETMAPS_DEFAULT];
+};
+
+void do_netmap (struct netmap_option_list *netmaps, unsigned int flags, st=
ruct buffer *ipbuf);
+bool add_netmap_to_option_list (struct netmap_option_list *netmaps, const =
char *source, const char *destination, const char *netmask, int msglevel);
+
+#endif
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 3b2340e..633b881 100755
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -128,6 +128,7 @@
     <ClCompile Include=3D"mtu.c" />
     <ClCompile Include=3D"mudp.c" />
     <ClCompile Include=3D"multi.c" />
+    <ClCompile Include=3D"netmap.c" />
     <ClCompile Include=3D"ntlm.c" />
     <ClCompile Include=3D"occ.c" />
     <ClCompile Include=3D"openvpn.c" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxp=
roj.filters
index 40336ba..4b26efb 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -108,6 +108,9 @@
     <ClCompile Include=3D"multi.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include=3D"netmap.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
     <ClCompile Include=3D"ntlm.c">
       <Filter>Source Files</Filter>
     </ClCompile>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d25bbea..7e5684e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -239,6 +239,9 @@ static const char usage_message[] =3D
   "                  Add 'bypass-dns' flag to similarly bypass tunnel for =
DNS.\n"
   "--redirect-private [flags]: Like --redirect-gateway, but omit actually =
changing\n"
   "                  the default gateway.  Useful when pushing private sub=
nets.\n"
+  "--netmap source dest [netmask]: Add a 1:1 mapping of network address\n"
+  "                  'source' is the local network to be remapped into 'de=
st'\n"
+  "                  on the other side of the tunnel\n"
 #ifdef ENABLE_CLIENT_NAT
   "--client-nat snat|dnat network netmask alias : on client add 1-to-1 NAT=
 rule.\n"
 #endif
@@ -870,6 +873,7 @@ init_options (struct options *o, const bool init_gc)
   }
 #endif /* WIN32 */
 #endif /* P2MP_SERVER */
+  o->netmaps.size =3D 0;
 }
=20
 void
@@ -2759,6 +2763,9 @@ pre_pull_save (struct options *o)
       o->pre_pull->tuntap_options =3D o->tuntap_options;
       o->pre_pull->tuntap_options_defined =3D true;
       o->pre_pull->foreign_option_index =3D o->foreign_option_index;
+      o->pre_pull->netmaps =3D o->netmaps;
+      o->pre_pull->netmaps_defined =3D true;
+
       if (o->routes)
 	{
 	  o->pre_pull->routes =3D clone_route_option_list(o->routes, &o->gc);
@@ -2789,6 +2796,10 @@ pre_pull_restore (struct options *o)
       if (pp->tuntap_options_defined)
 	  o->tuntap_options =3D pp->tuntap_options;
=20
+      CLEAR (o->netmaps);
+      if (pp->netmaps_defined)
+	  o->netmaps =3D pp->netmaps;
+
       if (pp->routes_defined)
 	{
 	  rol_check_alloc (o);
@@ -5115,6 +5126,14 @@ add_option (struct options *options,
 	}
       options->max_routes =3D max_routes;
     }
+  else if (streq (p[0], "netmap") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_ROUTE);
+      if (!add_netmap_to_option_list(&options->netmaps, p[1], p[2], p[3], =
msglevel)) {
+	  goto err;
+      }
+      options->netmap_enabled =3D true;
+    }
   else if (streq (p[0], "route-gateway") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 306520b..7b697d5 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -34,6 +34,7 @@
 #include "common.h"
 #include "mtu.h"
 #include "route.h"
+#include "netmap.h"
 #include "tun.h"
 #include "socket.h"
 #include "plugin.h"
@@ -76,6 +77,9 @@ struct options_pre_pull
   struct client_nat_option_list *client_nat;
 #endif
=20
+  bool netmaps_defined;
+  struct netmap_option_list netmaps;
+
   int foreign_option_index;
 };
=20
@@ -347,6 +351,11 @@ struct options
   struct client_nat_option_list *client_nat;
 #endif
=20
+  /** Network map */
+  int max_netmaps;
+  struct netmap_option_list netmaps;
+  bool netmap_enabled;
+
 #ifdef ENABLE_OCC
   /* Enable options consistency check between peers */
   bool occ;
@@ -624,6 +633,7 @@ struct options
 #define OPT_P_SOCKBUF         (1<<25)
 #define OPT_P_SOCKFLAGS       (1<<26)
 #define OPT_P_CONNECTION      (1<<27)
+#define OPT_P_NETMAP          (1<<28)
=20
 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))
=20
--=20
1.7.9.5



