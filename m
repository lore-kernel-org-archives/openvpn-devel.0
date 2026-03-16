From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 16 Mar 2026 13:24:04 +0100
Message-ID: <20260316122404.26975-1-frank@...2641...>
In-Reply-To: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
References: <gerrit.1725894771000.Iae04ad8715e40dfc76475c2c5b9a766c9604efc9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v14] options: add IPv4 CIDR parsing for
 relevant directives
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

From: Ralf Lici <ralf@...2726...>

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
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/739
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/739
This mail reflects revision 14 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
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
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
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
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
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
+  view, so the server will actually push ``ifconfig alias remote/netmask`` to
+  the client.
 
   This option must be associated with a specific client instance, which
   means that it must be specified either in a client instance config file
@@ -328,6 +333,15 @@
   by ``--ifconfig``, OpenVPN will install a /32 host route for the ``local``
   IP address.
 
+--ifconfig-push-constraint args
+  Restrict static IPv4 addresses from ``--ifconfig-push`` to a specific subnet.
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
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
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
+  ``local remote`` form (CIDR form is not applicable). The IP addresses may be
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
   DNS or :code:`/etc/hosts` file resolvable name, or as one of three special
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
     "                  addresses outside of the subnets used by either peer.\n"
     "                  TAP: configure device to use IP address l as a local\n"
     "                  endpoint and rn as a subnet mask.\n"
+    "                  In netmask mode (TAP, or TUN with --topology subnet),\n"
+    "                  l may be specified as l/bits.\n"
     "--ifconfig-ipv6 l r : configure device to use IPv6 address l as local\n"
     "                      endpoint (as a /64) and r as remote endpoint\n"
     "--ifconfig-noexec : Don't actually execute ifconfig/netsh command, instead\n"
@@ -221,6 +223,7 @@
     "--route network [netmask] [gateway] [metric] :\n"
     "                  Add route to routing table after connection\n"
     "                  is established.  Multiple routes can be specified.\n"
+    "                  network netmask can also be specified as network/bits.\n"
     "                  netmask default: 255.255.255.255\n"
     "                  gateway default: taken from --route-gateway or --ifconfig\n"
     "                  Specify default by leaving blank or setting to \"default\".\n"
@@ -259,6 +262,7 @@
     "                   (Server) Instead of forwarding IPv6 packets send\n"
     "                   ICMPv6 host unreachable packets to the client.\n"
     "--client-nat snat|dnat network netmask alias : on client add 1-to-1 NAT rule.\n"
+    "                  network netmask can also be specified as network/bits.\n"
     "--push-peer-info : (client only) push client info to server.\n"
     "--setenv name value : Set a custom environmental variable to pass to script.\n"
     "--setenv FORWARD_COMPATIBLE 1 : Relax config file syntax checking to allow\n"
@@ -425,10 +429,12 @@
     "--vlan-pvid v   : Sets the Port VLAN Identifier. Defaults to 1.\n"
     "\n"
     "Multi-Client Server options (when --mode server is used):\n"
-    "--server network netmask : Helper option to easily configure server mode.\n"
+    "--server network netmask [nopool] : Helper option to easily configure server mode.\n"
+    "                  network netmask can also be specified as network/bits.\n"
     "--server-ipv6 network/bits : Configure IPv6 server mode.\n"
     "--server-bridge [IP netmask pool-start-IP pool-end-IP] : Helper option to\n"
     "                    easily configure ethernet bridging server mode.\n"
+    "                    IP netmask can also be specified as IP/bits.\n"
     "--push \"option\" : Push a config file option back to the peer for remote\n"
     "                  execution.  Peer must specify --pull in its config file.\n"
     "--push-reset    : Don't inherit global push list for specific\n"
@@ -442,13 +448,15 @@
     "                  If seconds=0, file will be treated as read-only.\n"
     "--ifconfig-ipv6-pool base-IP/bits : set aside an IPv6 network block\n"
     "                  to be dynamically allocated to connecting clients.\n"
-    "--ifconfig-push local remote-netmask : Push an ifconfig option to remote,\n"
+    "--ifconfig-push local remote-netmask [alias] : Push an ifconfig option to remote,\n"
     "                  overrides --ifconfig-pool dynamic allocation.\n"
+    "                  local remote-netmask can also be specified as local/bits.\n"
     "                  Only valid in a client-specific config file.\n"
     "--ifconfig-ipv6-push local/bits remote : Push an ifconfig-ipv6 option to\n"
     "                  remote, overrides --ifconfig-ipv6-pool allocation.\n"
     "                  Only valid in a client-specific config file.\n"
     "--iroute network [netmask] : Route subnet to client.\n"
+    "                  network netmask can also be specified as network/bits.\n"
     "--iroute-ipv6 network/bits : Route IPv6 subnet to client.\n"
     "                  Sets up internal routes only.\n"
     "                  Only valid in a client-specific config file.\n"
@@ -5365,6 +5373,28 @@
     return true;
 }
 
+static bool
+ipv4_cidr_parms_checked(char *p[], int network_idx, int max_idx, char *normalized[],
+                        const char *cidr_label, const msglvl_t msglevel, struct gc_arena *gc)
+{
+    const int res = convert_ipv4_cidr_parms(p, network_idx, max_idx, normalized, gc);
+    if (res < 0)
+    {
+        msg(msglevel, "%s parameter %s '%s' has invalid CIDR notation",
+            p[0], cidr_label, p[network_idx]);
+        return false;
+    }
+
+    if (res == 1 && p[max_idx])
+    {
+        msg(msglevel, "%s parameter has too many arguments when using CIDR %s",
+            p[0], cidr_label);
+        return false;
+    }
+
+    return true;
+}
+
 void
 update_option(struct context *c, struct options *options, char *p[], bool is_inline,
               const char *file, int line, const int level, const msglvl_t msglevel,
@@ -5378,8 +5408,15 @@
     {
         if (!(options->push_update_options_found & OPT_P_U_ROUTE))
         {
+            char *route_parms[MAX_PARMS + 1] = { 0 };
+
             VERIFY_PERMISSION(OPT_P_ROUTE);
-            if (!check_route_option(options, p, msglevel, pull_mode))
+            if (!ipv4_cidr_parms_checked(p, 1, 4, route_parms, "network/IP", msglevel, &options->gc))
+            {
+                goto err;
+            }
+
+            if (!check_route_option(options, route_parms, msglevel, pull_mode))
             {
                 goto err;
             }
@@ -5899,18 +5936,32 @@
         iproute_path = p[1];
     }
 #endif
-    else if (streq(p[0], "ifconfig") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], "ifconfig") && p[1] && !p[3])
     {
+        char *ifconfig_parms[MAX_PARMS + 1] = { 0 };
+
         VERIFY_PERMISSION(OPT_P_UP);
-        if (ip_or_dns_addr_safe(p[1], options->allow_pull_fqdn)
-            && ip_or_dns_addr_safe(p[2], options->allow_pull_fqdn)) /* FQDN -- may be DNS name */
+        if (!ipv4_cidr_parms_checked(p, 1, 2, ifconfig_parms, "local/IP", msglevel, &options->gc))
         {
-            options->ifconfig_local = p[1];
-            options->ifconfig_remote_netmask = p[2];
+            goto err;
+        }
+        if (!ifconfig_parms[2])
+        {
+            msg(msglevel, "--ifconfig requires 'local remote/netmask' or 'local/bits'");
+            goto err;
+        }
+
+        if (ip_or_dns_addr_safe(ifconfig_parms[1], options->allow_pull_fqdn)
+            && ip_or_dns_addr_safe(ifconfig_parms[2],
+                                   options->allow_pull_fqdn)) /* FQDN -- may be DNS name */
+        {
+            options->ifconfig_local = ifconfig_parms[1];
+            options->ifconfig_remote_netmask = ifconfig_parms[2];
         }
         else
         {
-            msg(msglevel, "ifconfig parms '%s' and '%s' must be valid addresses", p[1], p[2]);
+            msg(msglevel, "ifconfig parms '%s' and '%s' must be valid addresses",
+                ifconfig_parms[1], ifconfig_parms[2]);
             goto err;
         }
     }
@@ -6804,11 +6855,24 @@
         VERIFY_PERMISSION(OPT_P_PERSIST_IP);
         options->persist_remote_ip = true;
     }
-    else if (streq(p[0], "client-nat") && p[1] && p[2] && p[3] && p[4] && !p[5])
+    else if (streq(p[0], "client-nat") && p[1] && p[2] && !p[5])
     {
+        char *client_nat_parms[MAX_PARMS + 1] = { 0 };
+
         VERIFY_PERMISSION(OPT_P_ROUTE);
+        if (!ipv4_cidr_parms_checked(p, 2, 4, client_nat_parms, "network/IP", msglevel, &options->gc))
+        {
+            goto err;
+        }
+        if (!client_nat_parms[3] || !client_nat_parms[4])
+        {
+            msg(msglevel, "--client-nat requires 'snat|dnat network netmask alias' or "
+                          "'snat|dnat network/bits alias'");
+            goto err;
+        }
         cnol_check_alloc(options);
-        add_client_nat_to_option_list(options->client_nat, p[1], p[2], p[3], p[4], msglevel);
+        add_client_nat_to_option_list(options->client_nat, client_nat_parms[1], client_nat_parms[2],
+                                      client_nat_parms[3], client_nat_parms[4], msglevel);
     }
     else if (streq(p[0], "route-table") && p[1] && !p[2])
     {
@@ -6821,11 +6885,19 @@
     else if (streq(p[0], "route") && p[1] && !p[5])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        if (!check_route_option(options, p, msglevel, pull_mode))
+
+        char *route_parms[MAX_PARMS + 1] = { 0 };
+        if (!ipv4_cidr_parms_checked(p, 1, 4, route_parms, "network/IP", msglevel, &options->gc))
         {
             goto err;
         }
-        add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4],
+
+        if (!check_route_option(options, route_parms, msglevel, pull_mode))
+        {
+            goto err;
+        }
+        add_route_to_option_list(options->routes, route_parms[1], route_parms[2], route_parms[3],
+                                 route_parms[4],
                                  options->route_default_table_id);
     }
     else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
@@ -7145,15 +7217,26 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->occ = false;
     }
-    else if (streq(p[0], "server") && p[1] && p[2] && !p[4])
+    else if (streq(p[0], "server") && p[1] && !p[4])
     {
-        const int lev = M_WARN;
+        const msglvl_t lev = M_WARN;
         bool error = false;
         in_addr_t network, netmask;
+        char *server_parms[MAX_PARMS + 1] = { 0 };
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        network = get_ip_addr(p[1], lev, &error);
-        netmask = get_ip_addr(p[2], lev, &error);
+        if (!ipv4_cidr_parms_checked(p, 1, 3, server_parms, "network/IP", msglevel, &options->gc))
+        {
+            goto err;
+        }
+        if (!server_parms[2])
+        {
+            msg(msglevel, "--server requires 'network netmask [nopool]' or 'network/bits [nopool]'");
+            goto err;
+        }
+
+        network = get_ip_addr(server_parms[1], lev, &error);
+        netmask = get_ip_addr(server_parms[2], lev, &error);
         if (error || !network || !netmask)
         {
             msg(msglevel, "error parsing --server parameters");
@@ -7163,22 +7246,23 @@
         options->server_network = network;
         options->server_netmask = netmask;
 
-        if (p[3])
+        if (server_parms[3])
         {
-            if (streq(p[3], "nopool"))
+            if (streq(server_parms[3], "nopool"))
             {
                 options->server_flags |= SF_NOPOOL;
             }
             else
             {
-                msg(msglevel, "error parsing --server: %s is not a recognized flag", p[3]);
+                msg(msglevel, "error parsing --server: %s is not a recognized flag",
+                    server_parms[3]);
                 goto err;
             }
         }
     }
     else if (streq(p[0], "server-ipv6") && p[1] && !p[2])
     {
-        const int lev = M_WARN;
+        const msglvl_t lev = M_WARN;
         struct in6_addr network;
         unsigned int netbits = 0;
 
@@ -7199,17 +7283,29 @@
         options->server_network_ipv6 = network;
         options->server_netbits_ipv6 = netbits;
     }
-    else if (streq(p[0], "server-bridge") && p[1] && p[2] && p[3] && p[4] && !p[5])
+    else if (streq(p[0], "server-bridge") && p[1] && p[2] && p[3] && !p[5])
     {
-        const int lev = M_WARN;
+        const msglvl_t lev = M_WARN;
         bool error = false;
         in_addr_t ip, netmask, pool_start, pool_end;
+        char *server_bridge_parms[MAX_PARMS + 1] = { 0 };
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ip = get_ip_addr(p[1], lev, &error);
-        netmask = get_ip_addr(p[2], lev, &error);
-        pool_start = get_ip_addr(p[3], lev, &error);
-        pool_end = get_ip_addr(p[4], lev, &error);
+        if (!ipv4_cidr_parms_checked(p, 1, 4, server_bridge_parms, "gateway/IP", msglevel, &options->gc))
+        {
+            goto err;
+        }
+        if (!server_bridge_parms[4])
+        {
+            msg(msglevel, "--server-bridge requires 'gateway netmask pool-start-IP pool-end-IP' "
+                          "or 'gateway/bits pool-start-IP pool-end-IP'");
+            goto err;
+        }
+
+        ip = get_ip_addr(server_bridge_parms[1], lev, &error);
+        netmask = get_ip_addr(server_bridge_parms[2], lev, &error);
+        pool_start = get_ip_addr(server_bridge_parms[3], lev, &error);
+        pool_end = get_ip_addr(server_bridge_parms[4], lev, &error);
         if (error || !ip || !netmask || !pool_start || !pool_end)
         {
             msg(msglevel, "error parsing --server-bridge parameters");
@@ -7250,7 +7346,7 @@
     }
     else if (streq(p[0], "ifconfig-pool") && p[1] && p[2] && !p[4])
     {
-        const int lev = M_WARN;
+        const msglvl_t lev = M_WARN;
         bool error = false;
         in_addr_t start, end, netmask = 0;
 
@@ -7290,7 +7386,7 @@
     }
     else if (streq(p[0], "ifconfig-ipv6-pool") && p[1] && !p[2])
     {
-        const int lev = M_WARN;
+        const msglvl_t lev = M_WARN;
         struct in6_addr network;
         unsigned int netbits = 0;
 
@@ -7556,30 +7652,51 @@
     }
     else if (streq(p[0], "iroute") && p[1] && !p[3])
     {
+        char *iroute_parms[MAX_PARMS + 1] = { 0 };
+
         VERIFY_PERMISSION(OPT_P_INSTANCE);
-        option_iroute(options, p[1], p[2], msglevel);
+        if (!ipv4_cidr_parms_checked(p, 1, 2, iroute_parms, "network/IP", msglevel, &options->gc))
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
+        char *ifconfig_push_parms[MAX_PARMS + 1] = { 0 };
 
         VERIFY_PERMISSION(OPT_P_INSTANCE);
-        local = getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[1], 0, NULL, NULL);
-        remote_netmask = getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2], 0, NULL, NULL);
+        if (!ipv4_cidr_parms_checked(p, 1, 3, ifconfig_push_parms, "local/IP", msglevel, &options->gc))
+        {
+            goto err;
+        }
+        if (!ifconfig_push_parms[2])
+        {
+            msg(msglevel, "--ifconfig-push requires 'local remote-netmask [alias]' or "
+                          "'local/bits [alias]'");
+            goto err;
+        }
+
+        local = getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig_push_parms[1], 0, NULL,
+                        NULL);
+        remote_netmask = getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig_push_parms[2], 0,
+                                 NULL, NULL);
         if (local && remote_netmask)
         {
             options->push_ifconfig_defined = true;
             options->push_ifconfig_local = local;
             options->push_ifconfig_remote_netmask = remote_netmask;
-            if (p[3])
+            if (ifconfig_push_parms[3])
             {
                 options->push_ifconfig_local_alias =
-                    getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[3], 0, NULL, NULL);
+                    getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig_push_parms[3], 0,
+                            NULL, NULL);
             }
         }
         else
@@ -7588,13 +7705,26 @@
             goto err;
         }
     }
-    else if (streq(p[0], "ifconfig-push-constraint") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], "ifconfig-push-constraint") && p[1] && !p[3])
     {
         in_addr_t network, netmask;
+        char *ifconfig_push_constraint_parms[MAX_PARMS + 1] = { 0 };
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        network = getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[1], 0, NULL, NULL);
-        netmask = getaddr(GETADDR_HOST_ORDER, p[2], 0, NULL, NULL);
+        if (!ipv4_cidr_parms_checked(p, 1, 2, ifconfig_push_constraint_parms, "network/IP", msglevel,
+                                     &options->gc))
+        {
+            goto err;
+        }
+        if (!ifconfig_push_constraint_parms[2])
+        {
+            msg(msglevel, "--ifconfig-push-constraint requires 'network netmask' or 'network/bits'");
+            goto err;
+        }
+
+        network = getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, ifconfig_push_constraint_parms[1],
+                          0, NULL, NULL);
+        netmask = getaddr(GETADDR_HOST_ORDER, ifconfig_push_constraint_parms[2], 0, NULL, NULL);
         if (network && netmask)
         {
             options->push_ifconfig_constraint_defined = true;
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
+ipv4_cidr_to_netmask(const char *in_cidr, const char *slash, const char **out_network,
+                     const char **out_netmask, struct gc_arena *gc)
+{
+    ASSERT(in_cidr);
+    ASSERT(slash);
+    ASSERT(slash[0] == '/');
+
+    if (slash[1] == '\0')
+    {
+        return -EINVAL;
+    }
+
+    /* extract and validate the prefix value */
+    const char *prefix_str = slash + 1;
+    if (strspn(prefix_str, "0123456789") != strlen(prefix_str))
+    {
+        return -EINVAL;
+    }
+
+    errno = 0;
+    char *endptr = NULL;
+    const unsigned long prefix = strtoul(prefix_str, &endptr, 10);
+    if (errno != 0 || endptr == prefix_str || *endptr != '\0' || prefix > 32)
+    {
+        return -EINVAL;
+    }
+
+    const size_t slash_offset = (size_t)(slash - in_cidr);
+    if (slash_offset == 0)
+    {
+        return -EINVAL;
+    }
+
+    /* build the network string */
+    char *network_buf = gc_malloc(slash_offset + 1, true, gc);
+    memcpy(network_buf, in_cidr, slash_offset);
+    network_buf[slash_offset] = '\0';
+
+    /* build the netmask string */
+    const char *netmask_buf = print_in_addr_t(netbits_to_netmask((int)prefix), 0, gc);
+
+    *out_network = network_buf;
+    *out_netmask = netmask_buf;
+
+    return 0;
+}
+
+int
+convert_ipv4_cidr_parms(char *p[], int network_idx, int max_idx, char *normalized[],
+                        struct gc_arena *gc)
+{
+    ASSERT(max_idx < MAX_PARMS);
+    ASSERT(max_idx >= (network_idx + 1));
+    ASSERT(network_idx >= 1);
+    ASSERT(p[network_idx]);
+
+    /* map normalized parameters to the user provided ones */
+    for (int i = 0; i <= max_idx && p[i]; ++i)
+    {
+        normalized[i] = p[i];
+    }
+
+    const char *slash = strchr(p[network_idx], '/');
+    if (!slash)
+    {
+        return 0;
+    }
+
+    const char *network = NULL;
+    const char *netmask = NULL;
+    const int err = ipv4_cidr_to_netmask(p[network_idx], slash, &network, &netmask, gc);
+    if (err)
+    {
+        return err;
+    }
+
+    /* insert the netmask and shift the next parameters */
+    normalized[network_idx] = (char *)network;
+    normalized[network_idx + 1] = (char *)netmask;
+    for (int src = network_idx + 1, dst = network_idx + 2; dst <= max_idx; ++src, ++dst)
+    {
+        normalized[dst] = p[src];
+    }
+    /* keep argv-style null termination to avoid stale tail entries */
+    normalized[max_idx + 1] = NULL;
+
+    return 1;
+}
+
 static const char *updatable_options[] = { "block-ipv6", "block-outside-dns",
                                            "dhcp-option", "dns",
                                            "ifconfig", "ifconfig-ipv6",
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 511d189..4c6ea3a 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -108,4 +108,37 @@
  */
 bool check_push_update_option_flags(char *line, int *i, unsigned int *flags);
 
+/**
+ * Convert option parameters whose first IPv4 parameter may be in CIDR notation.
+ *
+ * The input tokens are read from \p p and the normalized output tokens are
+ * written to \p normalized.
+ *
+ * When \p p[network_idx] is in CIDR form (for example, ``10.8.0.0/24``), this
+ * function:
+ * - splits the network and prefix length,
+ * - converts the prefix length to dotted-quad netmask,
+ * - writes ``network`` and ``netmask`` into ``normalized[network_idx]`` and
+ *   ``normalized[network_idx + 1]``,
+ * - shifts remaining parameters one position to preserve legacy
+ *   ``network netmask ...`` layout.
+ *
+ * When \p p[network_idx] is not CIDR, \p normalized receives \p p unchanged
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
+ * @return 0 when no CIDR notation was present and no conversion was needed.
+ * @return 1 when CIDR notation was present and conversion was applied.
+ * @return -EINVAL on malformed CIDR input.
+ */
+int convert_ipv4_cidr_parms(char *p[], int network_idx, int max_idx,
+                            char *normalized[], struct gc_arena *gc);
+
 #endif /* ifndef OPTIONS_UTIL_H_ */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 1128eb4..e277d40 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -98,10 +98,11 @@
 ssl_testdriver_CFLAGS  = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
-ssl_testdriver_LDFLAGS = @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
+ssl_testdriver_LDFLAGS = @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS) $(SOCKETS_LIBS)
 ssl_testdriver_SOURCES = test_ssl.c \
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
 
 options_parse_testdriver_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@
-options_parse_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
+options_parse_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \
+	$(SOCKETS_LIBS)
 options_parse_testdriver_SOURCES = test_options_parse.c \
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
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	-DSOURCEDIR=\"$(top_srcdir)\" @TEST_CFLAGS@
 
-misc_testdriver_LDFLAGS = @TEST_LDFLAGS@
+misc_testdriver_LDFLAGS = @TEST_LDFLAGS@ $(SOCKETS_LIBS)
 
 misc_testdriver_SOURCES = test_misc.c \
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
 
 push_update_msg_testdriver_LDFLAGS = \
 	@TEST_LDFLAGS@ \
-	-L$(top_srcdir)/src/openvpn
+	-L$(top_srcdir)/src/openvpn \
+	$(SOCKETS_LIBS)
 
 push_update_msg_testdriver_SOURCES = test_push_update_msg.c \
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
 
 socket_testdriver_CFLAGS  = \
diff --git a/tests/unit_tests/openvpn/mock_setenv.c b/tests/unit_tests/openvpn/mock_setenv.c
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
diff --git a/tests/unit_tests/openvpn/mock_signal.c b/tests/unit_tests/openvpn/mock_signal.c
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
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tests/openvpn/test_options_parse.c
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
-    p_expect_someopt[0] = "someopt";
-    p_expect_someopt[1] = "parm1";
-    p_expect_someopt[2] = "parm2";
-    p_expect_otheropt[0] = "otheropt";
-    p_expect_otheropt[1] = "1";
-    p_expect_otheropt[2] = "2";
-    p_expect_inlineopt[0] = "inlineopt";
-    p_expect_inlineopt[1] = "some text\nother text\n";
+    char *p_expect_someopt[MAX_PARMS] = { "someopt", "parm1", "parm2", NULL };
+    char *p_expect_otheropt[MAX_PARMS] = { "otheropt", "1", "2", NULL };
+    char *p_expect_inlineopt[MAX_PARMS] = { "inlineopt", "some text\nother text\n", NULL };
 
     /* basic test */
     expect_function_call(add_option);
@@ -299,12 +289,209 @@
     gc_free(&o.dns_options.gc);
 }
 
+static void
+assert_tokens(char *actual[], const char *expected[], int max_idx)
+{
+    for (int i = 0; i <= max_idx + 1; ++i)
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
+    struct gc_arena gc = gc_new();
+    char *normalized[MAX_PARMS + 1] = { 0 };
+
+    /* non-CIDR input is returned unchanged */
+    char *legacy[MAX_PARMS + 1] = { "route", "10.8.0.0", "255.255.255.0", NULL };
+    const char *legacy_expected[] = { "route", "10.8.0.0", "255.255.255.0", NULL, NULL, NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(legacy, 1, 4, normalized, &gc), 0);
+    assert_tokens(normalized, legacy_expected, 4);
+
+    /* CIDR input is split and netmask is materialized */
+    CLEAR(normalized);
+    char *cidr[MAX_PARMS + 1] = { "route", "10.8.0.0/24", NULL };
+    const char *cidr_expected[] = { "route", "10.8.0.0", "255.255.255.0", NULL, NULL, NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(cidr, 1, 4, normalized, &gc), 1);
+    assert_tokens(normalized, cidr_expected, 4);
+
+    gc_free(&gc);
+}
+
+static void
+test_convert_ipv4_cidr_parms_coverage(void **state)
+{
+    struct gc_arena gc = gc_new();
+    char *normalized[MAX_PARMS + 1] = { 0 };
+
+    /* success paths */
+
+    /* route */
+    char *route[] = { "route", "10.1.2.0/24", "192.0.2.1", "7", NULL };
+    const char *route_expected[] = { "route", "10.1.2.0", "255.255.255.0", "192.0.2.1", "7",
+                                     NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route, 1, 4, normalized, &gc), 1);
+    assert_tokens(normalized, route_expected, 4);
+
+    /* ifconfig */
+    CLEAR(normalized);
+    char *ifconfig[] = { "ifconfig", "10.8.0.1/24", NULL };
+    const char *ifconfig_expected[] = { "ifconfig", "10.8.0.1", "255.255.255.0", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(ifconfig, 1, 2, normalized, &gc), 1);
+    assert_tokens(normalized, ifconfig_expected, 2);
+
+    /* server */
+    CLEAR(normalized);
+    char *server[] = { "server", "10.8.0.0/24", "nopool", NULL };
+    const char *server_expected[] = { "server", "10.8.0.0", "255.255.255.0", "nopool", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(server, 1, 3, normalized, &gc), 1);
+    assert_tokens(normalized, server_expected, 3);
+
+    /* server-bridge */
+    CLEAR(normalized);
+    char *server_bridge[] = { "server-bridge", "10.8.0.1/24", "10.8.0.10", "10.8.0.20", NULL };
+    const char *server_bridge_expected[] = { "server-bridge", "10.8.0.1", "255.255.255.0",
+                                             "10.8.0.10", "10.8.0.20", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(server_bridge, 1, 4, normalized, &gc), 1);
+    assert_tokens(normalized, server_bridge_expected, 4);
+
+    /* iroute */
+    CLEAR(normalized);
+    char *iroute[] = { "iroute", "172.16.0.0/16", NULL };
+    const char *iroute_expected[] = { "iroute", "172.16.0.0", "255.255.0.0", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(iroute, 1, 2, normalized, &gc), 1);
+    assert_tokens(normalized, iroute_expected, 2);
+
+    /* ifconfig-push */
+    CLEAR(normalized);
+    char *ifconfig_push[] = { "ifconfig-push", "10.8.0.6/24", "10.8.0.7", NULL };
+    const char *ifconfig_push_expected[] = { "ifconfig-push", "10.8.0.6", "255.255.255.0",
+                                             "10.8.0.7", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(ifconfig_push, 1, 3, normalized, &gc), 1);
+    assert_tokens(normalized, ifconfig_push_expected, 3);
+
+    /* ifconfig-push-constraint */
+    CLEAR(normalized);
+    char *ifconfig_push_constraint[] = { "ifconfig-push-constraint", "10.8.0.0/24", NULL };
+    const char *ifconfig_push_constraint_expected[] = { "ifconfig-push-constraint", "10.8.0.0",
+                                                        "255.255.255.0", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(ifconfig_push_constraint, 1, 2, normalized, &gc),
+                     1);
+    assert_tokens(normalized, ifconfig_push_constraint_expected, 2);
+
+    /* client-nat */
+    CLEAR(normalized);
+    char *client_nat[] = { "client-nat", "snat", "192.168.0.0/16", "10.0.0.0", NULL };
+    const char *client_nat_expected[] = { "client-nat", "snat", "192.168.0.0", "255.255.0.0",
+                                          "10.0.0.0", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(client_nat, 2, 4, normalized, &gc), 1);
+    assert_tokens(normalized, client_nat_expected, 4);
+
+    /* CIDR prefix boundaries */
+
+    /* /0 */
+    CLEAR(normalized);
+    char *route_default[MAX_PARMS + 1] = { "route", "0.0.0.0/0", NULL };
+    const char *route_default_expected[] = { "route", "0.0.0.0", "0.0.0.0", NULL, NULL, NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_default, 1, 4, normalized, &gc), 1);
+    assert_tokens(normalized, route_default_expected, 4);
+
+    /* /32 */
+    CLEAR(normalized);
+    char *route_host[MAX_PARMS + 1] = { "route", "198.51.100.42/32", NULL };
+    const char *route_host_expected[] = { "route", "198.51.100.42", "255.255.255.255", NULL,
+                                          NULL, NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_host, 1, 4, normalized, &gc), 1);
+    assert_tokens(normalized, route_host_expected, 4);
+
+    /* CIDR with DNS-style network token */
+    CLEAR(normalized);
+    char *route_dns_cidr[] = { "route", "vpn.example/24", "192.0.2.1", NULL };
+    const char *route_dns_cidr_expected[] = { "route", "vpn.example", "255.255.255.0",
+                                              "192.0.2.1", NULL, NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_dns_cidr, 1, 4, normalized, &gc), 1);
+    assert_tokens(normalized, route_dns_cidr_expected, 4);
+
+    /* non-CIDR passthrough (DNS-style network token) */
+    CLEAR(normalized);
+    char *route_dns[] = { "route", "vpn.example", "255.255.255.0", "192.0.2.1", NULL };
+    const char *route_dns_expected[] = { "route", "vpn.example", "255.255.255.0", "192.0.2.1",
+                                         NULL, NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_dns, 1, 4, normalized, &gc), 0);
+    assert_tokens(normalized, route_dns_expected, 4);
+
+    /* varied network_idx/max_idx shapes */
+
+    CLEAR(normalized);
+    char *generic_shift[] = { "opt", "x", "y", "10.9.0.0/25", "tail", NULL };
+    const char *generic_shift_expected[] = { "opt", "x", "y", "10.9.0.0", "255.255.255.128",
+                                             "tail", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(generic_shift, 3, 5, normalized, &gc), 1);
+    assert_tokens(normalized, generic_shift_expected, 5);
+
+    CLEAR(normalized);
+    char *near_limit[MAX_PARMS + 1] = { 0 };
+    near_limit[0] = "opt";
+    near_limit[MAX_PARMS - 2] = "203.0.113.0/24";
+    assert_int_equal(
+        convert_ipv4_cidr_parms(near_limit, MAX_PARMS - 2, MAX_PARMS - 1, normalized, &gc), 1);
+    assert_string_equal(normalized[0], "opt");
+    assert_string_equal(normalized[MAX_PARMS - 2], "203.0.113.0");
+    assert_string_equal(normalized[MAX_PARMS - 1], "255.255.255.0");
+    assert_null(normalized[MAX_PARMS]);
+
+    /* error paths */
+
+    char *route_invalid[] = { "route", "10.1.2.0/33", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid, 1, 4, normalized, &gc), -EINVAL);
+    char *route_invalid_negative_prefix[] = { "route", "10.1.2.0/-1", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_negative_prefix, 1, 4, normalized,
+                                             &gc),
+                     -EINVAL);
+    char *route_invalid_plus_prefix[] = { "route", "10.1.2.0/+24", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_plus_prefix, 1, 4, normalized, &gc),
+                     -EINVAL);
+    char *route_invalid_malformed_slash[] = { "route", "10.1.2.0//24", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_malformed_slash, 1, 4, normalized,
+                                             &gc),
+                     -EINVAL);
+    char *route_invalid_overflow_prefix[] = { "route", "10.1.2.0/999999999999999999999", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_overflow_prefix, 1, 4, normalized,
+                                             &gc),
+                     -EINVAL);
+    char *route_invalid_empty_network[] = { "route", "/24", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_empty_network, 1, 4, normalized, &gc),
+                     -EINVAL);
+    char *route_invalid_no_prefix[] = { "route", "10.1.2.0/", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_no_prefix, 1, 4, normalized, &gc),
+                     -EINVAL);
+    char *route_invalid_alpha_prefix[] = { "route", "10.1.2.0/2x", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(route_invalid_alpha_prefix, 1, 4, normalized, &gc),
+                     -EINVAL);
+
+    char *client_nat_invalid[] = { "client-nat", "snat", "192.168.0.0/35", "10.0.0.0", NULL };
+    assert_int_equal(convert_ipv4_cidr_parms(client_nat_invalid, 2, 4, normalized, &gc),
+                     -EINVAL);
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(test_parse_line),
         cmocka_unit_test(test_read_config),
+        cmocka_unit_test(test_convert_ipv4_cidr_parms_core),
+        cmocka_unit_test(test_convert_ipv4_cidr_parms_coverage),
     };
 
     return cmocka_run_group_tests_name("options_parse", tests, NULL, NULL);
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
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

