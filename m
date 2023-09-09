From: orbea@...2744...
Date: Sat,  9 Sep 2023 06:49:56 -0700
Message-ID: <20230909134956.5902-1-orbea@...2744...>
In-Reply-To: <https://sourceforge.net/p/openvpn/mailman/message/37893638/>
References: <https://sourceforge.net/p/openvpn/mailman/message/37893638/>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] configure: disable engines if
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

Signed-off-by: orbea <orbea@...2744...>
---
 configure.ac | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 2f65cbd5..266b66f0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -927,11 +927,17 @@ if test "${with_crypto_library}" = "openssl"; then
 				    [AC_LANG_PROGRAM(
 					    [[
 	    #include <openssl/opensslv.h>
+	    #include <openssl/opensslconf.h>
 					    ]],
 					    [[
 	    /*	     Version encoding: MNNFFPPS - see opensslv.h for details */
 	    #if OPENSSL_VERSION_NUMBER >= 0x30000000L
-	    #error Engine supported disabled by default in OpenSSL 3.0+
+	    #error Engine support disabled by default in OpenSSL 3.0+
+	    #endif
+
+	    /*	     BoringSSL and LibreSSL >= 3.8.1 removed engine support */
+	    #ifdef OPENSSL_NO_ENGINE
+	    #error Engine support disabled in openssl/opensslconf.h
 	    #endif
 					    ]]
 				    )],
-- 
2.41.0


