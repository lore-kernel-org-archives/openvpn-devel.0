From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 29 Nov 2022 16:04:47 +0200
Message-Id: <20221129140447.1159-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] INSTALL: update Windows notes
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

Also slightly fix indent.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 INSTALL | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/INSTALL b/INSTALL
index da9b88e7..db24e98c 100644
--- a/INSTALL
+++ b/INSTALL
@@ -24,9 +24,9 @@ OpenVPN releases are also available as Debian/RPM packages:
 
 OpenVPN development versions can be found here:
 
-   https://github.com/OpenVPN/openvpn
-   https://gitlab.com/OpenVPN/openvpn
-   https://sourceforge.net/p/openvpn/openvpn/ci/master/tree/
+    https://github.com/OpenVPN/openvpn
+    https://gitlab.com/OpenVPN/openvpn
+    https://sourceforge.net/p/openvpn/openvpn/ci/master/tree/
 
 They should all be in sync at any time.
 
@@ -38,6 +38,10 @@ To download tap-windows (NDIS 6) driver source code go to:
 
     https://github.com/OpenVPN/tap-windows6
 
+To download ovpn-dco Windows driver source code go to:
+
+    https://github.com/OpenVPN/ovpn-dco-win
+
 To get the cross-compilation environment go to:
 
     https://github.com/OpenVPN/openvpn-build
@@ -263,13 +267,10 @@ TUN/TAP Driver References:
 
   OpenVPN on Windows needs a TUN/TAP kernel driver to work. OpenVPN installers
   include this driver, so installing it separately is not usually required.
-  Windows XP/2003 must use the NDIS 5 (tap-windows) driver, whereas on more
-  recent Windows versions it is recommended to use the NDIS 6 driver
-  (tap-windows6) instead.
 
-  Windows 10 and Server 2016 and up can use the dco-win driver for
-  kernel-level acceleration for OpenVPN client setups.  This is also
-  included in the community-provided OpenVPN installers.
+  Starting from Windows 10 2004 / Windows Server 2022, OpenVPN can use the
+  dco-win driver for kernel-level acceleration for OpenVPN client setups.
+  This driver is also included in the community-provided OpenVPN installers.
 
 *************************************************************************
 
-- 
2.38.1.windows.1


