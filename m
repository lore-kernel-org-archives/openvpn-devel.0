From: Steffan Karger <steffan@...1856...>
Date: Tue, 24 Jun 2014 22:03:25 +0200
Message-Id: <1403640206-7024-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Update README.polarssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

PolarSSL support has been extended and adjusted, but README.polarssl was
not accordingly adjusted. This updates README.polarssl to the current state
of affairs for OpenVPN 2.3.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 README.polarssl | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/README.polarssl b/README.polarssl
index ab7c2d7..06f30bf 100644
--- a/README.polarssl
+++ b/README.polarssl
@@ -7,7 +7,7 @@ To Build and Install,
 	make
 	make install
 
-This version depends on at least PolarSSL v1.1.
+This version depends on PolarSSL 1.2 (and requires at least 1.2.10).
 
 *************************************************************************
 
@@ -17,12 +17,10 @@ in the PolarSSL version of OpenVPN:
  * PKCS#12 file support
  * --capath support - Loading certificate authorities from a directory
  * Windows CryptoAPI support
- * Management external key support
  * X.509 alternative username fields (must be "CN")
 
 Plugin/Script features:
 
- * X.509 Serial number is in hex, not decimal as with OpenSSL
  * X.509 subject line has a different format than the OpenSSL subject line
  * X.509 certificate export does not work
  * X.509 certificate tracking
-- 
1.9.1


