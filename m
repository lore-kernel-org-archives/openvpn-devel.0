From: Frank Lichtenheld <frank@...2641...>
Date: Wed,  3 May 2023 15:59:21 +0200
Message-Id: <20230503135922.54871-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] man page: Remove cruft from --topology
 documentation
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

None of this is likely relevant for a current reader.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/vpn-network-options.rst | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index c25bbf31..3a281495 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -513,7 +513,7 @@ routing.
     Use a point-to-point topology, by allocating one /30 subnet
     per client. This is designed to allow point-to-point semantics when some
     or all of the connecting clients might be Windows systems. This is the
-    default on OpenVPN 2.0.
+    default.
 
   :code:`p2p`
     Use a point-to-point topology where the remote endpoint of
@@ -527,12 +527,7 @@ routing.
     configuring the tun interface with a local IP address and subnet mask,
     similar to the topology used in ``--dev tap`` and ethernet bridging
     mode. This mode allocates a single IP address per connecting client and
-    works on Windows as well. Only available when server and clients are
-    OpenVPN 2.1 or higher, or OpenVPN 2.0.x which has been manually patched
-    with the ``--topology`` directive code. When used on Windows, requires
-    version 8.2 or higher of the TAP-Win32 driver. When used on \*nix,
-    requires that the tun driver supports an ``ifconfig``\(8) command which
-    sets a subnet instead of a remote endpoint IP address.
+    works on Windows as well.
 
   *Note:* Using ``--topology subnet`` changes the interpretation of the
   arguments of ``--ifconfig`` to mean "address netmask", no longer "local
-- 
2.34.1


