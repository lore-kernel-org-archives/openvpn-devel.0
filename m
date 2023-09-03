From: orbea@...2744...
Date: Sun,  3 Sep 2023 07:29:47 -0700
Message-ID: <20230903142947.20906-1-orbea@...2744...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] configure: disable engines if
 OPENSSL_NO_ENGINE is defined
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

From: orbea <orbea@...2744...>

Starting with LibreSSL 3.8.1 the engines have been removed which causes
the OpenVPN build to fail. This can be solved during configure by
checking if OPENSSL_NO_ENGINE is defined in opensslconf.h.
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 2f65cbd5..b5a835dc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -926,11 +926,12 @@ if test "${with_crypto_library}" = "openssl"; then
 	    AC_COMPILE_IFELSE(
 				    [AC_LANG_PROGRAM(
 					    [[
+	    #include <openssl/opensslconf.h>
 	    #include <openssl/opensslv.h>
 					    ]],
 					    [[
 	    /*	     Version encoding: MNNFFPPS - see opensslv.h for details */
-	    #if OPENSSL_VERSION_NUMBER >= 0x30000000L
+	    #if OPENSSL_VERSION_NUMBER >= 0x30000000L || defined(OPENSSL_NO_ENGINE)
 	    #error Engine supported disabled by default in OpenSSL 3.0+
 	    #endif
 					    ]]
-- 
2.41.0


