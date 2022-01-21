From: David Sommerseth <openvpn@...2080...>
Date: Fri, 21 Jan 2022 21:10:38 +0100
Message-Id: <20220121201038.49684-1-openvpn@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] crypto: Fix mbedtls builds
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
Cc: David Sommerseth <davids@...515...>

From: David Sommerseth <davids@...515...>

With commit 544330fefedc87, the openssl_compat.h got included in
crypto.c.  This caused issues when building against mbed TLS, which this
compat layer is not targeting.

This issue is resolved by only including this header when the OpenSSL
library is in use.  The OPENSSL_FIPS macro should never be set when
compiling against the mbed TLS library.  But we check against the main
ENABLE_CRYPTO_OPENSSL macro here, in case future updates adds more
OpenSSL specific fragments.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/crypto.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 5f6ad675..d55ca099 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -34,7 +34,9 @@
 #include "error.h"
 #include "integer.h"
 #include "platform.h"
+#ifdef ENABLE_CRYPTO_OPENSSL
 #include "openssl_compat.h"
+#endif
 
 #include "memdbg.h"
 
-- 
2.27.0


