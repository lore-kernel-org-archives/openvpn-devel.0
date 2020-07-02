From: Richard Bonhomme <tincanteksup@...277...>
Date: Thu,  2 Jul 2020 14:25:49 +0100
Message-Id: <20200702132549.25554-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [Patch] New man page corrections -
 vpn-network-options.rst
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

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
---
 doc/man-sections/vpn-network-options.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index d75cf540..894df367 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -91,7 +91,7 @@ routing.
 --dhcp-option args
   Set additional network settings via DHCP.  On Windows, this is parsed by
   the ``tap-windows6`` or ``wintun`` driver.  On other platforms these
-  options can be picked up by a ``--up`` script or plug-in if it has been
+  options can be picked up by an ``--up`` script or plug-in if it has been
   pushed by the OpenVPN server.  The option will then be saved in the
   client's environment before the ``--up`` script is called, under the name
   :code:`foreign_option_{n}`.
@@ -475,7 +475,7 @@ routing.
 
   The MTU (Maximum Transmission Units) is the maximum datagram size in
   bytes that can be sent unfragmented over a particular network path.
-  OpenVPN requires that packets on the control or data channels be sent
+  OpenVPN requires that packets on the control and data channels be sent
   unfragmented.
 
   MTU problems often manifest themselves as connections which hang during
-- 
2.17.1


