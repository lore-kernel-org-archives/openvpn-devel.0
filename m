From: Arne Schwabe <arne@...1227...>
Date: Wed, 16 Feb 2022 13:56:53 +0100
Message-Id: <20220216125653.4080943-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix mbed TLS compile if OpenSSL headers are
 not available
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

We unconditionally include openssl/opensslv.h which fails if OpenSSL header
are not available.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/xkey_common.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index e58748b4..67c888be 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -25,11 +25,14 @@
 #ifndef XKEY_COMMON_H_
 #define XKEY_COMMON_H_
 
+/* Guard to only enable if OpenSSL is used and not trigger an error if mbed
+ * TLS is compiled without OpenSSL being installed */
+#if defined(ENABLE_CRYPTO_OPENSSL)
 #include <openssl/opensslv.h>
 #if OPENSSL_VERSION_NUMBER >= 0x30000010L && !defined(DISABLE_XKEY_PROVIDER)
 #define HAVE_XKEY_PROVIDER 1
 #include <openssl/provider.h>
-#include <openssl/core_dispatch.h>
+#include <openssl/core_dispatnch.h>
 
 /**
  * Initialization function for OpenVPN external key provider for OpenSSL
@@ -169,4 +172,6 @@ xkey_max_saltlen(int modBits, int hLen)
 }
 #endif /* HAVE_XKEY_PROVIDER */
 
+#endif /* ENABLE_CRYPTO_OPENSSL */
+
 #endif /* XKEY_COMMON_H_ */
-- 
2.33.0


