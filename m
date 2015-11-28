From: Steffan Karger <steffan@...1856...>
Date: Sat, 28 Nov 2015 23:48:01 +0100
Message-Id: <1448750881-10767-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix openssl builds with custom-built
	library: specify most-dependent first
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

Libraries should be specified from left-to-right as most-dependent to
least-dependent.  Thus, -lssl comes first, then -lcrypto.

(This does not fail when pkg-config finds your libraries for you, since
we tell it '-lssl needs -lcrypto' and we then end up with
"-lcrypto -lssl -lcrypto", which is not pretty but does work.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 40df8a1..d3b3fa9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1110,7 +1110,7 @@ if test "${enable_crypto}" = "yes"; then
 		test "${have_crypto_aead_modes}" != "yes" && AC_MSG_ERROR([AEAD modes required but missing])
 	fi
 	OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CRYPTO_CFLAGS} ${CRYPTO_SSL_CFLAGS}"
-	OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_CRYPTO_LIBS} ${CRYPTO_SSL_LIBS}"
+	OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_SSL_LIBS} ${CRYPTO_CRYPTO_LIBS}"
 	AC_DEFINE([ENABLE_CRYPTO], [1], [Enable crypto library])
 fi
 
-- 
2.5.0


