From: Heiko Hund <heiko@...2662...>
Date: Wed, 11 May 2022 14:10:38 +0200
Message-Id: <20220511121038.1002898-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc: fix literal block in tls-options.rst
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

Signed-off-by: Heiko Hund <heiko@...2662...>
---
 doc/man-sections/tls-options.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index c06ee335..d51aff77 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -487,8 +487,8 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
 
 --tls-crypt-v2 keyfile
 
-  Valid syntax:
-  ::
+  Valid syntax::
+
      tls-crypt-v2 keyfile
      tls-crypt-v2 keyfile force-cookie
      tls-crypt-v2 keyfile allow-noncookie
-- 
2.32.0


