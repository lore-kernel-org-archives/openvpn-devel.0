From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 14 Jul 2023 11:25:57 +0200
Message-Id: <20230714092557.229260-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] fix typo: dhcp-options to dhcp-option in
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
Cc: George Pchelkin <gpchelkin@...2243...>

From: George Pchelkin <gpchelkin@...2243...>

Closes: #313

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/vpn-network-options.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 8e3c92ee..989dc844 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -140,7 +140,7 @@ routing.
   Valid syntax:
   ::
 
-     dhcp-options type [parm]
+     dhcp-option type [parm]
 
   :code:`DOMAIN` ``name``
         Set Connection-specific DNS Suffix to :code:`name`.
-- 
2.34.1


