From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 21 Jan 2020 10:08:28 +0200
Message-Id: <20200121080828.1310-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] configure.ac: simplify AC_CHECK_FUNCS
 statements
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

AC_CHECK_FUNCS checks availability of each function
in argument list and defines HAVE_function macro.
AC_CHECK_FUNC takes single function as an argument and
doesn't automatically define any macros.

When we check for availability of a single function and
define own macro, it is enough to use AC_CHECK_FUNC.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 configure.ac | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 98fd39ce..3c057295 100644
--- a/configure.ac
+++ b/configure.ac
@@ -906,17 +906,17 @@ if test "${with_crypto_library}" = "openssl"; then
 	fi
 
 	have_crypto_aead_modes="yes"
-	AC_CHECK_FUNCS(
+	AC_CHECK_FUNC(
 		[EVP_aes_256_gcm],
 		,
-		[have_crypto_aead_modes="no"; break]
+		[have_crypto_aead_modes="no"]
 	)
 
 	have_export_keying_material="yes"
-	AC_CHECK_FUNCS(
+	AC_CHECK_FUNC(
 		[SSL_export_keying_material],
 		,
-		[have_export_keying_material="no"; break]
+		[have_export_keying_material="no"]
 	)
 
 	AC_CHECK_FUNCS(
@@ -1018,10 +1018,10 @@ elif test "${with_crypto_library}" = "mbedtls"; then
 	)
 
 	have_export_keying_material="yes"
-	AC_CHECK_FUNCS(
+	AC_CHECK_FUNC(
 		[mbedtls_ssl_conf_export_keys_ext_cb],
 		,
-		[have_export_keying_material="no"; break]
+		[have_export_keying_material="no"]
 	)
 
 	CFLAGS="${saved_CFLAGS}"
-- 
2.17.1


