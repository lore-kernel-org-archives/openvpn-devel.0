From: Frank Lichtenheld <frank@...2641...>
Date: Mon,  4 Dec 2023 16:34:44 +0100
Message-Id: <20231204153444.56906-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] documentation: remove reference to removed
 option --show-proxy-settings
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

This option was removed in 2.3.0.

Change-Id: I243ba135ce36cff36ba77eead7dcd9354bd94ab7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/proxy-options.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/doc/man-sections/proxy-options.rst b/doc/man-sections/proxy-options.rst
index 465bea01..548d1c03 100644
--- a/doc/man-sections/proxy-options.rst
+++ b/doc/man-sections/proxy-options.rst
@@ -1,7 +1,3 @@
---show-proxy-settings
-  Show sensed HTTP or SOCKS proxy settings. Currently, only Windows
-  clients support this option.
-
 --http-proxy args
   Connect to remote host through an HTTP proxy.  This requires at least an
   address ``server`` and ``port`` argument.  If HTTP Proxy-Authenticate
-- 
2.34.1


