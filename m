From: selva.nair@...277...
Date: Wed, 22 Sep 2021 17:12:47 -0400
Message-Id: <20210922211254.7570-3-selva.nair@...277...>
In-Reply-To: <20210922211254.7570-1-selva.nair@...277...>
References: <20210922211254.7570-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/9] Initialize the xkey provider and use it
 in SSL context
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

From: Selva Nair <selva.nair@...277...>

- The provider is loaded during crypto initialization
  and unloaded in uninit.
  The SSL server and client context are created with
  properties indicating preference for this provider.

This could be made conditional on use of external keys,
but it can't hurt if loaded and used otherwise too. Useful
to get the code exercised at least for a period of
testing.

As the provider is empty, no functionality gets delegated
to it as yet. Verb 4 logs with enable-debug will just show
the provider_init and teardown called.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/crypto_openssl.c | 19 +++++++++++++++++++
 src/openvpn/openssl_compat.h | 12 ++++++++++++
 src/openvpn/ssl_openssl.c    |  7 +++++--
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 419265a5..5d7fa847 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -42,6 +42,7 @@
 #include "crypto.h"
 #include "crypto_backend.h"
 #include "openssl_compat.h"
+#include "xkey_common.h"
 
 #include <openssl/conf.h>
 #include <openssl/des.h>
@@ -75,6 +76,8 @@ static bool engine_initialized = false; /* GLOBAL */
 
 static ENGINE *engine_persist = NULL;   /* GLOBAL */
 
+static void *xkey_prov;
+
 /* Try to load an engine in a shareable library */
 static ENGINE *
 try_load_engine(const char *engine)
@@ -161,6 +164,15 @@ crypto_init_lib(void)
     OPENSSL_config(NULL);
 #endif
 #endif /* _WIN32 */
+
+#ifdef HAVE_XKEY_PROVIDER
+     if (!xkey_prov)
+     {
+        OSSL_PROVIDER_add_builtin(NULL, "ovpn.xkey", xkey_provider_init);
+        xkey_prov = OSSL_PROVIDER_load(NULL, "ovpn.xkey");
+     }
+#endif
+
     /*
      * If you build the OpenSSL library and OpenVPN with
      * CRYPTO_MDEBUG, you will get a listing of OpenSSL
@@ -190,6 +202,13 @@ crypto_uninit_lib(void)
         engine_initialized = false;
     }
 #endif
+#ifdef HAVE_XKEY_PROVIDER
+    if (xkey_prov)
+    {
+        OSSL_PROVIDER_unload(xkey_prov);
+    }
+#endif
+    xkey_prov = NULL;
 }
 
 void
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index ce8e2b36..3dcdde4d 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -718,4 +718,16 @@ SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
     return 1;
 }
 #endif /* if OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSSL) */
+
+/** Mimics SSL_CTX_new_ex for OpenSSL < 3 */
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
+static inline SSL_CTX *
+SSL_CTX_new_ex(void *libctx, const char *propq, const SSL_METHOD *method)
+{
+    (void) libctx;
+    (void) propq;
+    return SSL_CTX_new(method);
+}
+#endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */
+
 #endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 241206fb..61256620 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -45,6 +45,7 @@
 #include "ssl_common.h"
 #include "base64.h"
 #include "openssl_compat.h"
+#include "xkey_common.h"
 
 #ifdef ENABLE_CRYPTOAPI
 #include "cryptoapi.h"
@@ -109,7 +110,8 @@ tls_ctx_server_new(struct tls_root_ctx *ctx)
 {
     ASSERT(NULL != ctx);
 
-    ctx->ctx = SSL_CTX_new(SSLv23_server_method());
+    const char *propq = "?" XKEY_PROV_PROPS;
+    ctx->ctx = SSL_CTX_new_ex(NULL, propq, SSLv23_server_method());
 
     if (ctx->ctx == NULL)
     {
@@ -127,7 +129,8 @@ tls_ctx_client_new(struct tls_root_ctx *ctx)
 {
     ASSERT(NULL != ctx);
 
-    ctx->ctx = SSL_CTX_new(SSLv23_client_method());
+    const char *propq = "?" XKEY_PROV_PROPS;
+    ctx->ctx = SSL_CTX_new_ex(NULL, propq, SSLv23_client_method());
 
     if (ctx->ctx == NULL)
     {
-- 
2.20.1


