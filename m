From: Steffan Karger <steffan@...1856...>
Date: Tue, 30 May 2017 22:50:44 +0200
Message-Id: <1496177444-18373-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
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

Instead of searching for both libssl and libcrypto, just search for
openssl as a whole (which depends on libssl and libcrypto).  The previous
discovery order would result in "-lcrypto -lssl" link flags, while we
need "-lssl -lcrypto".

Trac: #863

Signed-off-by: Steffan Karger <steffan@...1856...>
---
This patch is for release/2.4 only, because this is already fixed in
master by commit 79ea67f77ca3afe91222f62e17df885a30409285.

 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 2406ad8..854634a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -859,7 +859,7 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 		# if the user did not explicitly specify flags, try to autodetect
 		PKG_CHECK_MODULES(
 			[OPENSSL],
-			[libcrypto >= 0.9.8, libssl >= 0.9.8],
+			[openssl >= 0.9.8],
 	        [have_openssl="yes"],
 			[have_openssl="no"] # Provide if-not-found to prevent erroring out
 		)
-- 
2.7.4


