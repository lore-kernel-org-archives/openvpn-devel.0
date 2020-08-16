From: selva.nair@...277...
Date: Sun, 16 Aug 2020 15:06:39 -0400
Message-Id: <1597604799-23135-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1552943809-6367-1-git-send-email-selva.nair@...277...>
References: <1552943809-6367-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Improve the documentation for
 --dhcp-option
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
Cc: Selva Nair <selva@...2572...>, Selva Nair <selva.nair@...277...>

From: Selva Nair <selva@...2572...>

- Stress that these are handled internally only on some platforms
- Correct the statement about wintun 
- Document DOMAIN-SEARCH

Signed-off-by: Selva Nair <selva.nair@...277...>
---
v2: Rebase to master and reword to match the new rst version
    Add doc for DOMAIN-SEARCH

 doc/man-sections/vpn-network-options.rst | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 7100c1ae..825dd1ca 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -93,12 +93,18 @@ routing.
   or :code:`tap`.
 
 --dhcp-option args
-  Set additional network settings via DHCP.  On Windows, this is parsed by
-  the ``tap-windows6`` or ``wintun`` driver.  On other platforms these
-  options can be picked up by an ``--up`` script or plug-in if it has been
-  pushed by the OpenVPN server.  The option will then be saved in the
-  client's environment before the ``--up`` script is called, under the name
-  :code:`foreign_option_{n}`.
+  Set additional network parameters on supported platforms. May be specified
+  on the client or pushed from the server. On Windows these options are
+  handled by the ``tap-windows6`` driver by default or directly by OpenVPN
+  if dhcp is disabled or the ``wintun`` driver is in use. The
+  ``OpenVPN for Android`` client also handles them internally.
+
+  On all other platforms these options are only saved in the client's
+  environment under the name :code:`foreign_options_{n}` before the
+  ``--up`` script is called. A plugin or an ``--up`` script must be used to
+  pick up and interpret these as required. Many Linux distributions include
+  such scripts and some third-party user interfaces such as tunnelblick also
+  come with scripts that process these options.
 
   Valid syntax:
   ::
@@ -108,6 +114,11 @@ routing.
   :code:`DOMAIN` ``name``
         Set Connection-specific DNS Suffix to :code:`name`.
 
+  :code:`DOMAIN-SEARCH` ``name``
+        Add :code:`name` to the domain search list.
+        Repeat this option to add more entries. Up to
+        10 domains are supported.
+
   :code:`DNS` ``address``
         Set primary domain name server IPv4 or IPv6 address.
         Repeat this option to set secondary DNS server addresses.
-- 
2.17.1


