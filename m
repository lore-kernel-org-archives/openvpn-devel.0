From: Steffan Karger <steffan@...1856...>
Date: Sun, 26 Nov 2017 16:04:01 +0100
Message-Id: <20171126150401.28565-2-steffan@...1856...>
In-Reply-To: <20171126150401.28565-1-steffan@...1856...>
References: <20171126150401.28565-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] openssl: add missing #include statements
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

Compiling our current master against OpenSSL 1.1 with
-DOPENSSL_API_COMPAT=0x10100000L screams bloody murder.  This patch fixes
the errors caused by missing includes.  Previous openssl versions would
usually include 'the rest of the world', but they're fixing that.  So we
should no longer rely on it.

(And sneaking in alphabetic ordering of the includes while touching them.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/openssl_compat.h     | 1 +
 src/openvpn/ssl_openssl.c        | 6 +++++-
 src/openvpn/ssl_verify_openssl.c | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 9eb427da..6d7f7d02 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -42,6 +42,7 @@
 
 #include "buffer.h"
 
+#include <openssl/rsaerr.h>
 #include <openssl/ssl.h>
 #include <openssl/x509.h>
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 18ceecb4..79121049 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -52,10 +52,14 @@
 
 #include "ssl_verify_openssl.h"
 
+#include <openssl/bn.h>
+#include <openssl/crypto.h>
+#include <openssl/dh.h>
+#include <openssl/dsa.h>
 #include <openssl/err.h>
 #include <openssl/pkcs12.h>
+#include <openssl/rsa.h>
 #include <openssl/x509.h>
-#include <openssl/crypto.h>
 #ifndef OPENSSL_NO_EC
 #include <openssl/ec.h>
 #endif
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 2f3b10b9..4a1d1cf8 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -44,8 +44,9 @@
 #include "ssl_verify_backend.h"
 #include "openssl_compat.h"
 
-#include <openssl/x509v3.h>
+#include <openssl/bn.h>
 #include <openssl/err.h>
+#include <openssl/x509v3.h>
 
 int
 verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
-- 
2.14.1


