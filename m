From: Steffan Karger <steffan@...1856...>
Date: Sun, 22 Jun 2014 20:18:39 +0200
Message-Id: <1403461119-21440-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] configure.ac: fix SSL_OP_NO_TICKET check
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

Only check for SSL_OP_NO_TICKET if building with --enable-ssl and using
openssl. This fixes cross-compiling polarssl builds for Windows (where
pkg-config would find the system openssl library, but the cross compiler
would not have openssl for the target platform).

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6f405ea..11b68c3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -807,7 +807,8 @@ if test "${have_openssl_crypto}" = "yes"; then
 	LIBS="${saved_LIBS}"
 fi
 
-if test "${have_openssl_ssl}" = "yes"; then
+if test "${enable_ssl}" = "yes" && test "${with_crypto_library}" = "openssl";
+then
     saved_CPPFLAGS="${CPPFLAGS}"
     CPPFLAGS="${CPPFLAGS} ${OPENSSL_CRYPTO_CFLAGS}"
     AC_MSG_CHECKING([for SSL_OP_NO_TICKET flag in OpenSSL])
-- 
1.9.1


