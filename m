From: Arne Schwabe <arne@...1227...>
Date: Sun, 26 Jun 2022 01:41:50 +0200
Message-Id: <20220625234150.3398864-5-arne@...1227...>
In-Reply-To: <20220625234150.3398864-1-arne@...1227...>
References: <20220625234150.3398864-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 5/5] Change default MTU in server mode to
 1420
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

This changes the default MTU of the tun-mtu to 1420 to avoid MTU related
issues that are even more prominent when DCO server or clients are involved.

To maximise compatibility to lie our MTU in the default OCC message and
keep it at 1500.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/vpn-network-options.rst | 17 ++++++++++++-----
 src/openvpn/options.c                    | 10 ++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 9a09aef8b..1dda4912d 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -525,11 +525,18 @@ routing.
   OpenVPN requires that packets on the control and data channels be sent
   unfragmented.
 
-  MTU problems often manifest themselves as connections which hang during
-  periods of active usage.
-
-  It's best to use the ``--fragment`` and/or ``--mssfix`` options to deal
-  with MTU sizing issues.
+  A VPN protocol like OpenVPN adds encapsulation overhead in each packet. If a
+  VPN packet with the encapsulation becomes larger than the transport network
+  MTU (typically 1500 or 1492) the packet will become fragmented or completely
+  dropped. These problems can manifest themselves as connections which hang
+  during periods of active usage or slower performance. To avoid these problems
+  it is generally advisable to set the tun MTU small enough to avoid these
+  problems. The default of 1420 is chosen to be safe with default parameters
+  and a (transport) network MTU of 1492.
+
+  If lowering the tun MTU to avoid MTU related problems (e.g. when tap is used
+  and an MTU of 1500 is required), the ``--fragment`` and/or ``--mssfix``
+  options can be also used to deal with MTU sizing issues.
 
   Note: Depending on the platform, the operating system allows to receive
   packets larger than ``tun-mtu`` (e.g. Linux and FreeBSD) but other platforms
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f162b0b41..d87c6595c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3032,6 +3032,16 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         if (!ce->tun_mtu_defined && !ce->link_mtu_defined)
         {
             ce->tun_mtu_defined = true;
+            if (o->mode == MODE_SERVER && dev != DEV_TYPE_TAP)
+            {
+                /* If we are running in P2MP mode we default to a MTU
+                 * that is low enough by default to fit into a 1492
+                 * MTU UDP IPv6 packet:
+                 *
+                 */
+                ce->tun_mtu = frame_calculate_default_mtu(o);
+                ce->occ_mtu = TUN_MTU_DEFAULT;
+            }
         }
         if ((dev == DEV_TYPE_TAP) && !ce->tun_mtu_extra_defined)
         {
-- 
2.32.1 (Apple Git-133)


