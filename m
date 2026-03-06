From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 6 Mar 2026 18:08:25 +0000
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b7691003191cecf79e0bf8eb87200140b4d6275c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4OlDDePVew4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: add IPv4
 CIDR parsing for relevant directives
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

--4OlDDePVew4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail

to look at the new patch set (#8).


Change subject: options: add IPv4 CIDR parsing for relevant directives
......................................................................

options: add IPv4 CIDR parsing for relevant directives

Add support for CIDR notation on all suitable options (client-nat,
ifconfig, ifconfig-push, ifconfig-push-constraint, iroute, route,
server, server-bridge). This change provides a more consistent approach
for users already familiar with CIDR notation and simplifies network
configuration in scenarios where IP ranges are more naturally expressed
in CIDR form. It also allows for more compact OpenVPN configurations.

Static --push "..." payloads remain opaque by design (current policy),
so CIDR normalization is not applied to those strings.

Due to current PUSH_UPDATE plumbing, option payloads are only
parsed/validated when processed in update_option (after transmission),
so this change normalizes CIDR there but does not introduce pre-send
payload rewriting/validation as that would require a rework of the
PUSH_UPDATE architecture. This also means compatibility is not
guaranteed for PUSH_UPDATE-capable peers that do not parse CIDR: the
sender can accept a CIDR-formatted PUSH_UPDATE as valid after sending
it, while a PUSH_UPDATE-capable peer that does not parse CIDR may reject
it; this can leave sender and receiver with diverging effective state.

Internal behavior remains netmask-based, and existing netmask
environment variables are unchanged.

Tests for CIDR parsing and option normalization are added in
test_options_parse.c covering all affected options.

Change-Id: Iae04ad8715e40dfc76475c2c5b9a766c9604efc9
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M doc/man-sections/client-options.rst
M doc/man-sections/server-options.rst
M doc/man-sections/vpn-network-options.rst
M src/openvpn/options.c
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M tests/unit_tests/openvpn/test_options_parse.c
7 files changed, 486 insertions(+), 77 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/739/8

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index 85d25e5..c47e90e 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -132,21 +132,23 @@
   ifconfig settings pushed to the client would create an IP numbering
   conflict.

-  Valid syntax:
+  Valid syntaxes:
   ::

       client-nat snat|dnat network netmask alias
+      client-nat snat|dnat network/bits alias

   Examples:
   ::

       client-nat snat 192.168.0.0 255.255.0.0 10.64.0.0
-      client-nat dnat 10.64.0.0 255.255.0.0 192.168.0.0
+      client-nat dnat 10.64.0.0/16 192.168.0.0

-  ``network`` and ``netmask`` (for example :code:`192.168.0.0
-  255.255.0.0`) define the local view of a resource from the client
-  perspective, while ``alias`` (for example :code:`10.64.0.0`) defines the
-  remote view from the server perspective using the same netmask.
+  ``network netmask`` (for example :code:`192.168.0.0 255.255.0.0`) or
+  ``network/bits`` (for example :code:`192.168.0.0/16`) defines the local
+  view of a resource from the client perspective, while ``alias`` (for
+  example :code:`10.64.0.0`) defines the remote view from the server
+  perspective using the same netmask/bits.

   Use :code:`snat` (source NAT) for resources owned by the client and
   :code:`dnat` (destination NAT) for remote resources.
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 03ce651..68a712d 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -286,23 +286,27 @@
   Push virtual IP endpoints for client tunnel, overriding the
   ``--ifconfig-pool`` dynamic allocation.

-  Valid syntax:
+  Valid syntaxes:
   ::

-     ifconfig-push local remote-netmask [alias]
+     ifconfig-push local remote [alias]
+     ifconfig-push local netmask [alias]
+     ifconfig-push local/bits [alias]

-  The parameters ``local`` and ``remote-netmask`` are set according to the
-  ``--ifconfig`` directive which you want to execute on the client machine
-  to configure the remote end of the tunnel. Note that the parameters
-  ``local`` and ``remote-netmask`` are from the perspective of the client,
-  not the server. They may be DNS names rather than IP addresses, in which
-  case they will be resolved on the server at the time of client
-  connection.
+  The parameters ``local remote`` or ``local netmask`` are set according to
+  the ``--ifconfig`` directive which you want to execute on the client
+  machine to configure the remote end of the tunnel. As a compact form,
+  ``local/bits`` can be used, in which case the netmask is derived from
+  ``bits``. Note that the parameters ``local`` and ``remote`` are from the
+  perspective of the client, not the server. They may be DNS names rather
+  than IP addresses, in which case they will be resolved on the server at
+  the time of client connection.

   The optional ``alias`` parameter may be used in cases where NAT causes
   the client view of its local endpoint to differ from the server view. In
-  this case ``local/remote-netmask`` will refer to the server view while
-  ``alias/remote-netmask`` will refer to the client view.
+  this case ``local/netmask`` (or ``local/bits``) will refer to the server
+  view while ``alias/netmask`` (or ``alias/bits``) will refer to the client
+  view.

   This option must be associated with a specific client instance, which
   means that it must be specified either in a client instance config file
@@ -328,6 +332,15 @@
   by ``--ifconfig``, OpenVPN will install a /32 host route for the ``local=
``
   IP address.

+--ifconfig-push-constraint args
+  Restrict static IPv4 addresses from ``--ifconfig-push`` to a specific su=
bnet.
+
+  Valid syntaxes:
+  ::
+
+     ifconfig-push-constraint network netmask
+     ifconfig-push-constraint network/bits
+
 --ifconfig-ipv6-push args
   for ``--client-config-dir`` per-client static IPv6 interface
   configuration, see ``--client-config-dir`` and ``--ifconfig-push`` for
@@ -367,13 +380,15 @@
       applies only to IPv6.

 --iroute args
-  Generate an internal route to a specific client. The ``netmask``
-  parameter, if omitted, defaults to :code:`255.255.255.255`.
+  Generate an internal route to a specific client. If both ``netmask`` and
+  ``bits`` are omitted, the default netmask is :code:`255.255.255.255`
+  (equivalent to :code:`/32` in CIDR notation).

-  Valid syntax:
+  Valid syntaxes:
   ::

      iroute network [netmask]
+     iroute network[/bits]

   This directive can be used to route a fixed subnet from the server to a
   particular client, regardless of where the client is connecting from.
@@ -555,10 +570,11 @@
   optional :code:`nopool` flag is given, no dynamic IP address pool will
   prepared for VPN clients.

-  Valid syntax:
+  Valid syntaxes:
   ::

       server network netmask [nopool]
+      server network/bits [nopool]

   For example, ``--server 10.8.0.0 255.255.255.0`` expands as follows:
   ::
@@ -597,6 +613,7 @@
   ::

       server-bridge gateway netmask pool-start-IP pool-end-IP
+      server-bridge gateway/bits pool-start-IP pool-end-IP
       server-bridge [nogw]

   If ``--server-bridge`` is used without any parameters, it will enable a
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 33ebedb..27a61ed 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -223,19 +223,28 @@
         Android 10 or later.

 --ifconfig args
+  Valid syntaxes:
+  ::
+
+     ifconfig local remote
+     ifconfig local netmask
+     ifconfig local/bits
+
   Set TUN/TAP adapter parameters. It requires the *IP address* of the local
   VPN endpoint. For TUN devices in point-to-point mode, the next argument
   must be the VPN IP address of the remote VPN endpoint. For TAP devices,
   or TUN devices used with ``--topology subnet``, the second argument
   is the subnet mask of the virtual network segment which is being created
-  or connected to.
+  or connected to. In this netmask case, ``local/bits`` may be used as a
+  compact form.

   For TUN devices, which facilitate virtual point-to-point IP connections
   (when used in ``--topology net30`` or ``p2p`` mode), the proper usage of
   ``--ifconfig`` is to use two private IP addresses which are not a member
-  of any existing subnet which is in use. The IP addresses may be
+  of any existing subnet which is in use. In this mode, use the explicit
+  ``local remote`` form (CIDR form is not applicable). The IP addresses ma=
y be
   consecutive and should have their order reversed on the remote peer.
-  After the VPN is established, by pinging ``rn``, you will be pinging
+  After the VPN is established, by pinging ``remote``, you will be pinging
   across the VPN.

   For TAP devices, which provide the ability to create virtual ethernet
@@ -267,6 +276,9 @@
      # tun/tap device in subnet mode
      ifconfig 10.8.0.2 255.255.255.0

+     # equivalent subnet-mode shorthand
+     ifconfig 10.8.0.2/24
+
 --ifconfig-ipv6 args
   Configure an IPv6 address on the *tun* device.

@@ -405,17 +417,16 @@
   Valid syntaxes:
   ::

-      route network/IP
-      route network/IP netmask
-      route network/IP netmask gateway
-      route network/IP netmask gateway metric
+      route network [netmask] [gateway] [metric]
+      route ipv4addr [netmask] [gateway] [metric]
+      route ipv4addr[/bits] [gateway] [metric]

   This option is intended as a convenience proxy for the ``route``\(8)
   shell command, while at the same time providing portable semantics
   across OpenVPN's platform space.

-  ``netmask``
-        defaults to :code:`255.255.255.255` when not given
+  ``netmask`` (or ``bits``)
+        defaults to :code:`255.255.255.255` (or :code:`/32`) when not given

   ``gateway``
         default taken from ``--route-gateway`` or the second
@@ -431,6 +442,9 @@
   DNS or :code:`/etc/hosts` file resolvable name, or as one of three speci=
al
   keywords:

+  The ``ipv4addr`` parameter may be specified using CIDR notation, thus
+  omitting the ``netmask`` parameter.
+
   :code:`vpn_gateway`
       The remote VPN endpoint address (derived either from
       ``--route-gateway`` or the second parameter to ``--ifconfig``
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fdbc678..042453a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -208,6 +208,8 @@
     "                  addresses outside of the subnets used by either pee=
r.\n"
     "                  TAP: configure device to use IP address l as a loca=
l\n"
     "                  endpoint and rn as a subnet mask.\n"
+    "                  In netmask mode (TAP, or TUN with --topology subnet=
),\n"
+    "                  l may be specified as l/bits.\n"
     "--ifconfig-ipv6 l r : configure device to use IPv6 address l as local=
\n"
     "                      endpoint (as a /64) and r as remote endpoint\n"
     "--ifconfig-noexec : Don't actually execute ifconfig/netsh command, in=
stead\n"
@@ -221,6 +223,7 @@
     "--route network [netmask] [gateway] [metric] :\n"
     "                  Add route to routing table after connection\n"
     "                  is established.  Multiple routes can be specified.\=
n"
+    "                  network [netmask] can also be specified as network/=
bits.\n"
     "                  netmask default: 255.255.255.255\n"
     "                  gateway default: taken from --route-gateway or --if=
config\n"
     "                  Specify default by leaving blank or setting to \"de=
fault\".\n"
@@ -259,6 +262,7 @@
     "                   (Server) Instead of forwarding IPv6 packets send\n"
     "                   ICMPv6 host unreachable packets to the client.\n"
     "--client-nat snat|dnat network netmask alias : on client add 1-to-1 N=
AT rule.\n"
+    "                  network netmask can also be specified as network/bi=
ts.\n"
     "--push-peer-info : (client only) push client info to server.\n"
     "--setenv name value : Set a custom environmental variable to pass to =
script.\n"
     "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to =
allow\n"
@@ -425,10 +429,12 @@
     "--vlan-pvid v   : Sets the Port VLAN Identifier. Defaults to 1.\n"
     "\n"
     "Multi-Client Server options (when --mode server is used):\n"
-    "--server network netmask : Helper option to easily configure server m=
ode.\n"
+    "--server network netmask [nopool] : Helper option to easily configure=
 server mode.\n"
+    "                  network netmask can also be specified as network/bi=
ts.\n"
     "--server-ipv6 network/bits : Configure IPv6 server mode.\n"
     "--server-bridge [IP netmask pool-start-IP pool-end-IP] : Helper optio=
n to\n"
     "                    easily configure ethernet bridging server mode.\n"
+    "                    IP netmask can also be specified as IP/bits.\n"
     "--push \"option\" : Push a config file option back to the peer for re=
mote\n"
     "                  execution.  Peer must specify --pull in its config =
file.\n"
     "--push-reset    : Don't inherit global push list for specific\n"
@@ -442,13 +448,15 @@
     "                  If seconds=3D0, file will be treated as read-only.\=
n"
     "--ifconfig-ipv6-pool base-IP/bits : set aside an IPv6 network block\n"
     "                  to be dynamically allocated to connecting clients.\=
n"
-    "--ifconfig-push local remote-netmask : Push an ifconfig option to rem=
ote,\n"
+    "--ifconfig-push local remote-netmask [alias] : Push an ifconfig optio=
n to remote,\n"
     "                  overrides --ifconfig-pool dynamic allocation.\n"
+    "                  local can also be specified as local/bits.\n"
     "                  Only valid in a client-specific config file.\n"
     "--ifconfig-ipv6-push local/bits remote : Push an ifconfig-ipv6 option=
 to\n"
     "                  remote, overrides --ifconfig-ipv6-pool allocation.\=
n"
     "                  Only valid in a client-specific config file.\n"
     "--iroute network [netmask] : Route subnet to client.\n"
+    "                  network [netmask] can also be specified as network/=
bits.\n"
     "--iroute-ipv6 network/bits : Route IPv6 subnet to client.\n"
     "                  Sets up internal routes only.\n"
     "                  Only valid in a client-specific config file.\n"
@@ -5356,6 +5364,28 @@
     return true;
 }

+static bool
+ipv4_cidr_parms_checked(char *p[], int network_idx, int max_idx, char *nor=
malized[],
+                        const char *cidr_label, const msglvl_t msglevel, s=
truct gc_arena *gc)
+{
+    const int res =3D convert_ipv4_cidr_parms(p, network_idx, max_idx, nor=
malized, gc);
+    if (res < 0)
+    {
+        msg(msglevel, "%s parameter %s '%s' has invalid CIDR notation",
+            p[0], cidr_label, p[network_idx]);
+        return false;
+    }
+
+    if (res =3D=3D 1 && p[max_idx])
+    {
+        msg(msglevel, "%s parameter has too many arguments when using CIDR=
 %s",
+            p[0], cidr_label);
+        return false;
+    }
+
+    return true;
+}
+
 void
 update_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
               const char *file, int line, const int level, const msglvl_t =
msglevel,
@@ -5369,8 +5399,15 @@
     {
         if (!(options->push_update_options_found & OPT_P_U_ROUTE))
         {
+            char *route_parms[MAX_PARMS + 1] =3D { 0 };
+
             VERIFY_PERMISSION(OPT_P_ROUTE);
-            if (!check_route_option(options, p, msglevel, pull_mode))
+            if (!ipv4_cidr_parms_checked(p, 1, 4, route_parms, "network/IP=
", msglevel, &options->gc))
+            {
+                goto err;
+            }
+
+            if (!check_route_option(options, route_parms, msglevel, pull_m=
ode))
             {
                 goto err;
             }
@@ -5885,18 +5922,32 @@
         iproute_path =3D p[1];
     }
 #endif
-    else if (streq(p[0], "ifconfig") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], "ifconfig") && p[1] && !p[3])
     {
+        char *ifconfig_parms[MAX_PARMS + 1] =3D { 0 };
+
         VERIFY_PERMISSION(OPT_P_UP);
-        if (ip_or_dns_addr_safe(p[1], options->allow_pull_fqdn)
-            && ip_or_dns_addr_safe(p[2], options->allow_pull_fqdn)) /* FQD=
N -- may be DNS name */
+        if (!ipv4_cidr_parms_checked(p, 1, 2, ifconfig_parms, "local/IP", =
msglevel, &options->gc))
         {
-            options->ifconfig_local =3D p[1];
-            options->ifconfig_remote_netmask =3D p[2];
+            goto err;
+        }
+        if (!ifconfig_parms[2])
+        {
+            msg(msglevel, "--ifconfig requires 'local remote/netmask' or '=
local/bits'");
+            goto err;
+        }
+
+        if (ip_or_dns_addr_safe(ifconfig_parms[1], options->allow_pull_fqd=
n)
+            && ip_or_dns_addr_safe(ifconfig_parms[2],
+                                   options->allow_pull_fqdn)) /* FQDN -- m=
ay be DNS name */
+        {
+            options->ifconfig_local =3D ifconfig_parms[1];
+            options->ifconfig_remote_netmask =3D ifconfig_parms[2];
         }
         else
         {
-            msg(msglevel, "ifconfig parms '%s' and '%s' must be valid addr=
esses", p[1], p[2]);
+            msg(msglevel, "ifconfig parms '%s' and '%s' must be valid addr=
esses",
+                ifconfig_parms[1], ifconfig_parms[2]);
             goto err;
         }
     }
@@ -6790,11 +6841,24 @@
         VERIFY_PERMISSION(OPT_P_PERSIST_IP);
         options->persist_remote_ip =3D true;
     }
-    else if (streq(p[0], "client-nat") && p[1] && p[2] && p[3] && p[4] && =
!p[5])
+    else if (streq(p[0], "client-nat") && p[1] && p[2] && !p[5])
     {
+        char *client_nat_parms[MAX_PARMS + 1] =3D { 0 };
+
         VERIFY_PERMISSION(OPT_P_ROUTE);
+        if (!ipv4_cidr_parms_checked(p, 2, 4, client_nat_parms, "network/I=
P", msglevel, &options->gc))
+        {
+            goto err;
+        }
+        if (!client_nat_parms[3] || !client_nat_parms[4])
+        {
+            msg(msglevel, "--client-nat requires 'snat|dnat network netmas=
k alias' or "
+                          "'snat|dnat network/bits alias'");
+            goto err;
+        }
         cnol_check_alloc(options);
-        add_client_nat_to_option_list(options->client_nat, p[1], p[2], p[3=
], p[4], msglevel);
+        add_client_nat_to_option_list(options->client_nat, client_nat_parm=
s[1], client_nat_parms[2],
+                                      client_nat_parms[3], client_nat_parm=
s[4], msglevel);
     }
     else if (streq(p[0], "route-table") && p[1] && !p[2])
     {
@@ -6807,11 +6871,19 @@
     else if (streq(p[0], "route") && p[1] && !p[5])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        if (!check_route_option(options, p, msglevel, pull_mode))
+
+        char *route_parms[MAX_PARMS + 1] =3D { 0 };
+        if (!ipv4_cidr_parms_checked(p, 1, 4, route_parms, "network/IP", m=
sglevel, &options->gc))
         {
             goto err;
         }
-        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4],
+
+        if (!check_route_option(options, route_parms, msglevel, pull_mode))
+        {
+            goto err;
+        }
+        add_route_to_option_list(options->routes, route_parms[1], route_pa=
rms[2], route_parms[3],
+                                 route_parms[4],
                                  options->route_default_table_id);
     }
     else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
@@ -7131,15 +7203,26 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->occ =3D false;
     }
-    else if (streq(p[0], "server") && p[1] && p[2] && !p[4])
+    else if (streq(p[0], "server") && p[1] && !p[4])
     {
         const int lev =3D M_WARN;
         bool error =3D false;
         in_addr_t network, netmask;
+        char *server_parms[MAX_PARMS + 1] =3D { 0 };

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        network =3D get_ip_addr(p[1], lev, &error);
-        netmask =3D get_ip_addr(p[2], lev, &error);
+        if (!ipv4_cidr_parms_checked(p, 1, 3, server_parms, "network/IP", =
msglevel, &options->gc))
+        {
+            goto err;
+        }
+        if (!server_parms[2])
+        {
+            msg(msglevel, "--server requires 'network netmask [nopool]' or=
 'network/bits [nopool]'");
+            goto err;
+        }
+
+        network =3D get_ip_addr(server_parms[1], lev, &error);
+        netmask =3D get_ip_addr(server_parms[2], lev, &error);
         if (error || !network || !netmask)
         {
             msg(msglevel, "error parsing --server parameters");
@@ -7149,15 +7232,16 @@
         options->server_network =3D network;
         options->server_netmask =3D netmask;

-        if (p[3])
+        if (server_parms[3])
         {
-            if (streq(p[3], "nopool"))
+            if (streq(server_parms[3], "nopool"))
             {
                 options->server_flags |=3D SF_NOPOOL;
             }
             else
             {
-                msg(msglevel, "error parsing --server: %s is not a recogni=
zed flag", p[3]);
+                msg(msglevel, "error parsing --server: %s is not a recogni=
zed flag",
+                    server_parms[3]);
                 goto err;
             }
         }
@@ -7185,17 +7269,29 @@
         options->server_network_ipv6 =3D network;
         options->server_netbits_ipv6 =3D netbits;
     }
-    else if (streq(p[0], "server-bridge") && p[1] && p[2] && p[3] && p[4] =
&& !p[5])
+    else if (streq(p[0], "server-bridge") && p[1] && p[2] && p[3] && !p[5])
     {
         const int lev =3D M_WARN;
         bool error =3D false;
         in_addr_t ip, netmask, pool_start, pool_end;
+        char *server_bridge_parms[MAX_PARMS + 1] =3D { 0 };

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ip =3D get_ip_addr(p[1], lev, &error);
-        netmask =3D get_ip_addr(p[2], lev, &error);
-        pool_start =3D get_ip_addr(p[3], lev, &error);
-        pool_end =3D get_ip_addr(p[4], lev, &error);
+        if (!ipv4_cidr_parms_checked(p, 1, 4, server_bridge_parms, "gatewa=
y/IP", msglevel, &options->gc))
+        {
+            goto err;
+        }
+        if (!server_bridge_parms[4])
+        {
+            msg(msglevel, "--server-bridge requires 'gateway netmask pool-=
start-IP pool-end-IP' "
+                          "or 'gateway/bits pool-start-IP pool-end-IP'");
+            goto err;
+        }
+
+        ip =3D get_ip_addr(server_bridge_parms[1], lev, &error);
+        netmask =3D get_ip_addr(server_bridge_parms[2], lev, &error);
+        pool_start =3D get_ip_addr(server_bridge_parms[3], lev, &error);
+        pool_end =3D get_ip_addr(server_bridge_parms[4], lev, &error);
         if (error || !ip || !netmask || !pool_start || !pool_end)
         {
             msg(msglevel, "error parsing --server-bridge parameters");
@@ -7542,30 +7638,51 @@
     }
     else if (streq(p[0], "iroute") && p[1] && !p[3])
     {
+        char *iroute_parms[MAX_PARMS + 1] =3D { 0 };
+
         VERIFY_PERMISSION(OPT_P_INSTANCE);
-        option_iroute(options, p[1], p[2], msglevel);
+        if (!ipv4_cidr_parms_checked(p, 1, 2, iroute_parms, "network/IP", =
msglevel, &options->gc))
+        {
+            goto err;
+        }
+        option_iroute(options, iroute_parms[1], iroute_parms[2], msglevel);
     }
     else if (streq(p[0], "iroute-ipv6") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INSTANCE);
         option_iroute_ipv6(options, p[1], msglevel);
     }
-    else if (streq(p[0], "ifconfig-push") && p[1] && p[2] && !p[4])
+    else if (streq(p[0], "ifconfig-push") && p[1] && !p[4])
     {
         in_addr_t local, remote_netmask;
+        char *ifconfig_push_parms[MAX_PARMS + 1] =3D { 0 };

         VERIFY_PERMISSION(OPT_P_INSTANCE);
-        local =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[1], 0, N=
ULL, NULL);
-        remote_netmask =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p=
[2], 0, NULL, NULL);
+        if (!ipv4_cidr_parms_checked(p, 1, 3, ifconfig_push_parms, "local/=
IP", msglevel, &options->gc))
+        {
+            goto err;
+        }
+        if (!ifconfig_push_parms[2])
+        {
+            msg(msglevel, "--ifconfig-push requires 'local remote-netmask =
[alias]' or "
+                          "'local/bits [alias]'");
+            goto err;
+        }
+
+        local =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig_p=
ush_parms[1], 0, NULL,
+                        NULL);
+        remote_netmask =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, i=
fconfig_push_parms[2], 0,
+                                 NULL, NULL);
         if (local && remote_netmask)
         {
             options->push_ifconfig_defined =3D true;
             options->push_ifconfig_local =3D local;
             options->push_ifconfig_remote_netmask =3D remote_netmask;
-            if (p[3])
+            if (ifconfig_push_parms[3])
             {
                 options->push_ifconfig_local_alias =3D
-                    getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[3], 0,=
 NULL, NULL);
+                    getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig=
_push_parms[3], 0,
+                            NULL, NULL);
             }
         }
         else
@@ -7574,13 +7691,26 @@
             goto err;
         }
     }
-    else if (streq(p[0], "ifconfig-push-constraint") && p[1] && p[2] && !p=
[3])
+    else if (streq(p[0], "ifconfig-push-constraint") && p[1] && !p[3])
     {
         in_addr_t network, netmask;
+        char *ifconfig_push_constraint_parms[MAX_PARMS + 1] =3D { 0 };

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        network =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[1], 0,=
 NULL, NULL);
-        netmask =3D getaddr(GETADDR_HOST_ORDER, p[2], 0, NULL, NULL);
+        if (!ipv4_cidr_parms_checked(p, 1, 2, ifconfig_push_constraint_par=
ms, "network/IP", msglevel,
+                                     &options->gc))
+        {
+            goto err;
+        }
+        if (!ifconfig_push_constraint_parms[2])
+        {
+            msg(msglevel, "--ifconfig-push-constraint requires 'network ne=
tmask' or 'network/bits'");
+            goto err;
+        }
+
+        network =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig=
_push_constraint_parms[1],
+                          0, NULL, NULL);
+        netmask =3D getaddr(GETADDR_HOST_ORDER, ifconfig_push_constraint_p=
arms[2], 0, NULL, NULL);
         if (network && netmask)
         {
             options->push_ifconfig_constraint_defined =3D true;
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 8d0a143..ed00aed 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -193,6 +193,100 @@
     return true;
 }
=20
+static int
+ipv4_cidr_to_netmask(const char *in_cidr, const char *slash, const char **=
out_network,
+                     const char **out_netmask, struct gc_arena *gc)
+{
+    ASSERT(in_cidr);
+    ASSERT(slash);
+    ASSERT(slash[0] =3D=3D '/');
+
+    if (slash[1] =3D=3D '\0')
+    {
+        return -EINVAL;
+    }
+
+    const size_t slash_offset =3D (size_t)(slash - in_cidr);
+    if (slash_offset =3D=3D 0)
+    {
+        return -EINVAL;
+    }
+
+    /* build the network string */
+    char *network_buf =3D gc_malloc(slash_offset + 1, true, gc);
+    memcpy(network_buf, in_cidr, slash_offset);
+    network_buf[slash_offset] =3D '\0';
+
+    /* extract the prefix value */
+    errno =3D 0;
+    char *endptr =3D NULL;
+    const unsigned long prefix =3D strtoul(slash + 1, &endptr, 10);
+    if (errno !=3D 0 || endptr =3D=3D slash + 1 || *endptr !=3D '\0' || pr=
efix > 32)
+    {
+        return -EINVAL;
+    }
+
+    /* build the netmask string */
+
+    /* Keep this self-contained: using print_in_addr_t here would pull
+     * socket_util.c dependencies into options_util unit-test targets. */
+    struct in_addr netmask_addr =3D {
+        .s_addr =3D htonl(netbits_to_netmask((int)prefix))
+    };
+    char *netmask_buf =3D gc_malloc(INET_ADDRSTRLEN, true, gc);
+    if (!inet_ntop(AF_INET, &netmask_addr, netmask_buf, INET_ADDRSTRLEN))
+    {
+        return -EINVAL;
+    }
+
+    *out_network =3D network_buf;
+    *out_netmask =3D netmask_buf;
+
+    return 0;
+}
+
+int
+convert_ipv4_cidr_parms(char *p[], int network_idx, int max_idx, char *nor=
malized[],
+                        struct gc_arena *gc)
+{
+    ASSERT(max_idx < MAX_PARMS);
+    ASSERT(max_idx >=3D (network_idx + 1));
+    ASSERT(network_idx >=3D 1);
+    ASSERT(p[network_idx]);
+
+    /* map normalized parameters to the user provided ones */
+    for (int i =3D 0; i <=3D max_idx && p[i]; ++i)
+    {
+        normalized[i] =3D p[i];
+    }
+
+    const char *slash =3D strchr(p[network_idx], '/');
+    if (!slash)
+    {
+        return 0;
+    }
+
+    const char *network =3D NULL;
+    const char *netmask =3D NULL;
+    const int err =3D ipv4_cidr_to_netmask(p[network_idx], slash, &network=
, &netmask, gc);
+    if (err)
+    {
+        return err;
+    }
+
+    /* insert the netmask and shift the next parameters */
+    normalized[network_idx] =3D (char *)network;
+    normalized[network_idx + 1] =3D (char *)netmask;
+    for (int src =3D network_idx + 1, dst =3D network_idx + 2; dst <=3D ma=
x_idx; ++src, ++dst)
+    {
+        normalized[dst] =3D p[src];
+    }
+    /* keep argv-style null termination to avoid stale tail entries */
+    normalized[max_idx + 1] =3D NULL;
+
+    return 1;
+}
+
 static const char *updatable_options[] =3D { "block-ipv6", "block-outside-=
dns",
                                            "dhcp-option", "dns",
                                            "ifconfig", "ifconfig-ipv6",
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 511d189..4c6ea3a 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -108,4 +108,37 @@
  */
 bool check_push_update_option_flags(char *line, int *i, unsigned int *flag=
s);

+/**
+ * Convert option parameters whose first IPv4 parameter may be in CIDR not=
ation.
+ *
+ * The input tokens are read from \p p and the normalized output tokens are
+ * written to \p normalized.
+ *
+ * When \p p[network_idx] is in CIDR form (for example, ``10.8.0.0/24``), =
this
+ * function:
+ * - splits the network and prefix length,
+ * - converts the prefix length to dotted-quad netmask,
+ * - writes ``network`` and ``netmask`` into ``normalized[network_idx]`` a=
nd
+ *   ``normalized[network_idx + 1]``,
+ * - shifts remaining parameters one position to preserve legacy
+ *   ``network netmask ...`` layout.
+ *
+ * When \p p[network_idx] is not CIDR, \p normalized receives \p p unchang=
ed
+ * for the copied range (indices ``0..max_idx`` until ``NULL``), and no
+ * conversion is applied.
+ *
+ * @param p Input option tokens (argv-style, NULL-terminated).
+ * @param network_idx Index in \p p of the parameter that may contain CIDR.
+ * @param max_idx Maximum parameter index to normalize.
+ * @param normalized Output token array receiving normalized parameters
+ *                   (argv-style, NULL-terminated in CIDR case).
+ * @param gc GC arena used for converted string allocations.
+ *
+ * @return 0 when no CIDR notation was present and no conversion was neede=
d.
+ * @return 1 when CIDR notation was present and conversion was applied.
+ * @return -EINVAL on malformed CIDR input.
+ */
+int convert_ipv4_cidr_parms(char *p[], int network_idx, int max_idx,
+                            char *normalized[], struct gc_arena *gc);
+
 #endif /* ifndef OPTIONS_UTIL_H_ */
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tes=
ts/openvpn/test_options_parse.c
index 0b3d7fe..9c08965 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -34,6 +34,7 @@
 #include <cmocka.h>

 #include "options.h"
+#include "options_util.h"
 #include "test_common.h"
 #include "mock_msg.h"

@@ -249,20 +250,9 @@
     gc_init(&o.gc);
     gc_init(&o.dns_options.gc);

-    char *p_expect_someopt[MAX_PARMS];
-    char *p_expect_otheropt[MAX_PARMS];
-    char *p_expect_inlineopt[MAX_PARMS];
-    CLEAR(p_expect_someopt);
-    CLEAR(p_expect_otheropt);
-    CLEAR(p_expect_inlineopt);
-    p_expect_someopt[0] =3D "someopt";
-    p_expect_someopt[1] =3D "parm1";
-    p_expect_someopt[2] =3D "parm2";
-    p_expect_otheropt[0] =3D "otheropt";
-    p_expect_otheropt[1] =3D "1";
-    p_expect_otheropt[2] =3D "2";
-    p_expect_inlineopt[0] =3D "inlineopt";
-    p_expect_inlineopt[1] =3D "some text\nother text\n";
+    char *p_expect_someopt[MAX_PARMS] =3D { "someopt", "parm1", "parm2", N=
ULL };
+    char *p_expect_otheropt[MAX_PARMS] =3D { "otheropt", "1", "2", NULL };
+    char *p_expect_inlineopt[MAX_PARMS] =3D { "inlineopt", "some text\noth=
er text\n", NULL };

     /* basic test */
     expect_function_call(add_option);
@@ -299,12 +289,141 @@
     gc_free(&o.dns_options.gc);
 }

+static void
+assert_tokens(char *actual[], const char *expected[], int max_idx)
+{
+    for (int i =3D 0; i <=3D max_idx + 1; ++i)
+    {
+        if (!expected[i])
+        {
+            assert_null(actual[i]);
+            continue;
+        }
+        assert_non_null(actual[i]);
+        assert_string_equal(actual[i], expected[i]);
+    }
+}
+
+static void
+test_convert_ipv4_cidr_parms_core(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    char *normalized[MAX_PARMS + 1] =3D { 0 };
+
+    /* non-CIDR input is returned unchanged */
+    char *legacy[MAX_PARMS + 1] =3D { "route", "10.8.0.0", "255.255.255.0"=
, NULL };
+    const char *legacy_expected[] =3D { "route", "10.8.0.0", "255.255.255.=
0", NULL, NULL, NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(legacy, 1, 4, normalized, &gc=
), 0);
+    assert_tokens(normalized, legacy_expected, 4);
+
+    /* CIDR input is split and netmask is materialized */
+    CLEAR(normalized);
+    char *cidr[MAX_PARMS + 1] =3D { "route", "10.8.0.0/24", NULL };
+    const char *cidr_expected[] =3D { "route", "10.8.0.0", "255.255.255.0"=
, NULL, NULL, NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(cidr, 1, 4, normalized, &gc),=
 1);
+    assert_tokens(normalized, cidr_expected, 4);
+
+    gc_free(&gc);
+}
+
+static void
+test_convert_ipv4_cidr_parms_coverage(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    char *normalized[MAX_PARMS + 1] =3D { 0 };
+
+    /* success paths */
+
+    /* route */
+    char *route[] =3D { "route", "10.1.2.0/24", "192.0.2.1", "7", NULL };
+    const char *route_expected[] =3D { "route", "10.1.2.0", "255.255.255.0=
", "192.0.2.1", "7",
+                                     NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route, 1, 4, normalized, &gc)=
, 1);
+    assert_tokens(normalized, route_expected, 4);
+
+    /* ifconfig */
+    CLEAR(normalized);
+    char *ifconfig[] =3D { "ifconfig", "10.8.0.1/24", NULL };
+    const char *ifconfig_expected[] =3D { "ifconfig", "10.8.0.1", "255.255=
.255.0", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(ifconfig, 1, 2, normalized, &=
gc), 1);
+    assert_tokens(normalized, ifconfig_expected, 2);
+
+    /* server */
+    CLEAR(normalized);
+    char *server[] =3D { "server", "10.8.0.0/24", "nopool", NULL };
+    const char *server_expected[] =3D { "server", "10.8.0.0", "255.255.255=
.0", "nopool", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(server, 1, 3, normalized, &gc=
), 1);
+    assert_tokens(normalized, server_expected, 3);
+
+    /* server-bridge */
+    CLEAR(normalized);
+    char *server_bridge[] =3D { "server-bridge", "10.8.0.1/24", "10.8.0.10=
", "10.8.0.20", NULL };
+    const char *server_bridge_expected[] =3D { "server-bridge", "10.8.0.1"=
, "255.255.255.0",
+                                             "10.8.0.10", "10.8.0.20", NUL=
L };
+    assert_int_equal(convert_ipv4_cidr_parms(server_bridge, 1, 4, normaliz=
ed, &gc), 1);
+    assert_tokens(normalized, server_bridge_expected, 4);
+
+    /* iroute */
+    CLEAR(normalized);
+    char *iroute[] =3D { "iroute", "172.16.0.0/16", NULL };
+    const char *iroute_expected[] =3D { "iroute", "172.16.0.0", "255.255.0=
.0", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(iroute, 1, 2, normalized, &gc=
), 1);
+    assert_tokens(normalized, iroute_expected, 2);
+
+    /* ifconfig-push */
+    CLEAR(normalized);
+    char *ifconfig_push[] =3D { "ifconfig-push", "10.8.0.6/24", "10.8.0.7"=
, NULL };
+    const char *ifconfig_push_expected[] =3D { "ifconfig-push", "10.8.0.6"=
, "255.255.255.0",
+                                             "10.8.0.7", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(ifconfig_push, 1, 3, normaliz=
ed, &gc), 1);
+    assert_tokens(normalized, ifconfig_push_expected, 3);
+
+    /* ifconfig-push-constraint */
+    CLEAR(normalized);
+    char *ifconfig_push_constraint[] =3D { "ifconfig-push-constraint", "10=
.8.0.0/24", NULL };
+    const char *ifconfig_push_constraint_expected[] =3D { "ifconfig-push-c=
onstraint", "10.8.0.0",
+                                                        "255.255.255.0", N=
ULL };
+    assert_int_equal(convert_ipv4_cidr_parms(ifconfig_push_constraint, 1, =
2, normalized, &gc),
+                     1);
+    assert_tokens(normalized, ifconfig_push_constraint_expected, 2);
+
+    /* client-nat */
+    CLEAR(normalized);
+    char *client_nat[] =3D { "client-nat", "snat", "192.168.0.0/16", "10.0=
.0.0", NULL };
+    const char *client_nat_expected[] =3D { "client-nat", "snat", "192.168=
.0.0", "255.255.0.0",
+                                          "10.0.0.0", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(client_nat, 2, 4, normalized,=
 &gc), 1);
+    assert_tokens(normalized, client_nat_expected, 4);
+
+    /* error paths */
+
+    char *route_invalid[] =3D { "route", "10.1.2.0/33", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid, 1, 4, normaliz=
ed, &gc), -EINVAL);
+    char *route_invalid_empty_network[] =3D { "route", "/24", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_empty_network, =
1, 4, normalized, &gc),
+                     -EINVAL);
+    char *route_invalid_no_prefix[] =3D { "route", "10.1.2.0/", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_no_prefix, 1, 4=
, normalized, &gc),
+                     -EINVAL);
+    char *route_invalid_alpha_prefix[] =3D { "route", "10.1.2.0/2x", NULL =
};
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_alpha_prefix, 1=
, 4, normalized, &gc),
+                     -EINVAL);
+
+    char *client_nat_invalid[] =3D { "client-nat", "snat", "192.168.0.0/35=
", "10.0.0.0", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(client_nat_invalid, 2, 4, nor=
malized, &gc),
+                     -EINVAL);
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
     const struct CMUnitTest tests[] =3D {
         cmocka_unit_test(test_parse_line),
         cmocka_unit_test(test_read_config),
+        cmocka_unit_test(test_convert_ipv4_cidr_parms_core),
+        cmocka_unit_test(test_convert_ipv4_cidr_parms_coverage),
     };

     return cmocka_run_group_tests_name("options_parse", tests, NULL, NULL);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9a766c9604efc9
Gerrit-Change-Number: 739
Gerrit-PatchSet: 8
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--4OlDDePVew4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici <strong>uploaded patch set #8</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">View Chang=
e</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">options: add IPv4 CIDR parsing for relevant directiv=
es<br><br>Add support for CIDR notation on all suitable options (client-nat=
,<br>ifconfig, ifconfig-push, ifconfig-push-constraint, iroute, route,<br>s=
erver, server-bridge). This change provides a more consistent approach<br>f=
or users already familiar with CIDR notation and simplifies network<br>conf=
iguration in scenarios where IP ranges are more naturally expressed<br>in C=
IDR form. It also allows for more compact OpenVPN configurations.<br><br>St=
atic --push &quot;...&quot; payloads remain opaque by design (current polic=
y),<br>so CIDR normalization is not applied to those strings.<br><br>Due to=
 current PUSH_UPDATE plumbing, option payloads are only<br>parsed/validated=
 when processed in update_option (after transmission),<br>so this change no=
rmalizes CIDR there but does not introduce pre-send<br>payload rewriting/va=
lidation as that would require a rework of the<br>PUSH_UPDATE architecture.=
 This also means compatibility is not<br>guaranteed for PUSH_UPDATE-capable=
 peers that do not parse CIDR: the<br>sender can accept a CIDR-formatted PU=
SH_UPDATE as valid after sending<br>it, while a PUSH_UPDATE-capable peer th=
at does not parse CIDR may reject<br>it; this can leave sender and receiver=
 with diverging effective state.<br><br>Internal behavior remains netmask-b=
ased, and existing netmask<br>environment variables are unchanged.<br><br>T=
ests for CIDR parsing and option normalization are added in<br>test_options=
_parse.c covering all affected options.<br><br>Change-Id: Iae04ad8715e40dfc=
76475c2c5b9a766c9604efc9<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt=
;<br>---<br>M doc/man-sections/client-options.rst<br>M doc/man-sections/ser=
ver-options.rst<br>M doc/man-sections/vpn-network-options.rst<br>M src/open=
vpn/options.c<br>M src/openvpn/options_util.c<br>M src/openvpn/options_util=
.h<br>M tests/unit_tests/openvpn/test_options_parse.c<br>7 files changed, 4=
86 insertions(+), 77 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/39/739/8</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rs=
t</span><br><span>index 85d25e5..c47e90e 100644</span><br><span>--- a/doc/m=
an-sections/client-options.rst</span><br><span>+++ b/doc/man-sections/clien=
t-options.rst</span><br><span>@@ -132,21 +132,23 @@</span><br><span>   ifco=
nfig settings pushed to the client would create an IP numbering</span><br><=
span>   conflict.</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  Valid syntax:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  Valid syntaxes:</span><br><span>   ::</span><br><span> </span><=
br><span>       client-nat snat|dnat network netmask alias</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      client-nat snat|dnat network/b=
its alias</span><br><span> </span><br><span>   Examples:</span><br><span>  =
 ::</span><br><span> </span><br><span>       client-nat snat 192.168.0.0 25=
5.255.0.0 10.64.0.0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
    client-nat dnat 10.64.0.0 255.255.0.0 192.168.0.0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      client-nat dnat 10.64.0.0/16 192.16=
8.0.0</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  ``network`` and ``netmask`` (for example :code:`192.168.0.0</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  255.255.0.0`) define the local =
view of a resource from the client</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  perspective, while ``alias`` (for example :code:`10.64.0.0`)=
 defines the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  remote =
view from the server perspective using the same netmask.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  ``network netmask`` (for example :co=
de:`192.168.0.0 255.255.0.0`) or</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  ``network/bits`` (for example :code:`192.168.0.0/16`) define=
s the local</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  view o=
f a resource from the client perspective, while ``alias`` (for</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  example :code:`10.64.0.0`) def=
ines the remote view from the server</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  perspective using the same netmask/bits.</span><br><span=
> </span><br><span>   Use :code:`snat` (source NAT) for resources owned by =
the client and</span><br><span>   :code:`dnat` (destination NAT) for remote=
 resources.</span><br><span>diff --git a/doc/man-sections/server-options.rs=
t b/doc/man-sections/server-options.rst</span><br><span>index 03ce651..68a7=
12d 100644</span><br><span>--- a/doc/man-sections/server-options.rst</span>=
<br><span>+++ b/doc/man-sections/server-options.rst</span><br><span>@@ -286=
,23 +286,27 @@</span><br><span>   Push virtual IP endpoints for client tunn=
el, overriding the</span><br><span>   ``--ifconfig-pool`` dynamic allocatio=
n.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 Valid syntax:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Val=
id syntaxes:</span><br><span>   ::</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     ifconfig-push local remote-netmask [al=
ias]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     ifconfig-p=
ush local remote [alias]</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     ifconfig-push local netmask [alias]</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     ifconfig-push local/bits [alias]</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The parameter=
s ``local`` and ``remote-netmask`` are set according to the</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  ``--ifconfig`` directive which you =
want to execute on the client machine</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  to configure the remote end of the tunnel. Note that the =
parameters</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``local``=
 and ``remote-netmask`` are from the perspective of the client,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  not the server. They may be DNS=
 names rather than IP addresses, in which</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  case they will be resolved on the server at the time =
of client</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  connection=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The parameters `=
`local remote`` or ``local netmask`` are set according to</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  the ``--ifconfig`` directive which =
you want to execute on the client</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  machine to configure the remote end of the tunnel. As a com=
pact form,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``local=
/bits`` can be used, in which case the netmask is derived from</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  ``bits``. Note that the parame=
ters ``local`` and ``remote`` are from the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  perspective of the client, not the server. They ma=
y be DNS names rather</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  than IP addresses, in which case they will be resolved on the server at=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the time of clien=
t connection.</span><br><span> </span><br><span>   The optional ``alias`` p=
arameter may be used in cases where NAT causes</span><br><span>   the clien=
t view of its local endpoint to differ from the server view. In</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  this case ``local/remote-netmas=
k`` will refer to the server view while</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  ``alias/remote-netmask`` will refer to the client view.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  this case ``local=
/netmask`` (or ``local/bits``) will refer to the server</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  view while ``alias/netmask`` (or ``al=
ias/bits``) will refer to the client</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  view.</span><br><span> </span><br><span>   This option m=
ust be associated with a specific client instance, which</span><br><span>  =
 means that it must be specified either in a client instance config file</s=
pan><br><span>@@ -328,6 +332,15 @@</span><br><span>   by ``--ifconfig``, Op=
enVPN will install a /32 host route for the ``local``</span><br><span>   IP=
 address.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+--ifconfig-push-constraint args</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  Restrict static IPv4 addresses from ``--ifconfig-push=
`` to a specific subnet.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntax=
es:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     ifconfig-push-constraint network netmask</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     ifconfig-push-const=
raint network/bits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> --ifconfig-ipv6-push args</span><br><span>   for ``--clien=
t-config-dir`` per-client static IPv6 interface</span><br><span>   configur=
ation, see ``--client-config-dir`` and ``--ifconfig-push`` for</span><br><s=
pan>@@ -367,13 +380,15 @@</span><br><span>       applies only to IPv6.</spa=
n><br><span> </span><br><span> --iroute args</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  Generate an internal route to a specific client. T=
he ``netmask``</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  param=
eter, if omitted, defaults to :code:`255.255.255.255`.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  Generate an internal route to a specif=
ic client. If both ``netmask`` and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  ``bits`` are omitted, the default netmask is :code:`255.25=
5.255.255`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (equiva=
lent to :code:`/32` in CIDR notation).</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  Valid syntax:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  Valid syntaxes:</span><br><span>   ::</spa=
n><br><span> </span><br><span>      iroute network [netmask]</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     iroute network[/bits]</span><=
br><span> </span><br><span>   This directive can be used to route a fixed s=
ubnet from the server to a</span><br><span>   particular client, regardless=
 of where the client is connecting from.</span><br><span>@@ -555,10 +570,11=
 @@</span><br><span>   optional :code:`nopool` flag is given, no dynamic IP=
 address pool will</span><br><span>   prepared for VPN clients.</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Valid syntax:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntaxes:</=
span><br><span>   ::</span><br><span> </span><br><span>       server networ=
k netmask [nopool]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     server network/bits [nopool]</span><br><span> </span><br><span>   For =
example, ``--server 10.8.0.0 255.255.255.0`` expands as follows:</span><br>=
<span>   ::</span><br><span>@@ -597,6 +613,7 @@</span><br><span>   ::</span=
><br><span> </span><br><span>       server-bridge gateway netmask pool-star=
t-IP pool-end-IP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   server-bridge gateway/bits pool-start-IP pool-end-IP</span><br><span>   =
    server-bridge [nogw]</span><br><span> </span><br><span>   If ``--server=
-bridge`` is used without any parameters, it will enable a</span><br><span>=
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst</span><br><span>index 33ebedb..27a61ed 100644</span><=
br><span>--- a/doc/man-sections/vpn-network-options.rst</span><br><span>+++=
 b/doc/man-sections/vpn-network-options.rst</span><br><span>@@ -223,19 +223=
,28 @@</span><br><span>         Android 10 or later.</span><br><span> </spa=
n><br><span> --ifconfig args</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  Valid syntaxes:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  ::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     ifconfig local remote<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     ifconfig local =
netmask</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     ifconfi=
g local/bits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>   Set TUN/TAP adapter parameters. It requires the *IP address* o=
f the local</span><br><span>   VPN endpoint. For TUN devices in point-to-po=
int mode, the next argument</span><br><span>   must be the VPN IP address o=
f the remote VPN endpoint. For TAP devices,</span><br><span>   or TUN devic=
es used with ``--topology subnet``, the second argument</span><br><span>   =
is the subnet mask of the virtual network segment which is being created</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-  or connected to.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  or connected to. In thi=
s netmask case, ``local/bits`` may be used as a</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  compact form.</span><br><span> </span><br><sp=
an>   For TUN devices, which facilitate virtual point-to-point IP connectio=
ns</span><br><span>   (when used in ``--topology net30`` or ``p2p`` mode), =
the proper usage of</span><br><span>   ``--ifconfig`` is to use two private=
 IP addresses which are not a member</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  of any existing subnet which is in use. The IP addresses m=
ay be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  of any exist=
ing subnet which is in use. In this mode, use the explicit</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  ``local remote`` form (CIDR form i=
s not applicable). The IP addresses may be</span><br><span>   consecutive a=
nd should have their order reversed on the remote peer.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  After the VPN is established, by pingin=
g ``rn``, you will be pinging</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  After the VPN is established, by pinging ``remote``, you will b=
e pinging</span><br><span>   across the VPN.</span><br><span> </span><br><s=
pan>   For TAP devices, which provide the ability to create virtual etherne=
t</span><br><span>@@ -267,6 +276,9 @@</span><br><span>      # tun/tap devic=
e in subnet mode</span><br><span>      ifconfig 10.8.0.2 255.255.255.0</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+     #=
 equivalent subnet-mode shorthand</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     ifconfig 10.8.0.2/24</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> --ifconfig-ipv6 args</span><br><span>=
   Configure an IPv6 address on the *tun* device.</span><br><span> </span><=
br><span>@@ -405,17 +417,16 @@</span><br><span>   Valid syntaxes:</span><br=
><span>   ::</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      route network/IP</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      route network/IP netmask</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-      route network/IP netmask gateway</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      route network/IP netmask gateway =
metric</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      route n=
etwork [netmask] [gateway] [metric]</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      route ipv4addr [netmask] [gateway] [metric]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      route ipv4addr[/bits] [=
gateway] [metric]</span><br><span> </span><br><span>   This option is inten=
ded as a convenience proxy for the ``route``\(8)</span><br><span>   shell c=
ommand, while at the same time providing portable semantics</span><br><span=
>   across OpenVPN&#39;s platform space.</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  ``netmask``</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        defaults to :code:`255.255.255.255` wh=
en not given</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``net=
mask`` (or ``bits``)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        defaults to :code:`255.255.255.255` (or :code:`/32`) when not give=
n</span><br><span> </span><br><span>   ``gateway``</span><br><span>        =
 default taken from ``--route-gateway`` or the second</span><br><span>@@ -4=
31,6 +442,9 @@</span><br><span>   DNS or :code:`/etc/hosts` file resolvable=
 name, or as one of three special</span><br><span>   keywords:</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The ``ipv4ad=
dr`` parameter may be specified using CIDR notation, thus</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  omitting the ``netmask`` parameter.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
 :code:`vpn_gateway`</span><br><span>       The remote VPN endpoint address=
 (derived either from</span><br><span>       ``--route-gateway`` or the sec=
ond parameter to ``--ifconfig``</span><br><span>diff --git a/src/openvpn/op=
tions.c b/src/openvpn/options.c</span><br><span>index fdbc678..042453a 1006=
44</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/op=
envpn/options.c</span><br><span>@@ -208,6 +208,8 @@</span><br><span>     &q=
uot;                  addresses outside of the subnets used by either peer.=
\n&quot;</span><br><span>     &quot;                  TAP: configure device=
 to use IP address l as a local\n&quot;</span><br><span>     &quot;        =
          endpoint and rn as a subnet mask.\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;                  In netmask mo=
de (TAP, or TUN with --topology subnet),\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;                  l may be specified=
 as l/bits.\n&quot;</span><br><span>     &quot;--ifconfig-ipv6 l r : config=
ure device to use IPv6 address l as local\n&quot;</span><br><span>     &quo=
t;                      endpoint (as a /64) and r as remote endpoint\n&quot=
;</span><br><span>     &quot;--ifconfig-noexec : Don&#39;t actually execute=
 ifconfig/netsh command, instead\n&quot;</span><br><span>@@ -221,6 +223,7 @=
@</span><br><span>     &quot;--route network [netmask] [gateway] [metric] :=
\n&quot;</span><br><span>     &quot;                  Add route to routing =
table after connection\n&quot;</span><br><span>     &quot;                 =
 is established.  Multiple routes can be specified.\n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;                  network=
 [netmask] can also be specified as network/bits.\n&quot;</span><br><span> =
    &quot;                  netmask default: 255.255.255.255\n&quot;</span>=
<br><span>     &quot;                  gateway default: taken from --route-=
gateway or --ifconfig\n&quot;</span><br><span>     &quot;                  =
Specify default by leaving blank or setting to \&quot;default\&quot;.\n&quo=
t;</span><br><span>@@ -259,6 +262,7 @@</span><br><span>     &quot;         =
          (Server) Instead of forwarding IPv6 packets send\n&quot;</span><b=
r><span>     &quot;                   ICMPv6 host unreachable packets to th=
e client.\n&quot;</span><br><span>     &quot;--client-nat snat|dnat network=
 netmask alias : on client add 1-to-1 NAT rule.\n&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    &quot;                  network net=
mask can also be specified as network/bits.\n&quot;</span><br><span>     &q=
uot;--push-peer-info : (client only) push client info to server.\n&quot;</s=
pan><br><span>     &quot;--setenv name value : Set a custom environmental v=
ariable to pass to script.\n&quot;</span><br><span>     &quot;--setenv FORW=
ARD_COMPATIBLE 1 : Relax config file syntax checking to allow\n&quot;</span=
><br><span>@@ -425,10 +429,12 @@</span><br><span>     &quot;--vlan-pvid v  =
 : Sets the Port VLAN Identifier. Defaults to 1.\n&quot;</span><br><span>  =
   &quot;\n&quot;</span><br><span>     &quot;Multi-Client Server options (w=
hen --mode server is used):\n&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &quot;--server network netmask : Helper option to easily =
configure server mode.\n&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &quot;--server network netmask [nopool] : Helper option to e=
asily configure server mode.\n&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &quot;                  network netmask can also be sp=
ecified as network/bits.\n&quot;</span><br><span>     &quot;--server-ipv6 n=
etwork/bits : Configure IPv6 server mode.\n&quot;</span><br><span>     &quo=
t;--server-bridge [IP netmask pool-start-IP pool-end-IP] : Helper option to=
\n&quot;</span><br><span>     &quot;                    easily configure et=
hernet bridging server mode.\n&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &quot;                    IP netmask can also be speci=
fied as IP/bits.\n&quot;</span><br><span>     &quot;--push \&quot;option\&q=
uot; : Push a config file option back to the peer for remote\n&quot;</span>=
<br><span>     &quot;                  execution.  Peer must specify --pull=
 in its config file.\n&quot;</span><br><span>     &quot;--push-reset    : D=
on&#39;t inherit global push list for specific\n&quot;</span><br><span>@@ -=
442,13 +448,15 @@</span><br><span>     &quot;                  If seconds=
=3D0, file will be treated as read-only.\n&quot;</span><br><span>     &quot=
;--ifconfig-ipv6-pool base-IP/bits : set aside an IPv6 network block\n&quot=
;</span><br><span>     &quot;                  to be dynamically allocated =
to connecting clients.\n&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    &quot;--ifconfig-push local remote-netmask : Push an ifconfig =
option to remote,\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    &quot;--ifconfig-push local remote-netmask [alias] : Push an ifco=
nfig option to remote,\n&quot;</span><br><span>     &quot;                 =
 overrides --ifconfig-pool dynamic allocation.\n&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    &quot;                  local can al=
so be specified as local/bits.\n&quot;</span><br><span>     &quot;         =
         Only valid in a client-specific config file.\n&quot;</span><br><sp=
an>     &quot;--ifconfig-ipv6-push local/bits remote : Push an ifconfig-ipv=
6 option to\n&quot;</span><br><span>     &quot;                  remote, ov=
errides --ifconfig-ipv6-pool allocation.\n&quot;</span><br><span>     &quot=
;                  Only valid in a client-specific config file.\n&quot;</sp=
an><br><span>     &quot;--iroute network [netmask] : Route subnet to client=
.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;=
                  network [netmask] can also be specified as network/bits.\=
n&quot;</span><br><span>     &quot;--iroute-ipv6 network/bits : Route IPv6 =
subnet to client.\n&quot;</span><br><span>     &quot;                  Sets=
 up internal routes only.\n&quot;</span><br><span>     &quot;              =
    Only valid in a client-specific config file.\n&quot;</span><br><span>@@=
 -5356,6 +5364,28 @@</span><br><span>     return true;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ipv4_cidr_p=
arms_checked(char *p[], int network_idx, int max_idx, char *normalized[],</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   const char *cidr_label, const msglvl_t msglevel, struct gc_arena *gc)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const int res =3D convert_ipv4_cidr_=
parms(p, network_idx, max_idx, normalized, gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (res &lt; 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(msglevel, &quot;%s parameter %s &#39;%s&#39; has =
invalid CIDR notation&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            p[0], cidr_label, p[network_idx]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (res =3D=3D 1 &amp;&amp; p[max_idx])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(msglevel, &quot;%s parameter has too many argume=
nts when using CIDR %s&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            p[0], cidr_label);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><b=
r><span> update_option(struct context *c, struct options *options, char *p[=
], bool is_inline,</span><br><span>               const char *file, int lin=
e, const int level, const msglvl_t msglevel,</span><br><span>@@ -5369,8 +53=
99,15 @@</span><br><span>     {</span><br><span>         if (!(options-&gt;=
push_update_options_found &amp; OPT_P_U_ROUTE))</span><br><span>         {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            char *ro=
ute_parms[MAX_PARMS + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>             VERIFY_PERMISSION(OPT_P_ROUTE=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!ch=
eck_route_option(options, p, msglevel, pull_mode))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (!ipv4_cidr_parms_checked(p, =
1, 4, route_parms, &quot;network/IP&quot;, msglevel, &amp;options-&gt;gc))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                goto err;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (!check_route_option(options, =
route_parms, msglevel, pull_mode))</span><br><span>             {</span><br=
><span>                 goto err;</span><br><span>             }</span><br>=
<span>@@ -5885,18 +5922,32 @@</span><br><span>         iproute_path =3D p[1=
];</span><br><span>     }</span><br><span> #endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;ifconfig&quot;) =
&amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;ifconfig&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        char *ifconfig_parms[MAX_PAR=
MS + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>         VERIFY_PERMISSION(OPT_P_UP);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (ip_or_dns_addr_safe(p[1], optio=
ns-&gt;allow_pull_fqdn)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            &amp;&amp; ip_or_dns_addr_safe(p[2], options-&gt;allow_pull_f=
qdn)) /* FQDN -- may be DNS name */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (!ipv4_cidr_parms_checked(p, 1, 2, ifconfig_parm=
s, &quot;local/IP&quot;, msglevel, &amp;options-&gt;gc))</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o=
ptions-&gt;ifconfig_local =3D p[1];</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            options-&gt;ifconfig_remote_netmask =3D p[2];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (!ifconfig_parms[2])=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &qu=
ot;--ifconfig requires &#39;local remote/netmask&#39; or &#39;local/bits&#3=
9;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (ip_or_dns_addr_safe(ifco=
nfig_parms[1], options-&gt;allow_pull_fqdn)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            &amp;&amp; ip_or_dns_addr_safe(ifconfig=
_parms[2],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                          options-&gt;allow_pull_fqdn)) /* FQDN -- may be D=
NS name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            options=
-&gt;ifconfig_local =3D ifconfig_parms[1];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            options-&gt;ifconfig_remote_netmask =3D =
ifconfig_parms[2];</span><br><span>         }</span><br><span>         else=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            msg(msglevel, &quot;ifconfig parms &#39;%s&#39; and &#39;=
%s&#39; must be valid addresses&quot;, p[1], p[2]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;ifconfig =
parms &#39;%s&#39; and &#39;%s&#39; must be valid addresses&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                ifconfig_par=
ms[1], ifconfig_parms[2]);</span><br><span>             goto err;</span><br=
><span>         }</span><br><span>     }</span><br><span>@@ -6790,11 +6841,=
24 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_PERSIST_IP);</span><=
br><span>         options-&gt;persist_remote_ip =3D true;</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (str=
eq(p[0], &quot;client-nat&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp;=
 p[3] &amp;&amp; p[4] &amp;&amp; !p[5])</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (streq(p[0], &quot;client-nat&quot;) &amp;&=
amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[5])</span><br><span>     {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        char *client_nat_par=
ms[MAX_PARMS + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>         VERIFY_PERMISSION(OPT_P_ROUTE);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ipv4_cidr_parms=
_checked(p, 2, 4, client_nat_parms, &quot;network/IP&quot;, msglevel, &amp;=
options-&gt;gc))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            g=
oto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!client_n=
at_parms[3] || !client_nat_parms[4])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(msglevel, &quot;--client-nat requires &#39;snat|dnat=
 network netmask alias&#39; or &quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                          &quot;&#39;snat|dnat network/bi=
ts alias&#39;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span>         cnol_check_alloc(options);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        add_client_nat_to_optio=
n_list(options-&gt;client_nat, p[1], p[2], p[3], p[4], msglevel);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        add_client_nat_to_opt=
ion_list(options-&gt;client_nat, client_nat_parms[1], client_nat_parms[2],<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                  client_nat_parms[3], client_nat_parms[4], msglevel);</spa=
n><br><span>     }</span><br><span>     else if (streq(p[0], &quot;route-ta=
ble&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><=
br><span>@@ -6807,11 +6871,19 @@</span><br><span>     else if (streq(p[0], =
&quot;route&quot;) &amp;&amp; p[1] &amp;&amp; !p[5])</span><br><span>     {=
</span><br><span>         VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (!check_route_option(options=
, p, msglevel, pull_mode))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char=
 *route_parms[MAX_PARMS + 1] =3D { 0 };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!ipv4_cidr_parms_checked(p, 1, 4, route_par=
ms, &quot;network/IP&quot;, msglevel, &amp;options-&gt;gc))</span><br><span=
>         {</span><br><span>             goto err;</span><br><span>        =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        add_route_t=
o_option_list(options-&gt;routes, p[1], p[2], p[3], p[4],</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (!check_route_option(options, route_parms, ms=
glevel, pull_mode))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        add_route_=
to_option_list(options-&gt;routes, route_parms[1], route_parms[2], route_pa=
rms[3],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                     route_parms[4],</span><br><span>                      =
            options-&gt;route_default_table_id);</span><br><span>     }</sp=
an><br><span>     else if (streq(p[0], &quot;route-ipv6&quot;) &amp;&amp; p=
[1] &amp;&amp; !p[4])</span><br><span>@@ -7131,15 +7203,26 @@</span><br><sp=
an>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         opti=
ons-&gt;occ =3D false;</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;server&quot;) &amp;&=
amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;server&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>        =
 const int lev =3D M_WARN;</span><br><span>         bool error =3D false;</=
span><br><span>         in_addr_t network, netmask;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        char *server_parms[MAX_PARMS + 1]=
 =3D { 0 };</span><br><span> </span><br><span>         VERIFY_PERMISSION(OP=
T_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
network =3D get_ip_addr(p[1], lev, &amp;error);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        netmask =3D get_ip_addr(p[2], lev, &amp;e=
rror);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
ipv4_cidr_parms_checked(p, 1, 3, server_parms, &quot;network/IP&quot;, msgl=
evel, &amp;options-&gt;gc))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (!server_parms[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(msglevel, &quot;--server requires &#39;network netmask [nopool]&#39; =
or &#39;network/bits [nopool]&#39;&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    network =3D get_ip_addr(server_parms[1], lev, &amp;error);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        netmask =3D get_ip_addr(=
server_parms[2], lev, &amp;error);</span><br><span>         if (error || !n=
etwork || !netmask)</span><br><span>         {</span><br><span>            =
 msg(msglevel, &quot;error parsing --server parameters&quot;);</span><br><s=
pan>@@ -7149,15 +7232,16 @@</span><br><span>         options-&gt;server_net=
work =3D network;</span><br><span>         options-&gt;server_netmask =3D n=
etmask;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (server_parms[3])</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if (streq(p[3], &quot;nopoo=
l&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (streq(server_parms[3], &quot;nopool&quot;))</span><br><span>         =
    {</span><br><span>                 options-&gt;server_flags |=3D SF_NOP=
OOL;</span><br><span>             }</span><br><span>             else</span=
><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                msg(msglevel, &quot;error parsing --server: %s is not a=
 recognized flag&quot;, p[3]);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                msg(msglevel, &quot;error parsing --server: %s i=
s not a recognized flag&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    server_parms[3]);</span><br><span>          =
       goto err;</span><br><span>             }</span><br><span>         }<=
/span><br><span>@@ -7185,17 +7269,29 @@</span><br><span>         options-&g=
t;server_network_ipv6 =3D network;</span><br><span>         options-&gt;ser=
ver_netbits_ipv6 =3D netbits;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;server-bridg=
e&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; p[4] &a=
mp;&amp; !p[5])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (streq(p[0], &quot;server-bridge&quot;) &amp;&amp; p[1] &amp;&amp; =
p[2] &amp;&amp; p[3] &amp;&amp; !p[5])</span><br><span>     {</span><br><sp=
an>         const int lev =3D M_WARN;</span><br><span>         bool error =
=3D false;</span><br><span>         in_addr_t ip, netmask, pool_start, pool=
_end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *=
server_bridge_parms[MAX_PARMS + 1] =3D { 0 };</span><br><span> </span><br><=
span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        ip =3D get_ip_addr(p[1], lev, &amp;error)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        netmask =3D =
get_ip_addr(p[2], lev, &amp;error);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        pool_start =3D get_ip_addr(p[3], lev, &amp;error);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        pool_end =3D get=
_ip_addr(p[4], lev, &amp;error);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (!ipv4_cidr_parms_checked(p, 1, 4, server_bridge_pa=
rms, &quot;gateway/IP&quot;, msglevel, &amp;options-&gt;gc))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!server_bridge_parms[4])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--server-bri=
dge requires &#39;gateway netmask pool-start-IP pool-end-IP&#39; &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
   &quot;or &#39;gateway/bits pool-start-IP pool-end-IP&#39;&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        ip =3D get_ip_addr(server_bridge_parms[1], le=
v, &amp;error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    netmask =3D get_ip_addr(server_bridge_parms[2], lev, &amp;error);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        pool_start =3D ge=
t_ip_addr(server_bridge_parms[3], lev, &amp;error);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        pool_end =3D get_ip_addr(server_b=
ridge_parms[4], lev, &amp;error);</span><br><span>         if (error || !ip=
 || !netmask || !pool_start || !pool_end)</span><br><span>         {</span>=
<br><span>             msg(msglevel, &quot;error parsing --server-bridge pa=
rameters&quot;);</span><br><span>@@ -7542,30 +7638,51 @@</span><br><span>  =
   }</span><br><span>     else if (streq(p[0], &quot;iroute&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        char *iroute_parms[MAX_PARMS + 1] =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>         VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        option_iroute(options, p[1], p[2], msglev=
el);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ip=
v4_cidr_parms_checked(p, 1, 2, iroute_parms, &quot;network/IP&quot;, msglev=
el, &amp;options-&gt;gc))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opti=
on_iroute(options, iroute_parms[1], iroute_parms[2], msglevel);</span><br><=
span>     }</span><br><span>     else if (streq(p[0], &quot;iroute-ipv6&quo=
t;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><spa=
n>         VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span>         opti=
on_iroute_ipv6(options, p[1], msglevel);</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;if=
config-push&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &=
quot;ifconfig-push&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><span=
>     {</span><br><span>         in_addr_t local, remote_netmask;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        char *ifconfig_push_p=
arms[MAX_PARMS + 1] =3D { 0 };</span><br><span> </span><br><span>         V=
ERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        local =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE,=
 p[1], 0, NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        remote_netmask =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p=
[2], 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!ipv4_cidr_parms_checked(p, 1, 3, ifconfig_push_parms, &quot;l=
ocal/IP&quot;, msglevel, &amp;options-&gt;gc))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!ifconfig_push_parms[2])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(msglevel, &quot;--ifconfig-push requires &#=
39;local remote-netmask [alias]&#39; or &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                          &quot;&#39;local/bits =
[alias]&#39;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        local =3D getaddr(=
GETADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig_push_parms[1], 0, NULL,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        remot=
e_netmask =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig_push_p=
arms[2], 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                         NULL, NULL);</span><br><span>         if (local &a=
mp;&amp; remote_netmask)</span><br><span>         {</span><br><span>       =
      options-&gt;push_ifconfig_defined =3D true;</span><br><span>         =
    options-&gt;push_ifconfig_local =3D local;</span><br><span>            =
 options-&gt;push_ifconfig_remote_netmask =3D remote_netmask;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (p[3])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (ifconfig_push_par=
ms[3])</span><br><span>             {</span><br><span>                 opti=
ons-&gt;push_ifconfig_local_alias =3D</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    getaddr(GETADDR_HOST_ORDER | GETADDR_RE=
SOLVE, p[3], 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, =
ifconfig_push_parms[3], 0,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                            NULL, NULL);</span><br><span>           =
  }</span><br><span>         }</span><br><span>         else</span><br><spa=
n>@@ -7574,13 +7691,26 @@</span><br><span>             goto err;</span><br>=
<span>         }</span><br><span>     }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    else if (streq(p[0], &quot;ifconfig-push-constraint&q=
uot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;ifconfig=
-push-constraint&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span> =
    {</span><br><span>         in_addr_t network, netmask;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        char *ifconfig_push_constrai=
nt_parms[MAX_PARMS + 1] =3D { 0 };</span><br><span> </span><br><span>      =
   VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        network =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RES=
OLVE, p[1], 0, NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        netmask =3D getaddr(GETADDR_HOST_ORDER, p[2], 0, NULL, NULL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ipv4_c=
idr_parms_checked(p, 1, 2, ifconfig_push_constraint_parms, &quot;network/IP=
&quot;, msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                   &amp;options-&gt;gc))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (!ifconfig_push_constraint_parms[2])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--ifco=
nfig-push-constraint requires &#39;network netmask&#39; or &#39;network/bit=
s&#39;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        network =3D getaddr(GETA=
DDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig_push_constraint_parms[1],</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    netmask =3D getaddr(GETADDR_HOST_ORDER, ifconfig_push_constraint_parms[=
2], 0, NULL, NULL);</span><br><span>         if (network &amp;&amp; netmask=
)</span><br><span>         {</span><br><span>             options-&gt;push_=
ifconfig_constraint_defined =3D true;</span><br><span>diff --git a/src/open=
vpn/options_util.c b/src/openvpn/options_util.c</span><br><span>index 8d0a1=
43..ed00aed 100644</span><br><span>--- a/src/openvpn/options_util.c</span><=
br><span>+++ b/src/openvpn/options_util.c</span><br><span>@@ -193,6 +193,10=
0 @@</span><br><span>     return true;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ipv4_cidr_to_netmask(const c=
har *in_cidr, const char *slash, const char **out_network,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                     const char **ou=
t_netmask, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AS=
SERT(in_cidr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    A=
SSERT(slash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AS=
SERT(slash[0] =3D=3D &#39;/&#39;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (slash[1] =3D=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return -EINVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t slash_offset=
 =3D (size_t)(slash - in_cidr);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (slash_offset =3D=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return -EINVAL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* build the net=
work string */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
har *network_buf =3D gc_malloc(slash_offset + 1, true, gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    memcpy(network_buf, in_cidr, sl=
ash_offset);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    net=
work_buf[slash_offset] =3D &#39;\0&#39;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* extract the prefix value */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    errno =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    char *endptr =3D NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const unsigned long prefix =3D strtoul(slash + 1, =
&amp;endptr, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (errno !=3D 0 || endptr =3D=3D slash + 1 || *endptr !=3D &#39;\0&#39; =
|| prefix &gt; 32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
-EINVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* build the netmask string */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Keep this self-contained: using print_in_=
addr_t here would pull</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * socket_util.c dependencies into options_util unit-test targets. *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in_addr=
 netmask_addr =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        .s_addr =3D htonl(netbits_to_netmask((int)prefix))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    char *netmask_buf =3D gc_malloc(INET_ADDRSTRL=
EN, true, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!inet_ntop(AF_INET, &amp;netmask_addr, netmask_buf, INET_ADDRSTRLEN))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    *out_network =3D network_buf;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    *out_netmask =3D netmask_buf;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+convert_ipv4_cidr_parms(char *p[], int n=
etwork_idx, int max_idx, char *normalized[],</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        struct gc_arena *gc)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(max_idx &lt; MAX_PARMS);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(max_idx &gt;=
=3D (network_idx + 1));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ASSERT(network_idx &gt;=3D 1);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ASSERT(p[network_idx]);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* map normalized parameters to the user provided ones */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &=
lt;=3D max_idx &amp;&amp; p[i]; ++i)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        normalized[i] =3D p[i];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *sl=
ash =3D strchr(p[network_idx], &#39;/&#39;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!slash)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *network =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *netmask =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const int err =3D ipv4_cidr_to_netmask(p[network_idx], slash, &amp;netw=
ork, &amp;netmask, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return er=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* insert the netmask and shift the next param=
eters */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    normali=
zed[network_idx] =3D (char *)network;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    normalized[network_idx + 1] =3D (char *)netmask;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int src =3D net=
work_idx + 1, dst =3D network_idx + 2; dst &lt;=3D max_idx; ++src, ++dst)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        normalized[dst] =3D p[src];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* keep argv-style null termi=
nation to avoid stale tail entries */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    normalized[max_idx + 1] =3D NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return 1;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> static const char *updatable_options[] =3D { &quot;block-ipv6&qu=
ot;, &quot;block-outside-dns&quot;,</span><br><span>                       =
                     &quot;dhcp-option&quot;, &quot;dns&quot;,</span><br><s=
pan>                                            &quot;ifconfig&quot;, &quot=
;ifconfig-ipv6&quot;,</span><br><span>diff --git a/src/openvpn/options_util=
.h b/src/openvpn/options_util.h</span><br><span>index 511d189..4c6ea3a 1006=
44</span><br><span>--- a/src/openvpn/options_util.h</span><br><span>+++ b/s=
rc/openvpn/options_util.h</span><br><span>@@ -108,4 +108,37 @@</span><br><s=
pan>  */</span><br><span> bool check_push_update_option_flags(char *line, i=
nt *i, unsigned int *flags);</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Convert option parameters whose first IPv4 parameter may be i=
n CIDR notation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The input tokens =
are read from \p p and the normalized output tokens are</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * written to \p normalized.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * When \p p[network_idx] is in CIDR form (for =
example, ``10.8.0.0/24``), this</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * function:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * - splits the network and prefix length,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * - converts the prefix length to dotted-quad =
netmask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - writes=
 ``network`` and ``netmask`` into ``normalized[network_idx]`` and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *   ``normalized[network_idx=
 + 1]``,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - shifts=
 remaining parameters one position to preserve legacy</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *   ``network netmask ...`` layout.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * When \p p[network_idx] is not CIDR, \p=
 normalized receives \p p unchanged</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * for the copied range (indices ``0..max_idx`` until ``NUL=
L``), and no</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * conv=
ersion is applied.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param p Input =
option tokens (argv-style, NULL-terminated).</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param network_idx Index in \p p of the paramet=
er that may contain CIDR.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param max_idx Maximum parameter index to normalize.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param normalized Output token=
 array receiving normalized parameters</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *                   (argv-style, NULL-terminated in CID=
R case).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param g=
c GC arena used for converted string allocations.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return 0 when no CIDR notation was present and no conversi=
on was needed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn 1 when CIDR notation was present and conversion was applied.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @return -EINVAL on malfor=
med CIDR input.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+int convert_ipv4_cid=
r_parms(char *p[], int network_idx, int max_idx,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                            char *normalized[]=
, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> #endif /* ifndef OPTIONS_UTIL_H_ */</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_test=
s/openvpn/test_options_parse.c</span><br><span>index 0b3d7fe..9c08965 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/test_options_parse.c</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_options_parse.c</span><br><s=
pan>@@ -34,6 +34,7 @@</span><br><span> #include &lt;cmocka.h&gt;</span><br>=
<span> </span><br><span> #include &quot;options.h&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util.h&quot;</sp=
an><br><span> #include &quot;test_common.h&quot;</span><br><span> #include =
&quot;mock_msg.h&quot;</span><br><span> </span><br><span>@@ -249,20 +250,9 =
@@</span><br><span>     gc_init(&amp;o.gc);</span><br><span>     gc_init(&a=
mp;o.dns_options.gc);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    char *p_expect_someopt[MAX_PARMS];</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    char *p_expect_otheropt[MAX_PARMS];<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *p_expect_inl=
ineopt[MAX_PARMS];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 CLEAR(p_expect_someopt);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    CLEAR(p_expect_otheropt);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    CLEAR(p_expect_inlineopt);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    p_expect_someopt[0] =3D &quot;someopt&quot;;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    p_expect_someopt[1] =3D=
 &quot;parm1&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  p_expect_someopt[2] =3D &quot;parm2&quot;;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    p_expect_otheropt[0] =3D &quot;otheropt&quot;;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p_expect_otheropt[1=
] =3D &quot;1&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   p_expect_otheropt[2] =3D &quot;2&quot;;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    p_expect_inlineopt[0] =3D &quot;inlineopt&quot;;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p_expect_inlineopt[=
1] =3D &quot;some text\nother text\n&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    char *p_expect_someopt[MAX_PARMS] =3D { &quot;s=
omeopt&quot;, &quot;parm1&quot;, &quot;parm2&quot;, NULL };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    char *p_expect_otheropt[MAX_PAR=
MS] =3D { &quot;otheropt&quot;, &quot;1&quot;, &quot;2&quot;, NULL };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *p_expect_inline=
opt[MAX_PARMS] =3D { &quot;inlineopt&quot;, &quot;some text\nother text\n&q=
uot;, NULL };</span><br><span> </span><br><span>     /* basic test */</span=
><br><span>     expect_function_call(add_option);</span><br><span>@@ -299,1=
2 +289,141 @@</span><br><span>     gc_free(&amp;o.dns_options.gc);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+assert_tokens(char *actual[], const char *expected[], int max_idx)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt;=3D max_idx + 1; =
++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (!expected[i])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            assert_null(actual[i]=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            conti=
nue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_non_null(a=
ctual[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
ssert_string_equal(actual[i], expected[i]);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_convert_ipv4_cidr_parms_core(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ch=
ar *normalized[MAX_PARMS + 1] =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* non-CIDR input is returned unchanged */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    char *legacy[MAX_PARMS + 1] =3D { &quot;ro=
ute&quot;, &quot;10.8.0.0&quot;, &quot;255.255.255.0&quot;, NULL };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *legacy_expe=
cted[] =3D { &quot;route&quot;, &quot;10.8.0.0&quot;, &quot;255.255.255.0&q=
uot;, NULL, NULL, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(convert_ipv4_cidr_parms(legacy, 1, 4, normalized=
, &amp;gc), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_tokens(normalized, legacy_expected, 4);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* CIDR input is split and netmask is materialized */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(normalized);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char *cidr[MAX_PARMS +=
 1] =3D { &quot;route&quot;, &quot;10.8.0.0/24&quot;, NULL };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char *cidr_expected[] =
=3D { &quot;route&quot;, &quot;10.8.0.0&quot;, &quot;255.255.255.0&quot;, N=
ULL, NULL, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(convert_ipv4_cidr_parms(cidr, 1, 4, normalized, &amp;gc=
), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_to=
kens(normalized, cidr_expected, 4);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_convert_ipv4_cidr_parms_coverage(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *norma=
lized[MAX_PARMS + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
success paths */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* route */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char *route[] =3D { &q=
uot;route&quot;, &quot;10.1.2.0/24&quot;, &quot;192.0.2.1&quot;, &quot;7&qu=
ot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *route_expected[] =3D { &quot;route&quot;, &quot;10.1.2.0&quot;, &q=
uot;255.255.255.0&quot;, &quot;192.0.2.1&quot;, &quot;7&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
     NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(convert_ipv4_cidr_parms(route, 1, 4, normalized, &amp;gc), 1)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tokens(=
normalized, route_expected, 4);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
ifconfig */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEA=
R(normalized);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
har *ifconfig[] =3D { &quot;ifconfig&quot;, &quot;10.8.0.1/24&quot;, NULL }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *if=
config_expected[] =3D { &quot;ifconfig&quot;, &quot;10.8.0.1&quot;, &quot;2=
55.255.255.0&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(convert_ipv4_cidr_parms(ifconfig, 1, 2, normal=
ized, &amp;gc), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_tokens(normalized, ifconfig_expected, 2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* server */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    CLEAR(normalized);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char *server[] =3D { &quot;server&quot;, &quot;10.8.0.0/=
24&quot;, &quot;nopool&quot;, NULL };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *server_expected[] =3D { &quot;server&quot=
;, &quot;10.8.0.0&quot;, &quot;255.255.255.0&quot;, &quot;nopool&quot;, NUL=
L };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(convert_ipv4_cidr_parms(server, 1, 3, normalized, &amp;gc), 1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tokens(normali=
zed, server_expected, 3);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* server=
-bridge */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR=
(normalized);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ch=
ar *server_bridge[] =3D { &quot;server-bridge&quot;, &quot;10.8.0.1/24&quot=
;, &quot;10.8.0.10&quot;, &quot;10.8.0.20&quot;, NULL };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *server_bridge_expected=
[] =3D { &quot;server-bridge&quot;, &quot;10.8.0.1&quot;, &quot;255.255.255=
.0&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                   &quot;10.8.0.10&quot;, &quot;10.8.0.20&q=
uot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(convert_ipv4_cidr_parms(server_bridge, 1, 4, normalized, &am=
p;gc), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_tokens(normalized, server_bridge_expected, 4);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* iroute */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    CLEAR(normalized);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    char *iroute[] =3D { &quot;iroute&quot;, &quot;172.16.0.0/16&=
quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *iroute_expected[] =3D { &quot;iroute&quot;, &quot;172.16.0.0&quo=
t;, &quot;255.255.0.0&quot;, NULL };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(convert_ipv4_cidr_parms(iroute, 1, 2,=
 normalized, &amp;gc), 1);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_tokens(normalized, iroute_expected, 2);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* ifconfig-push */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    CLEAR(normalized);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    char *ifconfig_push[] =3D { &quot;ifconfig-pu=
sh&quot;, &quot;10.8.0.6/24&quot;, &quot;10.8.0.7&quot;, NULL };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const char *ifconfig_push_=
expected[] =3D { &quot;ifconfig-push&quot;, &quot;10.8.0.6&quot;, &quot;255=
.255.255.0&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                           &quot;10.8.0.7&quot;, NULL };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(c=
onvert_ipv4_cidr_parms(ifconfig_push, 1, 3, normalized, &amp;gc), 1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tokens(normali=
zed, ifconfig_push_expected, 3);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 ifconfig-push-constraint */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    CLEAR(normalized);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    char *ifconfig_push_constraint[] =3D { &quot;ifconfig-push-=
constraint&quot;, &quot;10.8.0.0/24&quot;, NULL };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *ifconfig_push_constraint_exp=
ected[] =3D { &quot;ifconfig-push-constraint&quot;, &quot;10.8.0.0&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                                   &quot;255.255.255.0&quot;, NULL };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(conv=
ert_ipv4_cidr_parms(ifconfig_push_constraint, 1, 2, normalized, &amp;gc),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_token=
s(normalized, ifconfig_push_constraint_expected, 2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* client-nat */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    CLEAR(normalized);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char *client_nat[] =3D { &quot;client-nat&quot;, &qu=
ot;snat&quot;, &quot;192.168.0.0/16&quot;, &quot;10.0.0.0&quot;, NULL };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *client=
_nat_expected[] =3D { &quot;client-nat&quot;, &quot;snat&quot;, &quot;192.1=
68.0.0&quot;, &quot;255.255.0.0&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                          &quot;10.0.0.0=
&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(convert_ipv4_cidr_parms(client_nat, 2, 4, normalized, &amp=
;gc), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_tokens(normalized, client_nat_expected, 4);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* error paths */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *r=
oute_invalid[] =3D { &quot;route&quot;, &quot;10.1.2.0/33&quot;, NULL };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(c=
onvert_ipv4_cidr_parms(route_invalid, 1, 4, normalized, &amp;gc), -EINVAL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *route_inv=
alid_empty_network[] =3D { &quot;route&quot;, &quot;/24&quot;, NULL };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(con=
vert_ipv4_cidr_parms(route_invalid_empty_network, 1, 4, normalized, &amp;gc=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
    -EINVAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ch=
ar *route_invalid_no_prefix[] =3D { &quot;route&quot;, &quot;10.1.2.0/&quot=
;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(convert_ipv4_cidr_parms(route_invalid_no_prefix, 1, 4, normaliz=
ed, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
               -EINVAL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    char *route_invalid_alpha_prefix[] =3D { &quot;route&quot;, &quot;=
10.1.2.0/2x&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_alpha_pre=
fix, 1, 4, normalized, &amp;gc),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                     -EINVAL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    char *client_nat_invalid[] =3D { &quot;client-nat&quot;, &quot;sna=
t&quot;, &quot;192.168.0.0/35&quot;, &quot;10.0.0.0&quot;, NULL };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(convert=
_ipv4_cidr_parms(client_nat_invalid, 2, 4, normalized, &amp;gc),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                     -EINVAL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> int</span><br><span> main(void)</spa=
n><br><span> {</span><br><span>     const struct CMUnitTest tests[] =3D {</=
span><br><span>         cmocka_unit_test(test_parse_line),</span><br><span>=
         cmocka_unit_test(test_read_config),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_convert_ipv4_cidr_pa=
rms_core),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mocka_unit_test(test_convert_ipv4_cidr_parms_coverage),</span><br><span>   =
  };</span><br><span> </span><br><span>     return cmocka_run_group_tests_n=
ame(&quot;options_parse&quot;, tests, NULL, NULL);</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/739?usp=3Demail">change 739</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9=
a766c9604efc9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 739 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
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

</body></html>=

--4OlDDePVew4=--

