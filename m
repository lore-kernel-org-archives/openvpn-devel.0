From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 16 Nov 2016 14:14:52 +0100
Message-ID: <1479302092-28406-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] configure: check for AEAD function
	declarations, instead of linkage
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

One might want to run ./configure before building the crypto library.
To correctly check from AEAD support in that case, check for the
function declaration, rather than trying to link to it.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 configure.ac | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4a45f05..aaa688e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -867,10 +867,11 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 	fi
 
 	have_crypto_aead_modes="yes"
-	AC_CHECK_FUNCS(
+	AC_CHECK_DECLS(
 		[EVP_aes_256_gcm],
 		,
-		[have_crypto_aead_modes="no"; break]
+		[have_crypto_aead_modes="no"; break],
+		[[ #include <openssl/evp.h> ]]
 	)
 
 	CFLAGS="${saved_CFLAGS}"
@@ -947,14 +948,13 @@ elif test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "mbedtls"; th
 		fi
 	fi
 
-	have_crypto_aead_modes="yes"
-	AC_CHECK_FUNCS(
-		[ \
-			mbedtls_cipher_write_tag \
-			mbedtls_cipher_check_tag \
-		],
-		,
-		[have_crypto_aead_modes="no"; break]
+	# Check mbed TLS AEAD support
+	have_crypto_aead_modes="no"
+	AC_CHECK_DECLS(
+		[ mbedtls_cipher_write_tag, mbedtls_cipher_check_tag ],
+		[ have_crypto_aead_modes="yes"],
+		[],
+		[[ #include <mbedtls/cipher.h> ]]
 	)
 
 	CFLAGS="${saved_CFLAGS}"
-- 
2.7.4


