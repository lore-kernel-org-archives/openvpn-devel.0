From: David Sommerseth <openvpn@...2080...>
Date: Wed, 19 Jan 2022 19:21:26 +0100
Message-Id: <20220119182126.56880-1-openvpn@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] crypto: Fix OPENSSL_FIPS enabled builds
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

From: David Sommerseth <davids@...515...>

On Fedora and RHEL/CentOS, the standard OpenSSL library has the FIPS
module enabled by default.  On these platforms, the OPENSSL_FIPS macro
is always defined via /usr/include/openssl/opensslconf-*.h.

Without this fix, the following compilation error appears:

  ./src/openvpn/crypto.c: In function ‘print_cipher’:
  ./src/openvpn/crypto.c:1707:43: error: ‘cipher’ undeclared (first use in this function); did you mean ‘iphdr’?
       if (FIPS_mode() && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_FIPS))
                                           ^~~~~~
The EVP_CIPHER_fetch() and EVP_CIPHER_free() methods are also provided
via the openssl_compat.h for older than OpenSSL 3.0.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/crypto.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 5626e2b6..eb0b1254 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -34,6 +34,7 @@
 #include "error.h"
 #include "integer.h"
 #include "platform.h"
+#include "openssl_compat.h"
 
 #include "memdbg.h"
 
@@ -1704,10 +1705,15 @@ print_cipher(const char *ciphername)
         printf(", TLS client/server mode only");
     }
 #ifdef OPENSSL_FIPS
-    if (FIPS_mode() && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_FIPS))
+    evp_cipher_type *cipher = EVP_CIPHER_fetch(NULL, ciphername, NULL);
+
+    if (FIPS_mode()
+        && (NULL != cipher)
+        && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_FIPS))
     {
         printf(", disabled by FIPS mode");
     }
+    EVP_CIPHER_free(cipher);
 #endif
 
     printf(")\n");
-- 
2.27.0


