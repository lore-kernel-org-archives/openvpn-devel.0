From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 21 Mar 2024 17:16:23 +0100
Message-Id: <20240321161623.2794161-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] script-options.rst: Update ifconfig_*
 variables
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

- Remove obsolete ifconfig_broadcast. Since this was
  removed in 2.5.0, do not add a removal note but just
  completely remove it.
- Add missing documentation of IPv6 variants for
  ifconfig_pool_* variables.

Github: #527
Change-Id: Ia8c8de6799f0291fc900628fbd06c8a414e741ca
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/script-options.rst | 38 ++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index e05100a2..0d1f9aec 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -682,13 +682,6 @@ instances.
     recorded to this environmental variable sequence prior to ``--up``
     script execution.
 
-:code:`ifconfig_broadcast`
-    The broadcast address for the virtual ethernet segment which is derived
-    from the ``--ifconfig`` option when ``--dev tap`` is used. Set prior to
-    OpenVPN calling the :code:`ifconfig` or :code:`netsh` (windows version
-    of ifconfig) commands which normally occurs prior to ``--up`` script
-    execution.
-
 :code:`ifconfig_ipv6_local`
     The local VPN endpoint IPv6 address specified in the
     ``--ifconfig-ipv6`` option (first parameter). Set prior to OpenVPN
@@ -731,30 +724,53 @@ instances.
     occurs prior to ``--up`` script execution.
 
 :code:`ifconfig_pool_local_ip`
-    The local virtual IP address for the TUN/TAP tunnel taken from an
+    The local virtual IPv4 address for the TUN/TAP tunnel taken from an
     ``--ifconfig-push`` directive if specified, or otherwise from the
     ifconfig pool (controlled by the ``--ifconfig-pool`` config file
     directive). Only set for ``--dev tun`` tunnels. This option is set on
     the server prior to execution of the ``--client-connect`` and
     ``--client-disconnect`` scripts.
 
+:code:`ifconfig_pool_local_ip6`
+    The local virtual IPv6 address for the TUN/TAP tunnel taken from an
+    ``--ifconfig-ipv6-push`` directive if specified, or otherwise from the
+    ifconfig pool (controlled by the ``--ifconfig-ipv6-pool`` config file
+    directive). Only set for ``--dev tun`` tunnels. This option is set on
+    the server prior to execution of the ``--client-connect`` and
+    ``--client-disconnect`` scripts.
+
 :code:`ifconfig_pool_netmask`
-    The virtual IP netmask for the TUN/TAP tunnel taken from an
+    The virtual IPv4 netmask for the TUN/TAP tunnel taken from an
     ``--ifconfig-push`` directive if specified, or otherwise from the
     ifconfig pool (controlled by the ``--ifconfig-pool`` config file
     directive). Only set for ``--dev tap`` tunnels. This option is set on
     the server prior to execution of the ``--client-connect`` and
     ``--client-disconnect`` scripts.
 
+:code:`ifconfig_pool_ip6_netbits`
+    The virtual IPv6 prefix length for the TUN/TAP tunnel taken from an
+    ``--ifconfig-ipv6-push`` directive if specified, or otherwise from the
+    ifconfig pool (controlled by the ``--ifconfig-ipv6-pool`` config file
+    directive). Only set for ``--dev tap`` tunnels. This option is set on
+    the server prior to execution of the ``--client-connect`` and
+    ``--client-disconnect`` scripts.
+
 :code:`ifconfig_pool_remote_ip`
-    The remote virtual IP address for the TUN/TAP tunnel taken from an
+    The remote virtual IPv4 address for the TUN/TAP tunnel taken from an
     ``--ifconfig-push`` directive if specified, or otherwise from the
     ifconfig pool (controlled by the ``--ifconfig-pool`` config file
     directive). This option is set on the server prior to execution of the
     ``--client-connect`` and ``--client-disconnect`` scripts.
 
+:code:`ifconfig_pool_remote_ip6`
+    The remote virtual IPv6 address for the TUN/TAP tunnel taken from an
+    ``--ifconfig-ipv6-push`` directive if specified, or otherwise from the
+    ifconfig pool (controlled by the ``--ifconfig-ipv6-pool`` config file
+    directive). This option is set on the server prior to execution of the
+    ``--client-connect`` and ``--client-disconnect`` scripts.
+
 :code:`link_mtu`
-    No longer passed to scripts since OpenVPN 2.6.0.  Used to be the
+    *REMOVED* No longer passed to scripts since OpenVPN 2.6.0.  Used to be the
     maximum packet size (not including the IP header) of tunnel data in
     UDP tunnel transport mode.
 
-- 
2.34.1


