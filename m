From: Lev Stipakov <lstipakov@...277...>
Date: Tue,  9 Nov 2021 03:59:27 +0200
Message-Id: <20211109015927.311-1-lstipakov@...277...>
In-Reply-To: <CAGyAFMVbX1m_LhB=rV1Kh0uqpjfgCy6WP9t1o2bLTT+dO-L9Gg@...278...>
References: <CAGyAFMVbX1m_LhB=rV1Kh0uqpjfgCy6WP9t1o2bLTT+dO-L9Gg@...278...>
Subject: [Openvpn-devel] [PATCH] Use network address for emulated DHCP
 server as a default
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

This is the rebase of original Selva Nair's patch
which hasn't been merged:

  https://sourceforge.net/p/openvpn/mailman/message/34674818/

and documentation change to reflect code changes, which
is basically a revert of another Selva's patch (which got merged):

  https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13387.html

For subnet topology use "offset 0" as default for
calculating DHCP server address, which makes it equal
to the network address.

There is no know reason why non-zero default offset
is needed. Besides, offset -1 breaks subnet /30 case,
which in some cases is pushed by OpenVPN Cloud product.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 doc/man-sections/windows-options.rst | 2 +-
 src/openvpn/helper.c                 | 4 ++--
 src/openvpn/tun.c                    | 9 +--------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/windows-options.rst
index eacb9af8..c389fbc4 100644
--- a/doc/man-sections/windows-options.rst
+++ b/doc/man-sections/windows-options.rst
@@ -93,7 +93,7 @@ Windows-Specific Options
         server to masquerade as if it were coming from the remote endpoint.
 
         The optional offset parameter is an integer which is > :code:`-256`
-        and < :code:`256` and which defaults to -1. If offset is positive,
+        and < :code:`256` and which defaults to 0. If offset is positive,
         the DHCP server will masquerade as the IP address at network
         address + offset. If offset is negative, the DHCP server will
         masquerade as the IP address at broadcast address + offset.
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 032a71e8..4ac1cf8e 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -237,7 +237,7 @@ helper_client_server(struct options *o)
      * if tap OR (tun AND topology == subnet):
      *   ifconfig 10.8.0.1 255.255.255.0
      *   if !nopool:
-     *     ifconfig-pool 10.8.0.2 10.8.0.253 255.255.255.0
+     *     ifconfig-pool 10.8.0.2 10.8.0.254 255.255.255.0
      *   push "route-gateway 10.8.0.1"
      *   if route-gateway unset:
      *     route-gateway 10.8.0.2
@@ -340,7 +340,7 @@ helper_client_server(struct options *o)
                 {
                     o->ifconfig_pool_defined = true;
                     o->ifconfig_pool_start = o->server_network + 2;
-                    o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - 2;
+                    o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - 1;
                     ifconfig_pool_verify_range(M_USAGE, o->ifconfig_pool_start, o->ifconfig_pool_end);
                 }
                 o->ifconfig_pool_netmask = o->server_netmask;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 28f803ec..75d5eaf7 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6357,14 +6357,7 @@ tuntap_dhcp_mask(const struct tuntap *tt, const char *device_guid)
     {
         if (tt->topology == TOP_SUBNET)
         {
-            if (tt->options.dhcp_masq_custom_offset)
-            {
-                ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask, tt->options.dhcp_masq_offset);
-            }
-            else
-            {
-                ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask, -1);
-            }
+            ep[2] = dhcp_masq_addr(tt->local, tt->remote_netmask, tt->options.dhcp_masq_custom_offset ? tt->options.dhcp_masq_offset : 0);
         }
         else
         {
-- 
2.23.0.windows.1


