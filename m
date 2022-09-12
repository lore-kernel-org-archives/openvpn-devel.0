From: Gert Doering <gert@...1296...>
Date: Mon, 12 Sep 2022 09:41:49 +0200
Message-Id: <20220912074149.31160-1-gert@...1296...>
In-Reply-To: <202208301957.27UJv74w093000@...2054...>
References: <202208301957.27UJv74w093000@...2054...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Improve documentation for --dev and
 --dev-node.
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

During the research for commit a5cf4cfb77f745 it turned out that
OpenVPN's behaviour regarding "--dev arbitrary-name" is very
platform-specific and not very well documented.

The referenced commit fixed DCO behaviour to be in line with non-DCO
linux behaviour, this commit catches up on the documentation.

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/man-sections/vpn-network-options.rst | 38 +++++++++++++++++++-----
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 5b2f8470..559b2464 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -69,15 +69,34 @@ routing.
      dev tap4
      dev ovpn
 
-  When the device name starts with :code:`tun` or :code:`tap`, the device
-  type is extracted automatically.  Otherwise the ``--dev-type`` option
-  needs to be added as well.
+  What happens if the device name is not :code:`tun` or :code:`tap` is
+  platform dependent.
+
+  On most platforms, :code:`tunN` (e.g. tun2, tun30) and :code:`tapN`
+  (e.g. tap3) will create a numbered tun/tap interface with the number
+  specified - this is useful if multiple OpenVPN instances are active,
+  and the instance-to-device mapping needs to be known.  Some platforms
+  do not support "numbered tap", so trying ``--dev tap3`` will fail.
+
+  Arbitrary names (e.g. ``--dev home``) will not work on most platforms,
+  with the exception of Linux and FreeBSD with the DCO kernel driver.
+
+  There, arbitrary names are allowed, and will create a tun or DCO
+  device named as requested.
+
+  Linux also supports arbitrary named tap devices, if TAP is requested
+  with ``--dev somename --dev-type tap``.
+
+  On Windows, only the names :code:`tun` and :code:`tap` are supported.
+  Selection among multiple installed drivers or driver instances is done
+  with ``--dev-node`` and ``--windows-driver``.
 
 --dev-node node
-  Explicitly set the device node rather than using :code:`/dev/net/tun`,
-  :code:`/dev/tun`, :code:`/dev/tap`, etc. If OpenVPN cannot figure out
-  whether ``node`` is a TUN or TAP device based on the name, you should
-  also specify ``--dev-type tun`` or ``--dev-type tap``.
+  This is a highly system dependent option to influence tun/tap driver
+  selection.
+
+  On Linux, tun/tap devices are created by accessing :code:`/dev/net/tun`,
+  and this device name can be changed using ``--dev-node ...``.
 
   Under Mac OS X this option can be used to specify the default tun
   implementation. Using ``--dev-node utun`` forces usage of the native
@@ -93,6 +112,11 @@ routing.
   both the network connections control panel name and the GUID for each
   TAP-Win32 adapter.
 
+  On other platforms, ``--dev-node node`` will influence the naming of the
+  created tun/tap device, if supported on that platform.  If OpenVPN cannot
+  figure out whether ``node`` is a TUN or TAP device based on the name,
+  you should also specify ``--dev-type tun`` or ``--dev-type tap``.
+
 --dev-type device-type
   Which device type are we using? ``device-type`` should be :code:`tun`
   (OSI Layer 3) or :code:`tap` (OSI Layer 2). Use this option only if
-- 
2.35.1


