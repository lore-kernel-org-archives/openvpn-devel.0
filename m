From: Antonio Quartulli <a@...2181...>
Date: Wed, 26 Jan 2022 16:11:28 +0100
Message-Id: <20220126151128.5078-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] crypto.c: remove (dead) OpenSSL specific
 code
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
Cc: Antonio Quartulli <a@...2181...>, David Sommerseth <davids@...515...>

Originally we wanted to move this OpenSSL specific code to its own
backend and use a proper abstraction in the crypto.c code.

However, tests have revealed that OpenVPN will never try to print a
cipher that is not supported by FIPS (assuming FIPS is enabled), because
along the chain of calls we already call cipher_get() which returns NULL
for FIPS-disabled ciphers.

For this reason, we can just remove any FIPS specific code from
print_cipher() and be done with it.

This patch fixes compilations with mbedTLS when some OpenSSL is also
installed. The issue was introduced with:
544330fe ("crypto: Fix OPENSSL_FIPS enabled builds")

Cc: David Sommerseth <davids@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/crypto.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 0aa76e05..b0a3cf81 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -34,7 +34,6 @@
 #include "error.h"
 #include "integer.h"
 #include "platform.h"
-#include "openssl_compat.h"
 
 #include "memdbg.h"
 
@@ -1704,16 +1703,6 @@ print_cipher(const char *ciphername)
     {
         printf(", TLS client/server mode only");
     }
-#ifdef OPENSSL_FIPS
-    evp_cipher_type *cipher = EVP_CIPHER_fetch(NULL, ciphername, NULL);
-
-    if (FIPS_mode() && cipher
-        && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_FIPS))
-    {
-        printf(", disabled by FIPS mode");
-    }
-    EVP_CIPHER_free(cipher);
-#endif
 
     printf(")\n");
 }
-- 
2.34.1


