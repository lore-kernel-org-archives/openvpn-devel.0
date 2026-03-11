From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Wed, 11 Mar 2026 09:21:31 +0000
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d7cf9505e60d8a69ddbbc0935f70b71886771ca1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2L4i9zIi0E8="; charset=UTF-8
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

--2L4i9zIi0E8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail

to look at the new patch set (#14).


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
M CMakeLists.txt
M doc/man-sections/client-options.rst
M doc/man-sections/server-options.rst
M doc/man-sections/vpn-network-options.rst
M src/openvpn/options.c
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/mock_setenv.c
A tests/unit_tests/openvpn/mock_signal.c
M tests/unit_tests/openvpn/test_options_parse.c
M tests/unit_tests/openvpn/test_ssl.c
12 files changed, 681 insertions(+), 88 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/739/14

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 198c98f..5ce044b 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -778,6 +778,7 @@

     target_sources(test_ssl PRIVATE
             tests/unit_tests/openvpn/mock_management.c
+            tests/unit_tests/openvpn/mock_signal.c
             tests/unit_tests/openvpn/mock_ssl_dependencies.c
             tests/unit_tests/openvpn/mock_win32_execve.c
             src/openvpn/argv.c
@@ -794,6 +795,7 @@
             src/openvpn/otime.c
             src/openvpn/packet_id.c
             src/openvpn/run_command.c
+            src/openvpn/socket_util.c
             src/openvpn/ssl_mbedtls.c
             src/openvpn/ssl_openssl.c
             src/openvpn/ssl_util.c
@@ -802,6 +804,7 @@
             src/openvpn/xkey_helper.c
             src/openvpn/xkey_provider.c
     )
+    target_link_libraries(test_ssl PUBLIC ${RESOLV_LIBRARIES})

     target_sources(test_mbuf PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
@@ -811,10 +814,15 @@

     target_sources(test_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
+        tests/unit_tests/openvpn/mock_management.c
+        tests/unit_tests/openvpn/mock_setenv.c
+        tests/unit_tests/openvpn/mock_signal.c
         src/openvpn/options_util.c
+        src/openvpn/socket_util.c
         src/openvpn/ssl_util.c
         src/openvpn/list.c
         )
+    target_link_libraries(test_misc PUBLIC ${RESOLV_LIBRARIES})

     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch.c
@@ -829,9 +837,14 @@

     target_sources(test_options_parse PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
+        tests/unit_tests/openvpn/mock_management.c
+        tests/unit_tests/openvpn/mock_setenv.c
+        tests/unit_tests/openvpn/mock_signal.c
         src/openvpn/options_parse.c
         src/openvpn/options_util.c
+        src/openvpn/socket_util.c
         )
+    target_link_libraries(test_options_parse PUBLIC ${RESOLV_LIBRARIES})

     target_sources(test_packet_id PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
@@ -888,10 +901,15 @@
     target_sources(test_push_update_msg PRIVATE
         tests/unit_tests/openvpn/mock_msg.c
         tests/unit_tests/openvpn/mock_get_random.c
+        tests/unit_tests/openvpn/mock_management.c
+        tests/unit_tests/openvpn/mock_setenv.c
+        tests/unit_tests/openvpn/mock_signal.c
         src/openvpn/options_util.c
         src/openvpn/otime.c
+        src/openvpn/socket_util.c
         src/openvpn/list.c
         )
+    target_link_libraries(test_push_update_msg PUBLIC ${RESOLV_LIBRARIES})

     target_sources(test_argv PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
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
=20
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
index 03ce651..daaa807 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -286,23 +286,28 @@
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
+  view, so the server will actually push ``ifconfig alias remote/netmask``=
 to
+  the client.

   This option must be associated with a specific client instance, which
   means that it must be specified either in a client instance config file
@@ -328,6 +333,15 @@
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
@@ -367,13 +381,15 @@
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
@@ -555,10 +571,11 @@
   optional :code:`nopool` flag is given, no dynamic IP address pool will
   prepared for VPN clients.

-  Valid syntax:
+  Valid syntaxes:
   ::

       server network netmask [nopool]
+      server network/bits [nopool]

   For example, ``--server 10.8.0.0 255.255.255.0`` expands as follows:
   ::
@@ -597,6 +614,7 @@
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
index 8daec42..cee168b 100644
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
+    "                  network netmask can also be specified as network/bi=
ts.\n"
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
+    "                  local remote-netmask can also be specified as local=
/bits.\n"
     "                  Only valid in a client-specific config file.\n"
     "--ifconfig-ipv6-push local/bits remote : Push an ifconfig-ipv6 option=
 to\n"
     "                  remote, overrides --ifconfig-ipv6-pool allocation.\=
n"
     "                  Only valid in a client-specific config file.\n"
     "--iroute network [netmask] : Route subnet to client.\n"
+    "                  network netmask can also be specified as network/bi=
ts.\n"
     "--iroute-ipv6 network/bits : Route IPv6 subnet to client.\n"
     "                  Sets up internal routes only.\n"
     "                  Only valid in a client-specific config file.\n"
@@ -5365,6 +5373,28 @@
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
@@ -5378,8 +5408,15 @@
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
@@ -5899,18 +5936,32 @@
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
@@ -6804,11 +6855,24 @@
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
@@ -6821,11 +6885,19 @@
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
@@ -7145,15 +7217,26 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->occ =3D false;
     }
-    else if (streq(p[0], "server") && p[1] && p[2] && !p[4])
+    else if (streq(p[0], "server") && p[1] && !p[4])
     {
-        const int lev =3D M_WARN;
+        const msglvl_t lev =3D M_WARN;
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
@@ -7163,22 +7246,23 @@
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
     }
     else if (streq(p[0], "server-ipv6") && p[1] && !p[2])
     {
-        const int lev =3D M_WARN;
+        const msglvl_t lev =3D M_WARN;
         struct in6_addr network;
         unsigned int netbits =3D 0;

@@ -7199,17 +7283,29 @@
         options->server_network_ipv6 =3D network;
         options->server_netbits_ipv6 =3D netbits;
     }
-    else if (streq(p[0], "server-bridge") && p[1] && p[2] && p[3] && p[4] =
&& !p[5])
+    else if (streq(p[0], "server-bridge") && p[1] && p[2] && p[3] && !p[5])
     {
-        const int lev =3D M_WARN;
+        const msglvl_t lev =3D M_WARN;
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
@@ -7250,7 +7346,7 @@
     }
     else if (streq(p[0], "ifconfig-pool") && p[1] && p[2] && !p[4])
     {
-        const int lev =3D M_WARN;
+        const msglvl_t lev =3D M_WARN;
         bool error =3D false;
         in_addr_t start, end, netmask =3D 0;

@@ -7290,7 +7386,7 @@
     }
     else if (streq(p[0], "ifconfig-ipv6-pool") && p[1] && !p[2])
     {
-        const int lev =3D M_WARN;
+        const msglvl_t lev =3D M_WARN;
         struct in6_addr network;
         unsigned int netbits =3D 0;

@@ -7556,30 +7652,51 @@
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
@@ -7588,13 +7705,26 @@
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
index 8d0a143..3d8938c 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -30,6 +30,7 @@
 #include "options_util.h"

 #include "push.h"
+#include "socket_util.h"

 const char *
 parse_auth_failed_temp(struct options *o, const char *reason)
@@ -193,6 +194,96 @@
     return true;
 }

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
+    /* extract and validate the prefix value */
+    const char *prefix_str =3D slash + 1;
+    if (strspn(prefix_str, "0123456789") !=3D strlen(prefix_str))
+    {
+        return -EINVAL;
+    }
+
+    errno =3D 0;
+    char *endptr =3D NULL;
+    const unsigned long prefix =3D strtoul(prefix_str, &endptr, 10);
+    if (errno !=3D 0 || endptr =3D=3D prefix_str || *endptr !=3D '\0' || p=
refix > 32)
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
+    /* build the netmask string */
+    const char *netmask_buf =3D print_in_addr_t(netbits_to_netmask((int)pr=
efix), 0, gc);
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
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 1128eb4..e277d40 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -98,10 +98,11 @@
 ssl_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
-ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
+ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS) $(SOCKE=
TS_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_management.c \
+	mock_signal.c \
 	mock_ssl_dependencies.c mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
@@ -121,6 +122,7 @@
 	$(top_srcdir)/src/openvpn/packet_id.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/run_command.c \
+	$(top_srcdir)/src/openvpn/socket_util.c \
 	$(top_srcdir)/src/openvpn/ssl_openssl.c \
 	$(top_srcdir)/src/openvpn/ssl_mbedtls.c \
 	$(top_srcdir)/src/openvpn/ssl_util.c \
@@ -221,13 +223,18 @@
 endif

 options_parse_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_s=
rcdir)/src/compat @TEST_CFLAGS@
-options_parse_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/op=
envpn
+options_parse_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/op=
envpn \
+	$(SOCKETS_LIBS)
 options_parse_testdriver_SOURCES =3D test_options_parse.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
+	mock_management.c \
+	mock_setenv.c \
+	mock_signal.c \
 	$(top_srcdir)/src/openvpn/options_parse.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/socket_util.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c

@@ -365,12 +372,16 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	-DSOURCEDIR=3D\"$(top_srcdir)\" @TEST_CFLAGS@

-misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ $(SOCKETS_LIBS)

 misc_testdriver_SOURCES =3D test_misc.c \
 	mock_msg.c test_common.h  \
 	mock_get_random.c \
+	mock_management.c \
+	mock_setenv.c \
+	mock_signal.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/socket_util.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
 	$(top_srcdir)/src/openvpn/ssl_util.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
@@ -384,15 +395,20 @@
=20
 push_update_msg_testdriver_LDFLAGS =3D \
 	@TEST_LDFLAGS@ \
-	-L$(top_srcdir)/src/openvpn
+	-L$(top_srcdir)/src/openvpn \
+	$(SOCKETS_LIBS)

 push_update_msg_testdriver_SOURCES =3D test_push_update_msg.c \
 	mock_msg.c \
 	mock_get_random.c \
+	mock_management.c \
+	mock_setenv.c \
+	mock_signal.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/options_util.c \
 	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/socket_util.c \
 	$(top_srcdir)/src/openvpn/list.c

 socket_testdriver_CFLAGS  =3D \
diff --git a/tests/unit_tests/openvpn/mock_setenv.c b/tests/unit_tests/open=
vpn/mock_setenv.c
new file mode 100644
index 0000000..a35a295
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_setenv.c
@@ -0,0 +1,39 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "env_set.h"
+
+void
+setenv_str(struct env_set *es, const char *name, const char *value)
+{
+}
+
+void
+setenv_int(struct env_set *es, const char *name, int value)
+{
+}
diff --git a/tests/unit_tests/openvpn/mock_signal.c b/tests/unit_tests/open=
vpn/mock_signal.c
new file mode 100644
index 0000000..4d27541
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_signal.c
@@ -0,0 +1,47 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@...515...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "socket.h"
+
+struct signal_info siginfo_static; /* GLOBAL */
+
+int
+signal_reset(struct signal_info *si, int signum)
+{
+    return signum;
+}
+
+#ifdef _WIN32
+struct win32_signal win32_signal; /* GLOBAL */
+
+int
+win32_signal_get(struct win32_signal *ws)
+{
+    return 0;
+}
+#endif
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tes=
ts/openvpn/test_options_parse.c
index 0b3d7fe..babafde 100644
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
@@ -299,12 +289,209 @@
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
+    /* CIDR prefix boundaries */
+
+    /* /0 */
+    CLEAR(normalized);
+    char *route_default[MAX_PARMS + 1] =3D { "route", "0.0.0.0/0", NULL };
+    const char *route_default_expected[] =3D { "route", "0.0.0.0", "0.0.0.=
0", NULL, NULL, NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_default, 1, 4, normaliz=
ed, &gc), 1);
+    assert_tokens(normalized, route_default_expected, 4);
+
+    /* /32 */
+    CLEAR(normalized);
+    char *route_host[MAX_PARMS + 1] =3D { "route", "198.51.100.42/32", NUL=
L };
+    const char *route_host_expected[] =3D { "route", "198.51.100.42", "255=
.255.255.255", NULL,
+                                          NULL, NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_host, 1, 4, normalized,=
 &gc), 1);
+    assert_tokens(normalized, route_host_expected, 4);
+
+    /* CIDR with DNS-style network token */
+    CLEAR(normalized);
+    char *route_dns_cidr[] =3D { "route", "vpn.example/24", "192.0.2.1", N=
ULL };
+    const char *route_dns_cidr_expected[] =3D { "route", "vpn.example", "2=
55.255.255.0",
+                                              "192.0.2.1", NULL, NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_dns_cidr, 1, 4, normali=
zed, &gc), 1);
+    assert_tokens(normalized, route_dns_cidr_expected, 4);
+
+    /* non-CIDR passthrough (DNS-style network token) */
+    CLEAR(normalized);
+    char *route_dns[] =3D { "route", "vpn.example", "255.255.255.0", "192.=
0.2.1", NULL };
+    const char *route_dns_expected[] =3D { "route", "vpn.example", "255.25=
5.255.0", "192.0.2.1",
+                                         NULL, NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_dns, 1, 4, normalized, =
&gc), 0);
+    assert_tokens(normalized, route_dns_expected, 4);
+
+    /* varied network_idx/max_idx shapes */
+
+    CLEAR(normalized);
+    char *generic_shift[] =3D { "opt", "x", "y", "10.9.0.0/25", "tail", NU=
LL };
+    const char *generic_shift_expected[] =3D { "opt", "x", "y", "10.9.0.0"=
, "255.255.255.128",
+                                             "tail", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(generic_shift, 3, 5, normaliz=
ed, &gc), 1);
+    assert_tokens(normalized, generic_shift_expected, 5);
+
+    CLEAR(normalized);
+    char *near_limit[MAX_PARMS + 1] =3D { 0 };
+    near_limit[0] =3D "opt";
+    near_limit[MAX_PARMS - 2] =3D "203.0.113.0/24";
+    assert_int_equal(
+        convert_ipv4_cidr_parms(near_limit, MAX_PARMS - 2, MAX_PARMS - 1, =
normalized, &gc), 1);
+    assert_string_equal(normalized[0], "opt");
+    assert_string_equal(normalized[MAX_PARMS - 2], "203.0.113.0");
+    assert_string_equal(normalized[MAX_PARMS - 1], "255.255.255.0");
+    assert_null(normalized[MAX_PARMS]);
+
+    /* error paths */
+
+    char *route_invalid[] =3D { "route", "10.1.2.0/33", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid, 1, 4, normaliz=
ed, &gc), -EINVAL);
+    char *route_invalid_negative_prefix[] =3D { "route", "10.1.2.0/-1", NU=
LL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_negative_prefix=
, 1, 4, normalized,
+                                             &gc),
+                     -EINVAL);
+    char *route_invalid_plus_prefix[] =3D { "route", "10.1.2.0/+24", NULL =
};
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_plus_prefix, 1,=
 4, normalized, &gc),
+                     -EINVAL);
+    char *route_invalid_malformed_slash[] =3D { "route", "10.1.2.0//24", N=
ULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_malformed_slash=
, 1, 4, normalized,
+                                             &gc),
+                     -EINVAL);
+    char *route_invalid_overflow_prefix[] =3D { "route", "10.1.2.0/9999999=
99999999999999", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_overflow_prefix=
, 1, 4, normalized,
+                                             &gc),
+                     -EINVAL);
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
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 2b73ee7..9182cb8 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -51,8 +51,6 @@
 /* Mock function to be allowed to include win32.c which is required for
  * getting the temp directory */
 #ifdef _WIN32
-struct signal_info siginfo_static; /* GLOBAL */
-
 const char *
 strerror_win32(DWORD errnum, struct gc_arena *gc)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9a766c9604efc9
Gerrit-Change-Number: 739
Gerrit-PatchSet: 14
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--2L4i9zIi0E8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici <strong>uploaded patch set #14</strong> to this change.</p><p>=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">options: add IPv4 CIDR parsing for relevant directi=
ves<br><br>Add support for CIDR notation on all suitable options (client-na=
t,<br>ifconfig, ifconfig-push, ifconfig-push-constraint, iroute, route,<br>=
server, server-bridge). This change provides a more consistent approach<br>=
for users already familiar with CIDR notation and simplifies network<br>con=
figuration in scenarios where IP ranges are more naturally expressed<br>in =
CIDR form. It also allows for more compact OpenVPN configurations.<br><br>S=
tatic --push &quot;...&quot; payloads remain opaque by design (current poli=
cy),<br>so CIDR normalization is not applied to those strings.<br><br>Due t=
o current PUSH_UPDATE plumbing, option payloads are only<br>parsed/validate=
d when processed in update_option (after transmission),<br>so this change n=
ormalizes CIDR there but does not introduce pre-send<br>payload rewriting/v=
alidation as that would require a rework of the<br>PUSH_UPDATE architecture=
. This also means compatibility is not<br>guaranteed for PUSH_UPDATE-capabl=
e peers that do not parse CIDR: the<br>sender can accept a CIDR-formatted P=
USH_UPDATE as valid after sending<br>it, while a PUSH_UPDATE-capable peer t=
hat does not parse CIDR may reject<br>it; this can leave sender and receive=
r with diverging effective state.<br><br>Internal behavior remains netmask-=
based, and existing netmask<br>environment variables are unchanged.<br><br>=
Tests for CIDR parsing and option normalization are added in<br>test_option=
s_parse.c covering all affected options.<br><br>Change-Id: Iae04ad8715e40df=
c76475c2c5b9a766c9604efc9<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&g=
t;<br>---<br>M CMakeLists.txt<br>M doc/man-sections/client-options.rst<br>M=
 doc/man-sections/server-options.rst<br>M doc/man-sections/vpn-network-opti=
ons.rst<br>M src/openvpn/options.c<br>M src/openvpn/options_util.c<br>M src=
/openvpn/options_util.h<br>M tests/unit_tests/openvpn/Makefile.am<br>A test=
s/unit_tests/openvpn/mock_setenv.c<br>A tests/unit_tests/openvpn/mock_signa=
l.c<br>M tests/unit_tests/openvpn/test_options_parse.c<br>M tests/unit_test=
s/openvpn/test_ssl.c<br>12 files changed, 681 insertions(+), 88 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/39/739/14</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.t=
xt</span><br><span>index 198c98f..5ce044b 100644</span><br><span>--- a/CMak=
eLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -778,6 +=
778,7 @@</span><br><span> </span><br><span>     target_sources(test_ssl PRI=
VATE</span><br><span>             tests/unit_tests/openvpn/mock_management.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tests/=
unit_tests/openvpn/mock_signal.c</span><br><span>             tests/unit_te=
sts/openvpn/mock_ssl_dependencies.c</span><br><span>             tests/unit=
_tests/openvpn/mock_win32_execve.c</span><br><span>             src/openvpn=
/argv.c</span><br><span>@@ -794,6 +795,7 @@</span><br><span>             sr=
c/openvpn/otime.c</span><br><span>             src/openvpn/packet_id.c</spa=
n><br><span>             src/openvpn/run_command.c</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            src/openvpn/socket_util.c</span>=
<br><span>             src/openvpn/ssl_mbedtls.c</span><br><span>          =
   src/openvpn/ssl_openssl.c</span><br><span>             src/openvpn/ssl_u=
til.c</span><br><span>@@ -802,6 +804,7 @@</span><br><span>             src/=
openvpn/xkey_helper.c</span><br><span>             src/openvpn/xkey_provide=
r.c</span><br><span>     )</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    target_link_libraries(test_ssl PUBLIC ${RESOLV_LIBRARIES})</span=
><br><span> </span><br><span>     target_sources(test_mbuf PRIVATE</span><b=
r><span>         tests/unit_tests/openvpn/mock_get_random.c</span><br><span=
>@@ -811,10 +814,15 @@</span><br><span> </span><br><span>     target_source=
s(test_misc PRIVATE</span><br><span>         tests/unit_tests/openvpn/mock_=
get_random.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 tests/unit_tests/openvpn/mock_management.c</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_setenv.c</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests=
/openvpn/mock_signal.c</span><br><span>         src/openvpn/options_util.c<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/=
socket_util.c</span><br><span>         src/openvpn/ssl_util.c</span><br><sp=
an>         src/openvpn/list.c</span><br><span>         )</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    target_link_libraries(test_misc P=
UBLIC ${RESOLV_LIBRARIES})</span><br><span> </span><br><span>     target_so=
urces(test_ncp PRIVATE</span><br><span>         src/openvpn/crypto_epoch.c<=
/span><br><span>@@ -829,9 +837,14 @@</span><br><span> </span><br><span>    =
 target_sources(test_options_parse PRIVATE</span><br><span>         tests/u=
nit_tests/openvpn/mock_get_random.c</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        tests/unit_tests/openvpn/mock_management.c</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/ope=
nvpn/mock_setenv.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       tests/unit_tests/openvpn/mock_signal.c</span><br><span>         src/=
openvpn/options_parse.c</span><br><span>         src/openvpn/options_util.c=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn=
/socket_util.c</span><br><span>         )</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    target_link_libraries(test_options_parse PUBLIC $=
{RESOLV_LIBRARIES})</span><br><span> </span><br><span>     target_sources(t=
est_packet_id PRIVATE</span><br><span>         tests/unit_tests/openvpn/moc=
k_get_random.c</span><br><span>@@ -888,10 +901,15 @@</span><br><span>     t=
arget_sources(test_push_update_msg PRIVATE</span><br><span>         tests/u=
nit_tests/openvpn/mock_msg.c</span><br><span>         tests/unit_tests/open=
vpn/mock_get_random.c</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        tests/unit_tests/openvpn/mock_management.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_set=
env.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/=
unit_tests/openvpn/mock_signal.c</span><br><span>         src/openvpn/optio=
ns_util.c</span><br><span>         src/openvpn/otime.c</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/socket_util.c</span>=
<br><span>         src/openvpn/list.c</span><br><span>         )</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    target_link_libraries(test=
_push_update_msg PUBLIC ${RESOLV_LIBRARIES})</span><br><span> </span><br><s=
pan>     target_sources(test_argv PRIVATE</span><br><span>         tests/un=
it_tests/openvpn/mock_get_random.c</span><br><span>diff --git a/doc/man-sec=
tions/client-options.rst b/doc/man-sections/client-options.rst</span><br><s=
pan>index 85d25e5..c47e90e 100644</span><br><span>--- a/doc/man-sections/cl=
ient-options.rst</span><br><span>+++ b/doc/man-sections/client-options.rst<=
/span><br><span>@@ -132,21 +132,23 @@</span><br><span>   ifconfig settings =
pushed to the client would create an IP numbering</span><br><span>   confli=
ct.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  Valid syntax:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Va=
lid syntaxes:</span><br><span>   ::</span><br><span> </span><br><span>     =
  client-nat snat|dnat network netmask alias</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      client-nat snat|dnat network/bits alias</spa=
n><br><span> </span><br><span>   Examples:</span><br><span>   ::</span><br>=
<span> </span><br><span>       client-nat snat 192.168.0.0 255.255.0.0 10.6=
4.0.0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      client-nat=
 dnat 10.64.0.0 255.255.0.0 192.168.0.0</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      client-nat dnat 10.64.0.0/16 192.168.0.0</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``network`=
` and ``netmask`` (for example :code:`192.168.0.0</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  255.255.0.0`) define the local view of a reso=
urce from the client</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 perspective, while ``alias`` (for example :code:`10.64.0.0`) defines the</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  remote view from the =
server perspective using the same netmask.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  ``network netmask`` (for example :code:`192.168.0.=
0 255.255.0.0`) or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 ``network/bits`` (for example :code:`192.168.0.0/16`) defines the local</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  view of a resource f=
rom the client perspective, while ``alias`` (for</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  example :code:`10.64.0.0`) defines the remot=
e view from the server</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  perspective using the same netmask/bits.</span><br><span> </span><br><=
span>   Use :code:`snat` (source NAT) for resources owned by the client and=
</span><br><span>   :code:`dnat` (destination NAT) for remote resources.</s=
pan><br><span>diff --git a/doc/man-sections/server-options.rst b/doc/man-se=
ctions/server-options.rst</span><br><span>index 03ce651..daaa807 100644</sp=
an><br><span>--- a/doc/man-sections/server-options.rst</span><br><span>+++ =
b/doc/man-sections/server-options.rst</span><br><span>@@ -286,23 +286,28 @@=
</span><br><span>   Push virtual IP endpoints for client tunnel, overriding=
 the</span><br><span>   ``--ifconfig-pool`` dynamic allocation.</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Valid syntax:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntaxes:</=
span><br><span>   ::</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     ifconfig-push local remote-netmask [alias]</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     ifconfig-push local remot=
e [alias]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     ifcon=
fig-push local netmask [alias]</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     ifconfig-push local/bits [alias]</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  The parameters ``local`` and=
 ``remote-netmask`` are set according to the</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  ``--ifconfig`` directive which you want to execute=
 on the client machine</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  to configure the remote end of the tunnel. Note that the parameters</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``local`` and ``remote-n=
etmask`` are from the perspective of the client,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  not the server. They may be DNS names rather t=
han IP addresses, in which</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  case they will be resolved on the server at the time of client</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  connection.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  The parameters ``local remote``=
 or ``local netmask`` are set according to</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  the ``--ifconfig`` directive which you want to exe=
cute on the client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 machine to configure the remote end of the tunnel. As a compact form,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``local/bits`` can be =
used, in which case the netmask is derived from</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  ``bits``. Note that the parameters ``local`` =
and ``remote`` are from the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  perspective of the client, not the server. They may be DNS names =
rather</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  than IP add=
resses, in which case they will be resolved on the server at</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  the time of client connection.</=
span><br><span> </span><br><span>   The optional ``alias`` parameter may be=
 used in cases where NAT causes</span><br><span>   the client view of its l=
ocal endpoint to differ from the server view. In</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  this case ``local/remote-netmask`` will refer =
to the server view while</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  ``alias/remote-netmask`` will refer to the client view.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  this case ``local/netmask`` (or =
``local/bits``) will refer to the server</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  view while ``alias/netmask`` (or ``alias/bits``) wil=
l refer to the client</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  view, so the server will actually push ``ifconfig alias remote/netmask`=
` to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the client.</=
span><br><span> </span><br><span>   This option must be associated with a s=
pecific client instance, which</span><br><span>   means that it must be spe=
cified either in a client instance config file</span><br><span>@@ -328,6 +3=
33,15 @@</span><br><span>   by ``--ifconfig``, OpenVPN will install a /32 h=
ost route for the ``local``</span><br><span>   IP address.</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--ifconfig-push-co=
nstraint args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Rest=
rict static IPv4 addresses from ``--ifconfig-push`` to a specific subnet.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  Valid syntaxes:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     ifconfig-push-constraint network netmask</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     ifconfig-push-constraint network/bits</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --ifconf=
ig-ipv6-push args</span><br><span>   for ``--client-config-dir`` per-client=
 static IPv6 interface</span><br><span>   configuration, see ``--client-con=
fig-dir`` and ``--ifconfig-push`` for</span><br><span>@@ -367,13 +381,15 @@=
</span><br><span>       applies only to IPv6.</span><br><span> </span><br><=
span> --iroute args</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
Generate an internal route to a specific client. The ``netmask``</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  parameter, if omitted, default=
s to :code:`255.255.255.255`.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  Generate an internal route to a specific client. If both ``netm=
ask`` and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``bits``=
 are omitted, the default netmask is :code:`255.255.255.255`</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  (equivalent to :code:`/32` in CI=
DR notation).</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  Valid syntax:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  Valid syntaxes:</span><br><span>   ::</span><br><span> </span><br><=
span>      iroute network [netmask]</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     iroute network[/bits]</span><br><span> </span><br><spa=
n>   This directive can be used to route a fixed subnet from the server to =
a</span><br><span>   particular client, regardless of where the client is c=
onnecting from.</span><br><span>@@ -555,10 +571,11 @@</span><br><span>   op=
tional :code:`nopool` flag is given, no dynamic IP address pool will</span>=
<br><span>   prepared for VPN clients.</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  Valid syntax:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  Valid syntaxes:</span><br><span>   ::</spa=
n><br><span> </span><br><span>       server network netmask [nopool]</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      server network/bits =
[nopool]</span><br><span> </span><br><span>   For example, ``--server 10.8.=
0.0 255.255.255.0`` expands as follows:</span><br><span>   ::</span><br><sp=
an>@@ -597,6 +614,7 @@</span><br><span>   ::</span><br><span> </span><br><s=
pan>       server-bridge gateway netmask pool-start-IP pool-end-IP</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      server-bridge gateway/=
bits pool-start-IP pool-end-IP</span><br><span>       server-bridge [nogw]<=
/span><br><span> </span><br><span>   If ``--server-bridge`` is used without=
 any parameters, it will enable a</span><br><span>diff --git a/doc/man-sect=
ions/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst</sp=
an><br><span>index 33ebedb..27a61ed 100644</span><br><span>--- a/doc/man-se=
ctions/vpn-network-options.rst</span><br><span>+++ b/doc/man-sections/vpn-n=
etwork-options.rst</span><br><span>@@ -223,19 +223,28 @@</span><br><span>  =
       Android 10 or later.</span><br><span> </span><br><span> --ifconfig a=
rgs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntaxes=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     ifconfig local remote</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     ifconfig local netmask</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     ifconfig local/bits</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   Set TUN/TAP =
adapter parameters. It requires the *IP address* of the local</span><br><sp=
an>   VPN endpoint. For TUN devices in point-to-point mode, the next argume=
nt</span><br><span>   must be the VPN IP address of the remote VPN endpoint=
. For TAP devices,</span><br><span>   or TUN devices used with ``--topology=
 subnet``, the second argument</span><br><span>   is the subnet mask of the=
 virtual network segment which is being created</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  or connected to.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  or connected to. In this netmask case, ``local/b=
its`` may be used as a</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  compact form.</span><br><span> </span><br><span>   For TUN devices, wh=
ich facilitate virtual point-to-point IP connections</span><br><span>   (wh=
en used in ``--topology net30`` or ``p2p`` mode), the proper usage of</span=
><br><span>   ``--ifconfig`` is to use two private IP addresses which are n=
ot a member</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  of any e=
xisting subnet which is in use. The IP addresses may be</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  of any existing subnet which is in us=
e. In this mode, use the explicit</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  ``local remote`` form (CIDR form is not applicable). The IP=
 addresses may be</span><br><span>   consecutive and should have their orde=
r reversed on the remote peer.</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  After the VPN is established, by pinging ``rn``, you will be pin=
ging</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  After the VPN=
 is established, by pinging ``remote``, you will be pinging</span><br><span=
>   across the VPN.</span><br><span> </span><br><span>   For TAP devices, w=
hich provide the ability to create virtual ethernet</span><br><span>@@ -267=
,6 +276,9 @@</span><br><span>      # tun/tap device in subnet mode</span><b=
r><span>      ifconfig 10.8.0.2 255.255.255.0</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     # equivalent subnet-mode s=
horthand</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     ifconf=
ig 10.8.0.2/24</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> --ifconfig-ipv6 args</span><br><span>   Configure an IPv6 addr=
ess on the *tun* device.</span><br><span> </span><br><span>@@ -405,17 +417,=
16 @@</span><br><span>   Valid syntaxes:</span><br><span>   ::</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      route netw=
ork/IP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      route net=
work/IP netmask</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
route network/IP netmask gateway</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      route network/IP netmask gateway metric</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      route network [netmask] [gateway=
] [metric]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      rou=
te ipv4addr [netmask] [gateway] [metric]</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      route ipv4addr[/bits] [gateway] [metric]</span><=
br><span> </span><br><span>   This option is intended as a convenience prox=
y for the ``route``\(8)</span><br><span>   shell command, while at the same=
 time providing portable semantics</span><br><span>   across OpenVPN&#39;s =
platform space.</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  ``netmask``</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        defaults to :code:`255.255.255.255` when not given</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  ``netmask`` (or ``bits``)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        defaults to :cod=
e:`255.255.255.255` (or :code:`/32`) when not given</span><br><span> </span=
><br><span>   ``gateway``</span><br><span>         default taken from ``--r=
oute-gateway`` or the second</span><br><span>@@ -431,6 +442,9 @@</span><br>=
<span>   DNS or :code:`/etc/hosts` file resolvable name, or as one of three=
 special</span><br><span>   keywords:</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  The ``ipv4addr`` parameter may be spe=
cified using CIDR notation, thus</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  omitting the ``netmask`` parameter.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>   :code:`vpn_gateway`</spa=
n><br><span>       The remote VPN endpoint address (derived either from</sp=
an><br><span>       ``--route-gateway`` or the second parameter to ``--ifco=
nfig``</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/opt=
ions.c</span><br><span>index 8daec42..cee168b 100644</span><br><span>--- a/=
src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br=
><span>@@ -208,6 +208,8 @@</span><br><span>     &quot;                  add=
resses outside of the subnets used by either peer.\n&quot;</span><br><span>=
     &quot;                  TAP: configure device to use IP address l as a=
 local\n&quot;</span><br><span>     &quot;                  endpoint and rn=
 as a subnet mask.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &quot;                  In netmask mode (TAP, or TUN with --topo=
logy subnet),\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot;                  l may be specified as l/bits.\n&quot;</span><=
br><span>     &quot;--ifconfig-ipv6 l r : configure device to use IPv6 addr=
ess l as local\n&quot;</span><br><span>     &quot;                      end=
point (as a /64) and r as remote endpoint\n&quot;</span><br><span>     &quo=
t;--ifconfig-noexec : Don&#39;t actually execute ifconfig/netsh command, in=
stead\n&quot;</span><br><span>@@ -221,6 +223,7 @@</span><br><span>     &quo=
t;--route network [netmask] [gateway] [metric] :\n&quot;</span><br><span>  =
   &quot;                  Add route to routing table after connection\n&qu=
ot;</span><br><span>     &quot;                  is established.  Multiple =
routes can be specified.\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;                  network netmask can also be specif=
ied as network/bits.\n&quot;</span><br><span>     &quot;                  n=
etmask default: 255.255.255.255\n&quot;</span><br><span>     &quot;        =
          gateway default: taken from --route-gateway or --ifconfig\n&quot;=
</span><br><span>     &quot;                  Specify default by leaving bl=
ank or setting to \&quot;default\&quot;.\n&quot;</span><br><span>@@ -259,6 =
+262,7 @@</span><br><span>     &quot;                   (Server) Instead of=
 forwarding IPv6 packets send\n&quot;</span><br><span>     &quot;          =
         ICMPv6 host unreachable packets to the client.\n&quot;</span><br><=
span>     &quot;--client-nat snat|dnat network netmask alias : on client ad=
d 1-to-1 NAT rule.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &quot;                  network netmask can also be specified as=
 network/bits.\n&quot;</span><br><span>     &quot;--push-peer-info : (clien=
t only) push client info to server.\n&quot;</span><br><span>     &quot;--se=
tenv name value : Set a custom environmental variable to pass to script.\n&=
quot;</span><br><span>     &quot;--setenv FORWARD_COMPATIBLE 1 : Relax conf=
ig file syntax checking to allow\n&quot;</span><br><span>@@ -425,10 +429,12=
 @@</span><br><span>     &quot;--vlan-pvid v   : Sets the Port VLAN Identif=
ier. Defaults to 1.\n&quot;</span><br><span>     &quot;\n&quot;</span><br><=
span>     &quot;Multi-Client Server options (when --mode server is used):\n=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--ser=
ver network netmask : Helper option to easily configure server mode.\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--server=
 network netmask [nopool] : Helper option to easily configure server mode.\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;  =
                network netmask can also be specified as network/bits.\n&qu=
ot;</span><br><span>     &quot;--server-ipv6 network/bits : Configure IPv6 =
server mode.\n&quot;</span><br><span>     &quot;--server-bridge [IP netmask=
 pool-start-IP pool-end-IP] : Helper option to\n&quot;</span><br><span>    =
 &quot;                    easily configure ethernet bridging server mode.\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;  =
                  IP netmask can also be specified as IP/bits.\n&quot;</spa=
n><br><span>     &quot;--push \&quot;option\&quot; : Push a config file opt=
ion back to the peer for remote\n&quot;</span><br><span>     &quot;        =
          execution.  Peer must specify --pull in its config file.\n&quot;<=
/span><br><span>     &quot;--push-reset    : Don&#39;t inherit global push =
list for specific\n&quot;</span><br><span>@@ -442,13 +448,15 @@</span><br><=
span>     &quot;                  If seconds=3D0, file will be treated as r=
ead-only.\n&quot;</span><br><span>     &quot;--ifconfig-ipv6-pool base-IP/b=
its : set aside an IPv6 network block\n&quot;</span><br><span>     &quot;  =
                to be dynamically allocated to connecting clients.\n&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--ifconfig-p=
ush local remote-netmask : Push an ifconfig option to remote,\n&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--ifconfig-push=
 local remote-netmask [alias] : Push an ifconfig option to remote,\n&quot;<=
/span><br><span>     &quot;                  overrides --ifconfig-pool dyna=
mic allocation.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;                  local remote-netmask can also be specified =
as local/bits.\n&quot;</span><br><span>     &quot;                  Only va=
lid in a client-specific config file.\n&quot;</span><br><span>     &quot;--=
ifconfig-ipv6-push local/bits remote : Push an ifconfig-ipv6 option to\n&qu=
ot;</span><br><span>     &quot;                  remote, overrides --ifconf=
ig-ipv6-pool allocation.\n&quot;</span><br><span>     &quot;               =
   Only valid in a client-specific config file.\n&quot;</span><br><span>   =
  &quot;--iroute network [netmask] : Route subnet to client.\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;                =
  network netmask can also be specified as network/bits.\n&quot;</span><br>=
<span>     &quot;--iroute-ipv6 network/bits : Route IPv6 subnet to client.\=
n&quot;</span><br><span>     &quot;                  Sets up internal route=
s only.\n&quot;</span><br><span>     &quot;                  Only valid in =
a client-specific config file.\n&quot;</span><br><span>@@ -5365,6 +5373,28 =
@@</span><br><span>     return true;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ipv4_cidr_parms_checked(char =
*p[], int network_idx, int max_idx, char *normalized[],</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        const char *cid=
r_label, const msglvl_t msglevel, struct gc_arena *gc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const int res =3D convert_ipv4_cidr_parms(p, network_i=
dx, max_idx, normalized, gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (res &lt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(msglevel, &quot;%s parameter %s &#39;%s&#39; has invalid CIDR notat=
ion&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   p[0], cidr_label, p[network_idx]);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (res =
=3D=3D 1 &amp;&amp; p[max_idx])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(msglevel, &quot;%s parameter has too many arguments when using CI=
DR %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     p[0], cidr_label);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> update_o=
ption(struct context *c, struct options *options, char *p[], bool is_inline=
,</span><br><span>               const char *file, int line, const int leve=
l, const msglvl_t msglevel,</span><br><span>@@ -5378,8 +5408,15 @@</span><b=
r><span>     {</span><br><span>         if (!(options-&gt;push_update_optio=
ns_found &amp; OPT_P_U_ROUTE))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            char *route_parms[MAX_PAR=
MS + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>             VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (!check_route_option(=
options, p, msglevel, pull_mode))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (!ipv4_cidr_parms_checked(p, 1, 4, route_parms=
, &quot;network/IP&quot;, msglevel, &amp;options-&gt;gc))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (!check_route_option(options, route_parms, ms=
glevel, pull_mode))</span><br><span>             {</span><br><span>        =
         goto err;</span><br><span>             }</span><br><span>@@ -5899,=
18 +5936,32 @@</span><br><span>         iproute_path =3D p[1];</span><br><s=
pan>     }</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    else if (streq(p[0], &quot;ifconfig&quot;) &amp;&amp; p[1]=
 &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else if (streq(p[0], &quot;ifconfig&quot;) &amp;&amp; p[=
1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        char *ifconfig_parms[MAX_PARMS + 1] =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>         VERIFY_PERMISSION(OPT_P_UP);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (ip_or_dns_addr_safe(p[1], options-&gt;allow_pu=
ll_fqdn)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &=
amp;&amp; ip_or_dns_addr_safe(p[2], options-&gt;allow_pull_fqdn)) /* FQDN -=
- may be DNS name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!ipv4_cidr_parms_checked(p, 1, 2, ifconfig_parms, &quot;local/=
IP&quot;, msglevel, &amp;options-&gt;gc))</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;ifco=
nfig_local =3D p[1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           options-&gt;ifconfig_remote_netmask =3D p[2];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (!ifconfig_parms[2])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--ifconfig r=
equires &#39;local remote/netmask&#39; or &#39;local/bits&#39;&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (ip_or_dns_addr_safe(ifconfig_parms[1], =
options-&gt;allow_pull_fqdn)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &amp;&amp; ip_or_dns_addr_safe(ifconfig_parms[2],</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
           options-&gt;allow_pull_fqdn)) /* FQDN -- may be DNS name */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;ifconfig_l=
ocal =3D ifconfig_parms[1];</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            options-&gt;ifconfig_remote_netmask =3D ifconfig_parms[=
2];</span><br><span>         }</span><br><span>         else</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   msg(msglevel, &quot;ifconfig parms &#39;%s&#39; and &#39;%s&#39; must be=
 valid addresses&quot;, p[1], p[2]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            msg(msglevel, &quot;ifconfig parms &#39;%s&#39=
; and &#39;%s&#39; must be valid addresses&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                ifconfig_parms[1], ifconfig_p=
arms[2]);</span><br><span>             goto err;</span><br><span>         }=
</span><br><span>     }</span><br><span>@@ -6804,11 +6855,24 @@</span><br><=
span>         VERIFY_PERMISSION(OPT_P_PERSIST_IP);</span><br><span>        =
 options-&gt;persist_remote_ip =3D true;</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;cl=
ient-nat&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; =
p[4] &amp;&amp; !p[5])</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else if (streq(p[0], &quot;client-nat&quot;) &amp;&amp; p[1] &amp;&a=
mp; p[2] &amp;&amp; !p[5])</span><br><span>     {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        char *client_nat_parms[MAX_PARMS + 1]=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>         VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (!ipv4_cidr_parms_checked(p, 2, 4,=
 client_nat_parms, &quot;network/IP&quot;, msglevel, &amp;options-&gt;gc))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (!client_nat_parms[3] || !c=
lient_nat_parms[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(msglevel, &quot;--client-nat requires &#39;snat|dnat network netmask =
alias&#39; or &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                          &quot;&#39;snat|dnat network/bits alias&#39;&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            got=
o err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span>         cnol_check_alloc(options);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        add_client_nat_to_option_list(options-&g=
t;client_nat, p[1], p[2], p[3], p[4], msglevel);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        add_client_nat_to_option_list(options-=
&gt;client_nat, client_nat_parms[1], client_nat_parms[2],</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
 client_nat_parms[3], client_nat_parms[4], msglevel);</span><br><span>     =
}</span><br><span>     else if (streq(p[0], &quot;route-table&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>@@ -6821=
,11 +6885,19 @@</span><br><span>     else if (streq(p[0], &quot;route&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[5])</span><br><span>     {</span><br><span>=
         VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (!check_route_option(options, p, msglevel, pu=
ll_mode))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        char *route_parms[MAX=
_PARMS + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!ipv4_cidr_parms_checked(p, 1, 4, route_parms, &quot;network=
/IP&quot;, msglevel, &amp;options-&gt;gc))</span><br><span>         {</span=
><br><span>             goto err;</span><br><span>         }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        add_route_to_option_list(opt=
ions-&gt;routes, p[1], p[2], p[3], p[4],</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!check_route_option(options, route_parms, msglevel, pull_mode=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        add_route_to_option_list(op=
tions-&gt;routes, route_parms[1], route_parms[2], route_parms[3],</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
    route_parms[4],</span><br><span>                                  optio=
ns-&gt;route_default_table_id);</span><br><span>     }</span><br><span>    =
 else if (streq(p[0], &quot;route-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; !p=
[4])</span><br><span>@@ -7145,15 +7217,26 @@</span><br><span>         VERIF=
Y_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-&gt;occ =3D f=
alse;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else if (streq(p[0], &quot;server&quot;) &amp;&amp; p[1] &amp;&a=
mp; p[2] &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else if (streq(p[0], &quot;server&quot;) &amp;&amp; p[1] &amp;&a=
mp; !p[4])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        const int lev =3D M_WARN;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        const msglvl_t lev =3D M_WARN;</span><br>=
<span>         bool error =3D false;</span><br><span>         in_addr_t net=
work, netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   char *server_parms[MAX_PARMS + 1] =3D { 0 };</span><br><span> </span><br=
><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        network =3D get_ip_addr(p[1], lev, &amp=
;error);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        netma=
sk =3D get_ip_addr(p[2], lev, &amp;error);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!ipv4_cidr_parms_checked(p, 1, 3, server=
_parms, &quot;network/IP&quot;, msglevel, &amp;options-&gt;gc))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!server_parms[2])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--server requires=
 &#39;network netmask [nopool]&#39; or &#39;network/bits [nopool]&#39;&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto=
 err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        network =3D get_ip_addr(server_pa=
rms[1], lev, &amp;error);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        netmask =3D get_ip_addr(server_parms[2], lev, &amp;error);</s=
pan><br><span>         if (error || !network || !netmask)</span><br><span> =
        {</span><br><span>             msg(msglevel, &quot;error parsing --=
server parameters&quot;);</span><br><span>@@ -7163,22 +7246,23 @@</span><br=
><span>         options-&gt;server_network =3D network;</span><br><span>   =
      options-&gt;server_netmask =3D netmask;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (p[3])</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (server_parms[3])</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           if (streq(p[3], &quot;nopool&quot;))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (streq(server_parms[3], &quot;no=
pool&quot;))</span><br><span>             {</span><br><span>               =
  options-&gt;server_flags |=3D SF_NOPOOL;</span><br><span>             }</=
span><br><span>             else</span><br><span>             {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                msg(msglevel, &qu=
ot;error parsing --server: %s is not a recognized flag&quot;, p[3]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(msglev=
el, &quot;error parsing --server: %s is not a recognized flag&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    server=
_parms[3]);</span><br><span>                 goto err;</span><br><span>    =
         }</span><br><span>         }</span><br><span>     }</span><br><spa=
n>     else if (streq(p[0], &quot;server-ipv6&quot;) &amp;&amp; p[1] &amp;&=
amp; !p[2])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        const int lev =3D M_WARN;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const msglvl_t lev =3D M_WARN;</span><br=
><span>         struct in6_addr network;</span><br><span>         unsigned =
int netbits =3D 0;</span><br><span> </span><br><span>@@ -7199,17 +7283,29 @=
@</span><br><span>         options-&gt;server_network_ipv6 =3D network;</sp=
an><br><span>         options-&gt;server_netbits_ipv6 =3D netbits;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e if (streq(p[0], &quot;server-bridge&quot;) &amp;&amp; p[1] &amp;&amp; p[2=
] &amp;&amp; p[3] &amp;&amp; p[4] &amp;&amp; !p[5])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;server-bri=
dge&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[5]=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        const int lev =3D M_WARN;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        const msglvl_t lev =3D M_WARN;</span><br><span>   =
      bool error =3D false;</span><br><span>         in_addr_t ip, netmask,=
 pool_start, pool_end;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        char *server_bridge_parms[MAX_PARMS + 1] =3D { 0 };</span><br><s=
pan> </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ip =3D get_ip_addr(p[1],=
 lev, &amp;error);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     netmask =3D get_ip_addr(p[2], lev, &amp;error);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        pool_start =3D get_ip_addr(p[3], le=
v, &amp;error);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  pool_end =3D get_ip_addr(p[4], lev, &amp;error);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!ipv4_cidr_parms_checked(p, 1, 4=
, server_bridge_parms, &quot;gateway/IP&quot;, msglevel, &amp;options-&gt;g=
c))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (!server_bridge_parms[4=
])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &=
quot;--server-bridge requires &#39;gateway netmask pool-start-IP pool-end-I=
P&#39; &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                    &quot;or &#39;gateway/bits pool-start-IP pool-end-IP&#3=
9;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        ip =3D get_ip_addr(server_br=
idge_parms[1], lev, &amp;error);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        netmask =3D get_ip_addr(server_bridge_parms[2], lev, &=
amp;error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
pool_start =3D get_ip_addr(server_bridge_parms[3], lev, &amp;error);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        pool_end =3D get_i=
p_addr(server_bridge_parms[4], lev, &amp;error);</span><br><span>         i=
f (error || !ip || !netmask || !pool_start || !pool_end)</span><br><span>  =
       {</span><br><span>             msg(msglevel, &quot;error parsing --s=
erver-bridge parameters&quot;);</span><br><span>@@ -7250,7 +7346,7 @@</span=
><br><span>     }</span><br><span>     else if (streq(p[0], &quot;ifconfig-=
pool&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cons=
t int lev =3D M_WARN;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        const msglvl_t lev =3D M_WARN;</span><br><span>         bool erro=
r =3D false;</span><br><span>         in_addr_t start, end, netmask =3D 0;<=
/span><br><span> </span><br><span>@@ -7290,7 +7386,7 @@</span><br><span>   =
  }</span><br><span>     else if (streq(p[0], &quot;ifconfig-ipv6-pool&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        const int lev =3D M_WARN;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        const msglvl_t =
lev =3D M_WARN;</span><br><span>         struct in6_addr network;</span><br=
><span>         unsigned int netbits =3D 0;</span><br><span> </span><br><sp=
an>@@ -7556,30 +7652,51 @@</span><br><span>     }</span><br><span>     else=
 if (streq(p[0], &quot;iroute&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       char *iroute_parms[MAX_PARMS + 1] =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         VERIFY_PERMISSI=
ON(OPT_P_INSTANCE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      option_iroute(options, p[1], p[2], msglevel);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!ipv4_cidr_parms_checked(p, 1=
, 2, iroute_parms, &quot;network/IP&quot;, msglevel, &amp;options-&gt;gc))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        option_iroute(options, iroute_=
parms[1], iroute_parms[2], msglevel);</span><br><span>     }</span><br><spa=
n>     else if (streq(p[0], &quot;iroute-ipv6&quot;) &amp;&amp; p[1] &amp;&=
amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSI=
ON(OPT_P_INSTANCE);</span><br><span>         option_iroute_ipv6(options, p[=
1], msglevel);</span><br><span>     }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else if (streq(p[0], &quot;ifconfig-push&quot;) &amp;&a=
mp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;ifconfig-push&quot;) =
&amp;&amp; p[1] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>  =
       in_addr_t local, remote_netmask;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        char *ifconfig_push_parms[MAX_PARMS + 1] =3D { =
0 };</span><br><span> </span><br><span>         VERIFY_PERMISSION(OPT_P_INS=
TANCE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        local =
=3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[1], 0, NULL, NULL);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        remote_netmask =
=3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2], 0, NULL, NULL);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ipv4_cidr_=
parms_checked(p, 1, 3, ifconfig_push_parms, &quot;local/IP&quot;, msglevel,=
 &amp;options-&gt;gc))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!if=
config_push_parms[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(msglevel, &quot;--ifconfig-push requires &#39;local remote-netmask =
[alias]&#39; or &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                          &quot;&#39;local/bits [alias]&#39;&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        local =3D getaddr(GETADDR_HOST_ORDER | GET=
ADDR_RESOLVE, ifconfig_push_parms[1], 0, NULL,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        NULL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        remote_netmask =3D getaddr(GE=
TADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig_push_parms[2], 0,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
 NULL, NULL);</span><br><span>         if (local &amp;&amp; remote_netmask)=
</span><br><span>         {</span><br><span>             options-&gt;push_i=
fconfig_defined =3D true;</span><br><span>             options-&gt;push_ifc=
onfig_local =3D local;</span><br><span>             options-&gt;push_ifconf=
ig_remote_netmask =3D remote_netmask;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (p[3])</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (ifconfig_push_parms[3])</span><br><span> =
            {</span><br><span>                 options-&gt;push_ifconfig_lo=
cal_alias =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[3], 0, NULL, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig_push_parms[3], =
0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
           NULL, NULL);</span><br><span>             }</span><br><span>    =
     }</span><br><span>         else</span><br><span>@@ -7588,13 +7705,26 @=
@</span><br><span>             goto err;</span><br><span>         }</span><=
br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    el=
se if (streq(p[0], &quot;ifconfig-push-constraint&quot;) &amp;&amp; p[1] &a=
mp;&amp; p[2] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (streq(p[0], &quot;ifconfig-push-constraint&quot;) =
&amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>  =
       in_addr_t network, netmask;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        char *ifconfig_push_constraint_parms[MAX_PARMS + 1] =
=3D { 0 };</span><br><span> </span><br><span>         VERIFY_PERMISSION(OPT=
_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        n=
etwork =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[1], 0, NULL, NUL=
L);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        netmask =
=3D getaddr(GETADDR_HOST_ORDER, p[2], 0, NULL, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!ipv4_cidr_parms_checked(p, 1=
, 2, ifconfig_push_constraint_parms, &quot;network/IP&quot;, msglevel,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
             &amp;options-&gt;gc))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (!ifconfig_push_constraint_parms[2])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(msglevel, &quot;--ifconfig-push-constraint r=
equires &#39;network netmask&#39; or &#39;network/bits&#39;&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        network =3D getaddr(GETADDR_HOST_ORDER | GETAD=
DR_RESOLVE, ifconfig_push_constraint_parms[1],</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                          0, NULL, NULL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        netmask =3D getadd=
r(GETADDR_HOST_ORDER, ifconfig_push_constraint_parms[2], 0, NULL, NULL);</s=
pan><br><span>         if (network &amp;&amp; netmask)</span><br><span>    =
     {</span><br><span>             options-&gt;push_ifconfig_constraint_de=
fined =3D true;</span><br><span>diff --git a/src/openvpn/options_util.c b/s=
rc/openvpn/options_util.c</span><br><span>index 8d0a143..3d8938c 100644</sp=
an><br><span>--- a/src/openvpn/options_util.c</span><br><span>+++ b/src/ope=
nvpn/options_util.c</span><br><span>@@ -30,6 +30,7 @@</span><br><span> #inc=
lude &quot;options_util.h&quot;</span><br><span> </span><br><span> #include=
 &quot;push.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;socket_util.h&quot;</span><br><span> </span><br><span> const=
 char *</span><br><span> parse_auth_failed_temp(struct options *o, const ch=
ar *reason)</span><br><span>@@ -193,6 +194,96 @@</span><br><span>     retur=
n true;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ipv4_cidr_to_netmask(const char *in_cidr, const char *slash=
, const char **out_network,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                     const char **out_netmask, struct gc_arena *gc)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(in_cidr);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(slash);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ASSERT(slash[0] =3D=3D &#39;/&#39=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (slash[1] =3D=3D &#39;\0&#39=
;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* extract and validate the prefix value */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *prefix_str =3D s=
lash + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (st=
rspn(prefix_str, &quot;0123456789&quot;) !=3D strlen(prefix_str))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    errno =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    char *endptr =3D NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const unsigned long prefix =3D strtoul(prefix_str, &amp;endptr=
, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (errno=
 !=3D 0 || endptr =3D=3D prefix_str || *endptr !=3D &#39;\0&#39; || prefix =
&gt; 32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const size_t slash_offset =3D (size_t)(slash - in_=
cidr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (slash=
_offset =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -=
EINVAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* build the network string */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    char *network_buf =3D gc_m=
alloc(slash_offset + 1, true, gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    memcpy(network_buf, in_cidr, slash_offset);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    network_buf[slash_offset] =
=3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* build the netm=
ask string */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *netmask_buf =3D print_in_addr_t(netbits_to_netmask((int)prefix), =
0, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    *out_network =3D network_bu=
f;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *out_netmask =
=3D netmask_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+conver=
t_ipv4_cidr_parms(char *p[], int network_idx, int max_idx, char *normalized=
[],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSER=
T(max_idx &lt; MAX_PARMS);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ASSERT(max_idx &gt;=3D (network_idx + 1));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(network_idx &gt;=3D 1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(p[network_idx])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* map normalized parameters to t=
he user provided ones */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for (int i =3D 0; i &lt;=3D max_idx &amp;&amp; p[i]; ++i)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        normalized[i] =3D p[i];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *slash =3D strchr(p[network_idx], &#39;/&#39;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!slash)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const char *network =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *netmask =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const int err =3D ipv4_cidr_to_netmas=
k(p[network_idx], slash, &amp;network, &amp;netmask, gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return err;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* insert th=
e netmask and shift the next parameters */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    normalized[network_idx] =3D (char *)network;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    normalized[network_=
idx + 1] =3D (char *)netmask;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int src =3D network_idx + 1, dst =3D network_idx + 2; ds=
t &lt;=3D max_idx; ++src, ++dst)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       normalized[dst] =3D p[src];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* keep argv-style null termination to avoid stale tail entries */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    normalized[max_idx =
+ 1] =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> static const char *updatable_o=
ptions[] =3D { &quot;block-ipv6&quot;, &quot;block-outside-dns&quot;,</span=
><br><span>                                            &quot;dhcp-option&qu=
ot;, &quot;dns&quot;,</span><br><span>                                     =
       &quot;ifconfig&quot;, &quot;ifconfig-ipv6&quot;,</span><br><span>dif=
f --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h</span><br=
><span>index 511d189..4c6ea3a 100644</span><br><span>--- a/src/openvpn/opti=
ons_util.h</span><br><span>+++ b/src/openvpn/options_util.h</span><br><span=
>@@ -108,4 +108,37 @@</span><br><span>  */</span><br><span> bool check_push=
_update_option_flags(char *line, int *i, unsigned int *flags);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Convert option parameters w=
hose first IPv4 parameter may be in CIDR notation.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * The input tokens are read from \p p and the normalized out=
put tokens are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * wr=
itten to \p normalized.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * When \p p[=
network_idx] is in CIDR form (for example, ``10.8.0.0/24``), this</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * function:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * - splits the network and prefix l=
ength,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - converts=
 the prefix length to dotted-quad netmask,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * - writes ``network`` and ``netmask`` into ``norma=
lized[network_idx]`` and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *   ``normalized[network_idx + 1]``,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * - shifts remaining parameters one position to pre=
serve legacy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   ``=
network netmask ...`` layout.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * When=
 \p p[network_idx] is not CIDR, \p normalized receives \p p unchanged</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * for the copied range (=
indices ``0..max_idx`` until ``NULL``), and no</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * conversion is applied.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param p Input option tokens (argv-style, NULL-terminat=
ed).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param netwo=
rk_idx Index in \p p of the parameter that may contain CIDR.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param max_idx Maximum paramete=
r index to normalize.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param normalized Output token array receiving normalized parameters</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                   =
(argv-style, NULL-terminated in CIDR case).</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param gc GC arena used for converted string all=
ocations.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return 0 when no CIDR n=
otation was present and no conversion was needed.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return 1 when CIDR notation was present a=
nd conversion was applied.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return -EINVAL on malformed CIDR input.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int convert_ipv4_cidr_parms(char *p[], int network_idx, int =
max_idx,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                 char *normalized[], struct gc_arena *gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef O=
PTIONS_UTIL_H_ */</span><br><span>diff --git a/tests/unit_tests/openvpn/Mak=
efile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>index 1128e=
b4..e277d40 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile.=
am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><sp=
an>@@ -98,10 +98,11 @@</span><br><span> ssl_testdriver_CFLAGS  =3D \</span>=
<br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcd=
ir)/src/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OP=
TIONAL_CRYPTO_LIBS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS) $(SOCKET=
S_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D test_ssl.c \</span><br>=
<span> 	mock_msg.c mock_msg.h test_common.h \</span><br><span> 	mock_manage=
ment.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_signa=
l.c \</span><br><span> 	mock_ssl_dependencies.c mock_win32_execve.c \</span=
><br><span> 	$(top_srcdir)/src/openvpn/argv.c \</span><br><span> 	$(top_src=
dir)/src/openvpn/base64.c \</span><br><span>@@ -121,6 +122,7 @@</span><br><=
span> 	$(top_srcdir)/src/openvpn/packet_id.c \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/platform.c \</span><br><span> 	$(top_srcdir)/src/openvpn/ru=
n_command.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top=
_srcdir)/src/openvpn/socket_util.c \</span><br><span> 	$(top_srcdir)/src/op=
envpn/ssl_openssl.c \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_mbedt=
ls.c \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util.c \</span><br><=
span>@@ -221,13 +223,18 @@</span><br><span> endif</span><br><span> </span><=
br><span> options_parse_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn =
-I$(top_srcdir)/src/compat @TEST_CFLAGS@</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-options_parse_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(=
top_srcdir)/src/openvpn</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+options_parse_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src=
/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(SOCKET=
S_LIBS)</span><br><span> options_parse_testdriver_SOURCES =3D test_options_=
parse.c \</span><br><span> 	mock_msg.c mock_msg.h test_common.h \</span><br=
><span> 	mock_get_random.c \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	mock_management.c \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	mock_setenv.c \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	mock_signal.c \</span><br><span> 	$(top_srcdir)/src/openvpn/options=
_parse.c \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util.c \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/socket_util.c =
\</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/platform.c</span><br><span> </span><br><span>=
@@ -365,12 +372,16 @@</span><br><span> 	-I$(top_srcdir)/include -I$(top_src=
dir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	-DSOURCEDIR=
=3D\&quot;$(top_srcdir)\&quot; @TEST_CFLAGS@</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-misc_testdriver_LDFLAGS =3D @TEST_=
LDFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+misc_testdr=
iver_LDFLAGS =3D @TEST_LDFLAGS@ $(SOCKETS_LIBS)</span><br><span> </span><br=
><span> misc_testdriver_SOURCES =3D test_misc.c \</span><br><span> 	mock_ms=
g.c test_common.h  \</span><br><span> 	mock_get_random.c \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	mock_management.c \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	mock_setenv.c \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	mock_signal.c \</span><br><span> 	$(t=
op_srcdir)/src/openvpn/buffer.c \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(top_srcdir)/src/openvpn/socket_util.c \</span><br><span> 	=
$(top_srcdir)/src/openvpn/options_util.c \</span><br><span> 	$(top_srcdir)/=
src/openvpn/ssl_util.c \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-=
util.c \</span><br><span>@@ -384,15 +395,20 @@</span><br><span> </span><br>=
<span> push_update_msg_testdriver_LDFLAGS =3D \</span><br><span> 	@TEST_LDF=
LAGS@ \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-L$(top_srcdi=
r)/src/openvpn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-L$(=
top_srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	$(SOCKETS_LIBS)</span><br><span> </span><br><span> push_update_msg_t=
estdriver_SOURCES =3D test_push_update_msg.c \</span><br><span> 	mock_msg.c=
 \</span><br><span> 	mock_get_random.c \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	mock_management.c \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	mock_setenv.c \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	mock_signal.c \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/platform.c \</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/options_util.c \</span><br><span>=
 	$(top_srcdir)/src/openvpn/otime.c \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	$(top_srcdir)/src/openvpn/socket_util.c \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/list.c</span><br><span> </span><br><span> soc=
ket_testdriver_CFLAGS  =3D \</span><br><span>diff --git a/tests/unit_tests/=
openvpn/mock_setenv.c b/tests/unit_tests/openvpn/mock_setenv.c</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000..a35a295</span><br><=
span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/mock_sete=
nv.c</span><br><span>@@ -0,0 +1,39 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP =
port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             session authentication and key exchange,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
encryption, packet authentication, and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet compression.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@...1699...=
.&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwa=
re; you can redistribute it and/or modify</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Lice=
nse version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as=
 published by the Free Software Foundation.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is distributed in the hope that it will be useful,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY =
WARRANTY; without even the implied warranty of</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  GNU General Public License for more details.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  You should have received a copy of the GNU General Public Lic=
ense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with =
this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;config.h&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;syshead.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;env_=
set.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+setenv_str(struct env_set *es, const char=
 *name, const char *value)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+setenv_int(struct env_set *es, const char *name, int value)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit=
_tests/openvpn/mock_signal.c b/tests/unit_tests/openvpn/mock_signal.c</span=
><br><span>new file mode 100644</span><br><span>index 0000000..4d27541</spa=
n><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/mo=
ck_signal.c</span><br><span>@@ -0,0 +1,47 @@</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sing=
le UDP port, with support for SSL/TLS-based</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             session authentication and key excha=
nge,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
packet encryption, packet authentication, and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             packet compression.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@...220...=
..515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free=
 software; you can redistribute it and/or modify</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publ=
ic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  as published by the Free Software Foundation.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  GNU General Public License for more details.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;config.h&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;syshead.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;socket.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct signal_info si=
ginfo_static; /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+signal_reset(struct signal_i=
nfo *si, int signum)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return signum=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+struct win32_signal win32_signal; /* GLOBAL */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+win32_signal_get(struct win32_signal *ws)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests=
/unit_tests/openvpn/test_options_parse.c</span><br><span>index 0b3d7fe..bab=
afde 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_options_par=
se.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_options_parse.c</s=
pan><br><span>@@ -34,6 +34,7 @@</span><br><span> #include &lt;cmocka.h&gt;<=
/span><br><span> </span><br><span> #include &quot;options.h&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util.h=
&quot;</span><br><span> #include &quot;test_common.h&quot;</span><br><span>=
 #include &quot;mock_msg.h&quot;</span><br><span> </span><br><span>@@ -249,=
20 +250,9 @@</span><br><span>     gc_init(&amp;o.gc);</span><br><span>     =
gc_init(&amp;o.dns_options.gc);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    char *p_expect_someopt[MAX_PARMS];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    char *p_expect_otheropt[MA=
X_PARMS];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *p_=
expect_inlineopt[MAX_PARMS];</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    CLEAR(p_expect_someopt);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    CLEAR(p_expect_otheropt);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    CLEAR(p_expect_inlineopt);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    p_expect_someopt[0] =3D &quot;someopt&q=
uot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p_expect_som=
eopt[1] =3D &quot;parm1&quot;;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    p_expect_someopt[2] =3D &quot;parm2&quot;;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    p_expect_otheropt[0] =3D &quot;othero=
pt&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p_expect=
_otheropt[1] =3D &quot;1&quot;;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    p_expect_otheropt[2] =3D &quot;2&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    p_expect_inlineopt[0] =3D &quot;inlineo=
pt&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p_expect=
_inlineopt[1] =3D &quot;some text\nother text\n&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    char *p_expect_someopt[MAX_PARMS] =
=3D { &quot;someopt&quot;, &quot;parm1&quot;, &quot;parm2&quot;, NULL };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *p_expect_oth=
eropt[MAX_PARMS] =3D { &quot;otheropt&quot;, &quot;1&quot;, &quot;2&quot;, =
NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *p_=
expect_inlineopt[MAX_PARMS] =3D { &quot;inlineopt&quot;, &quot;some text\no=
ther text\n&quot;, NULL };</span><br><span> </span><br><span>     /* basic =
test */</span><br><span>     expect_function_call(add_option);</span><br><s=
pan>@@ -299,12 +289,209 @@</span><br><span>     gc_free(&amp;o.dns_options.=
gc);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+assert_tokens(char *actual[], const char *expected[], int max=
_idx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt;=3D =
max_idx + 1; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!exp=
ected[i])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            assert_n=
ull(actual[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asse=
rt_non_null(actual[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        assert_string_equal(actual[i], expected[i]);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+test_convert_ipv4_cidr=
_parms_core(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    char *normalized[MAX_PARMS + 1] =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* non-CIDR input is returned unchanged */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    char *legacy[MAX_PARMS + 1] =
=3D { &quot;route&quot;, &quot;10.8.0.0&quot;, &quot;255.255.255.0&quot;, N=
ULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *legacy_expected[] =3D { &quot;route&quot;, &quot;10.8.0.0&quot;, &quot;2=
55.255.255.0&quot;, NULL, NULL, NULL };</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(convert_ipv4_cidr_parms(legacy, 1,=
 4, normalized, &amp;gc), 0);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_tokens(normalized, legacy_expected, 4);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* CIDR input is split and netmask is materialize=
d */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(norma=
lized);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ci=
dr[MAX_PARMS + 1] =3D { &quot;route&quot;, &quot;10.8.0.0/24&quot;, NULL };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *cid=
r_expected[] =3D { &quot;route&quot;, &quot;10.8.0.0&quot;, &quot;255.255.2=
55.0&quot;, NULL, NULL, NULL };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(convert_ipv4_cidr_parms(cidr, 1, 4, normal=
ized, &amp;gc), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_tokens(normalized, cidr_expected, 4);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_convert_ipv4_cidr_parms_cove=
rage(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  char *normalized[MAX_PARMS + 1] =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* success paths */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ro=
ute */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *rou=
te[] =3D { &quot;route&quot;, &quot;10.1.2.0/24&quot;, &quot;192.0.2.1&quot=
;, &quot;7&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *route_expected[] =3D { &quot;route&quot;, &quot;10.1.=
2.0&quot;, &quot;255.255.255.0&quot;, &quot;192.0.2.1&quot;, &quot;7&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                  NULL };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(convert_ipv4_cidr_parms(route, 1, 4, normalized,=
 &amp;gc), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_tokens(normalized, route_expected, 4);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* ifconfig */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CLEAR(normalized);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    char *ifconfig[] =3D { &quot;ifconfig&quot;, &quot;10.8.0.1/24&=
quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *ifconfig_expected[] =3D { &quot;ifconfig&quot;, &quot;10.8.0.1&q=
uot;, &quot;255.255.255.0&quot;, NULL };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(convert_ipv4_cidr_parms(ifconfig,=
 1, 2, normalized, &amp;gc), 1);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_tokens(normalized, ifconfig_expected, 2);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* server */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    CLEAR(normalized);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    char *server[] =3D { &quot;server&quot;, &qu=
ot;10.8.0.0/24&quot;, &quot;nopool&quot;, NULL };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const char *server_expected[] =3D { &quot=
;server&quot;, &quot;10.8.0.0&quot;, &quot;255.255.255.0&quot;, &quot;nopoo=
l&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(convert_ipv4_cidr_parms(server, 1, 3, normalized, &amp;gc=
), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_to=
kens(normalized, server_expected, 3);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* server-bridge */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    CLEAR(normalized);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    char *server_bridge[] =3D { &quot;server-bridge&quot;, &quot;10.8=
.0.1/24&quot;, &quot;10.8.0.10&quot;, &quot;10.8.0.20&quot;, NULL };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *server_bri=
dge_expected[] =3D { &quot;server-bridge&quot;, &quot;10.8.0.1&quot;, &quot=
;255.255.255.0&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                             &quot;10.8.0.10&quot;, &quot=
;10.8.0.20&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(convert_ipv4_cidr_parms(server_bridge, 1, 4, nor=
malized, &amp;gc), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_tokens(normalized, server_bridge_expected, 4);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* iroute */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    CLEAR(normalized);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    char *iroute[] =3D { &quot;iroute&quot;, &quot;17=
2.16.0.0/16&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *iroute_expected[] =3D { &quot;iroute&quot;, &quot;17=
2.16.0.0&quot;, &quot;255.255.0.0&quot;, NULL };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(convert_ipv4_cidr_parms(i=
route, 1, 2, normalized, &amp;gc), 1);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_tokens(normalized, iroute_expected, 2);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* ifconfig-push */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    CLEAR(normalized);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    char *ifconfig_push[] =3D { &quot=
;ifconfig-push&quot;, &quot;10.8.0.6/24&quot;, &quot;10.8.0.7&quot;, NULL }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *if=
config_push_expected[] =3D { &quot;ifconfig-push&quot;, &quot;10.8.0.6&quot=
;, &quot;255.255.255.0&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                             &quot;10.8.0.7&quot;=
, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(convert_ipv4_cidr_parms(ifconfig_push, 1, 3, normalized, &amp;gc=
), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_to=
kens(normalized, ifconfig_push_expected, 3);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* ifconfig-push-constraint */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    CLEAR(normalized);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    char *ifconfig_push_constraint[] =3D { &quot;if=
config-push-constraint&quot;, &quot;10.8.0.0/24&quot;, NULL };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const char *ifconfig_push_co=
nstraint_expected[] =3D { &quot;ifconfig-push-constraint&quot;, &quot;10.8.=
0.0&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                               &quot;255.255.255.0&quot;, N=
ULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(convert_ipv4_cidr_parms(ifconfig_push_constraint, 1, 2, normalized,=
 &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
            1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_tokens(normalized, ifconfig_push_constraint_expected, 2);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* client-nat */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    CLEAR(normalized);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char *client_nat[] =3D { &quot;client-nat=
&quot;, &quot;snat&quot;, &quot;192.168.0.0/16&quot;, &quot;10.0.0.0&quot;,=
 NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *client_nat_expected[] =3D { &quot;client-nat&quot;, &quot;snat&quot;, =
&quot;192.168.0.0&quot;, &quot;255.255.0.0&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                          &qu=
ot;10.0.0.0&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(convert_ipv4_cidr_parms(client_nat, 2, 4, norma=
lized, &amp;gc), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_tokens(normalized, client_nat_expected, 4);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* CIDR prefix boundaries */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* /0 */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    CLEAR(normalized);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    char *route_default[MAX_PARMS + 1] =3D { &quot;route&quot;, &quo=
t;0.0.0.0/0&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *route_default_expected[] =3D { &quot;route&quot;, &q=
uot;0.0.0.0&quot;, &quot;0.0.0.0&quot;, NULL, NULL, NULL };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(convert_ipv4_c=
idr_parms(route_default, 1, 4, normalized, &amp;gc), 1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_tokens(normalized, route_de=
fault_expected, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* /32 */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(normalized);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *route_host[M=
AX_PARMS + 1] =3D { &quot;route&quot;, &quot;198.51.100.42/32&quot;, NULL }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *ro=
ute_host_expected[] =3D { &quot;route&quot;, &quot;198.51.100.42&quot;, &qu=
ot;255.255.255.255&quot;, NULL,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                          NULL, NULL };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(conver=
t_ipv4_cidr_parms(route_host, 1, 4, normalized, &amp;gc), 1);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_tokens(normalized, rou=
te_host_expected, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* CIDR with =
DNS-style network token */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    CLEAR(normalized);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    char *route_dns_cidr[] =3D { &quot;route&quot;, &quot;vpn.exa=
mple/24&quot;, &quot;192.0.2.1&quot;, NULL };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *route_dns_cidr_expected[] =3D { &=
quot;route&quot;, &quot;vpn.example&quot;, &quot;255.255.255.0&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
                     &quot;192.0.2.1&quot;, NULL, NULL };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(convert_ipv4_cid=
r_parms(route_dns_cidr, 1, 4, normalized, &amp;gc), 1);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_tokens(normalized, route_dns=
_cidr_expected, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* non-CIDR pas=
sthrough (DNS-style network token) */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    CLEAR(normalized);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    char *route_dns[] =3D { &quot;route&quot;, &quot;v=
pn.example&quot;, &quot;255.255.255.0&quot;, &quot;192.0.2.1&quot;, NULL };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *rou=
te_dns_expected[] =3D { &quot;route&quot;, &quot;vpn.example&quot;, &quot;2=
55.255.255.0&quot;, &quot;192.0.2.1&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                         NULL, NULL =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(convert_ipv4_cidr_parms(route_dns, 1, 4, normalized, &amp;gc), 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tokens(normal=
ized, route_dns_expected, 4);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* va=
ried network_idx/max_idx shapes */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
CLEAR(normalized);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   char *generic_shift[] =3D { &quot;opt&quot;, &quot;x&quot;, &quot;y&quot=
;, &quot;10.9.0.0/25&quot;, &quot;tail&quot;, NULL };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *generic_shift_expected[] =
=3D { &quot;opt&quot;, &quot;x&quot;, &quot;y&quot;, &quot;10.9.0.0&quot;, =
&quot;255.255.255.128&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                             &quot;tail&quot;, NUL=
L };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(convert_ipv4_cidr_parms(generic_shift, 3, 5, normalized, &amp;gc), 1)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tokens(=
normalized, generic_shift_expected, 5);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    CLEAR(normalized);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    char *near_limit[MAX_PARMS + 1] =3D { 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    near_limit[0] =3D &quot;opt&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    near_limit[MAX_PARMS =
- 2] =3D &quot;203.0.113.0/24&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        convert_ipv4_cidr_parms(near_limit, MAX_PARMS - =
2, MAX_PARMS - 1, normalized, &amp;gc), 1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(normalized[0], &quot;opt&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_str=
ing_equal(normalized[MAX_PARMS - 2], &quot;203.0.113.0&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(normaliz=
ed[MAX_PARMS - 1], &quot;255.255.255.0&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_null(normalized[MAX_PARMS]);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* error paths */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    char *route_invalid[] =3D { &quot;route&quot;, &quot;10.1.2.=
0/33&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(convert_ipv4_cidr_parms(route_invalid, 1, 4, normalize=
d, &amp;gc), -EINVAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    char *route_invalid_negative_prefix[] =3D { &quot;route&quot;, &quot=
;10.1.2.0/-1&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_negative=
_prefix, 1, 4, normalized,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                             &amp;gc),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                     -EINVAL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *route_invali=
d_plus_prefix[] =3D { &quot;route&quot;, &quot;10.1.2.0/+24&quot;, NULL };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(convert_ipv4_cidr_parms(route_invalid_plus_prefix, 1, 4, normalized, &amp;=
gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
      -EINVAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
char *route_invalid_malformed_slash[] =3D { &quot;route&quot;, &quot;10.1.2=
.0//24&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_malformed_slas=
h, 1, 4, normalized,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                             &amp;gc),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                     -EINVAL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    char *route_invalid_over=
flow_prefix[] =3D { &quot;route&quot;, &quot;10.1.2.0/999999999999999999999=
&quot;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(convert_ipv4_cidr_parms(route_invalid_overflow_prefix, 1, =
4, normalized,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                        &amp;gc),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                     -EINVAL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    char *route_invalid_empty_netw=
ork[] =3D { &quot;route&quot;, &quot;/24&quot;, NULL };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(convert_ipv4_cidr_=
parms(route_invalid_empty_network, 1, 4, normalized, &amp;gc),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                     -EINVAL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *route_inval=
id_no_prefix[] =3D { &quot;route&quot;, &quot;10.1.2.0/&quot;, NULL };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(con=
vert_ipv4_cidr_parms(route_invalid_no_prefix, 1, 4, normalized, &amp;gc),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
-EINVAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *=
route_invalid_alpha_prefix[] =3D { &quot;route&quot;, &quot;10.1.2.0/2x&quo=
t;, NULL };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(convert_ipv4_cidr_parms(route_invalid_alpha_prefix, 1, 4, norm=
alized, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                   -EINVAL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *=
client_nat_invalid[] =3D { &quot;client-nat&quot;, &quot;snat&quot;, &quot;=
192.168.0.0/35&quot;, &quot;10.0.0.0&quot;, NULL };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(convert_ipv4_cidr_pa=
rms(client_nat_invalid, 2, 4, normalized, &amp;gc),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     -EINVAL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> int</span><br><span> main(void)</span><br><span=
> {</span><br><span>     const struct CMUnitTest tests[] =3D {</span><br><s=
pan>         cmocka_unit_test(test_parse_line),</span><br><span>         cm=
ocka_unit_test(test_read_config),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        cmocka_unit_test(test_convert_ipv4_cidr_parms_core),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_convert_ipv4_cidr_parms_coverage),</span><br><span>     };</span>=
<br><span> </span><br><span>     return cmocka_run_group_tests_name(&quot;o=
ptions_parse&quot;, tests, NULL, NULL);</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><=
br><span>index 2b73ee7..9182cb8 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_s=
sl.c</span><br><span>@@ -51,8 +51,6 @@</span><br><span> /* Mock function to=
 be allowed to include win32.c which is required for</span><br><span>  * ge=
tting the temp directory */</span><br><span> #ifdef _WIN32</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-struct signal_info siginfo_static; /* =
GLOBAL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> const char *</span><br><span> strerror_win32(DWORD errnum, struct gc_=
arena *gc)</span><br><span> {</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail">cha=
nge 739</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/739?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae04ad8715e40dfc76475c2c5b9=
a766c9604efc9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 739 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
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

--2L4i9zIi0E8=--

