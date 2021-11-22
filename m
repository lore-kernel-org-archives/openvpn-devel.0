From: Gert Doering <gert@...1296...>
Date: Mon, 22 Nov 2021 12:41:04 +0100
Message-Id: <20211122114104.4814-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc/man (vpn-network-options): fix
 foreign_option_{n} typo
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
Cc: Todd Zullinger <tmz@...1936...>

From: Todd Zullinger <tmz@...1936...>

In 2da29362 (Improve the documentation for --dhcp-option, 2020-08-16),
`foreign_option_{n}` became plural between the first and second versions
of the patch.  Correct it.

Signed-off-by: Todd Zullinger <tmz@...1936...>
---
 doc/man-sections/vpn-network-options.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 8c1c02dc..5b2f8470 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -107,7 +107,7 @@ routing.
   ``OpenVPN for Android`` client also handles them internally.
 
   On all other platforms these options are only saved in the client's
-  environment under the name :code:`foreign_options_{n}` before the
+  environment under the name :code:`foreign_option_{n}` before the
   ``--up`` script is called. A plugin or an ``--up`` script must be used to
   pick up and interpret these as required. Many Linux distributions include
   such scripts and some third-party user interfaces such as tunnelblick also
-- 
2.26.3


