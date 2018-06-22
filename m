From: Rosen Penev <rosenp@...277...>
Date: Thu, 21 Jun 2018 19:15:01 -0700
Message-Id: <20180622021501.23037-1-rosenp@...277...>
In-Reply-To: <20180622014905.21558-1-rosenp@...277...>
References: <20180622014905.21558-1-rosenp@...277...>
Subject: [Openvpn-devel] [PATCHv2] openvpn: Add missing OpenSSL includes
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

These get included when deprecated APIs are enabled. This is true on at
least version 1.0.2 and 1.1.0.

Without deprecated APIs, OpenVPN fails to compile.

Signed-off-by: Rosen Penev <rosenp@...277...>
---
 src/openvpn/ssl_openssl.c        | 9 +++++++++
 src/openvpn/ssl_verify_openssl.c | 1 +
 2 files changed, 10 insertions(+)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 527a600a..d9aec9bd 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -56,6 +56,15 @@
 #include <openssl/pkcs12.h>
 #include <openssl/x509.h>
 #include <openssl/crypto.h>
+#ifndef OPENSSL_NO_DH
+#include <openssl/dh.h>
+#endif
+#ifndef OPENSSL_NO_DSA
+#include <openssl/dsa.h>
+#endif
+#ifndef OPENSSL_NO_RSA
+#include <openssl/rsa.h>
+#endif
 #ifndef OPENSSL_NO_EC
 #include <openssl/ec.h>
 #endif
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 9b984751..82460ae7 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -46,6 +46,7 @@
 
 #include <openssl/x509v3.h>
 #include <openssl/err.h>
+#include <openssl/bn.h>
 
 int
 verify_callback(int preverify_ok, X509_STORE_CTX *ctx)
-- 
2.17.1


