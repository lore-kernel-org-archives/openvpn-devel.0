From: Arne Schwabe <arne@...1227...>
Date: Fri,  7 Jul 2023 20:58:11 +0200
Message-Id: <20230707185811.30132-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] show extra info for OpenSSL errors
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

This also shows the extra data from the OpenSSL error function that
can contain extra information. For example, the command

    openvpn --providers vollbit

will print out (on macOS):

     OpenSSLerror:12800067:DSO support routines::could not load the shared library:filename(/opt/homebrew/Cellar/openssl@...1554.../3.1.1_1/lib/ossl-modules/vollbit.dylib): dlopen(/opt/homebrew/Cellar/openssl@...1554.../3.1.1_1/lib/ossl-modules/vollbit.dylib, 0x0002): tried: '/opt/homebrew/Cellar/openssl@...1554.../3.1.1_1/lib/ossl-modules/vollbit.dylib' (no such file), '/System/Volumes/Preboot/Cryptexes/OS/opt/homebrew/Cellar/openssl@...1554.../3.1.1_1/lib/ossl-modules/vollbit.dylib' (no such file), '/opt/homebrew/Cellar/openssl@...1554.../3.1.1_1/lib/ossl-modules/vollbit.dylib' (no such file)

Change-Id: Ic2ee89937dcd85721bcacd1b700a20c640364f80
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_openssl.c | 20 ++++++++++++++++++--
 src/openvpn/openssl_compat.h | 12 ++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index b043bb95e..d6916fc9b 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -238,9 +238,16 @@ void
 crypto_print_openssl_errors(const unsigned int flags)
 {
     unsigned long err = 0;
+    int line, errflags;
+    const char *file, *data, *func;
 
-    while ((err = ERR_get_error()))
+    while ((err = ERR_get_error_all(&file, &line, &func, &data, &errflags)) != 0)
     {
+        if (!(errflags & ERR_TXT_STRING))
+        {
+            data = "";
+        }
+
         /* Be more clear about frequently occurring "no shared cipher" error */
         if (ERR_GET_REASON(err) == SSL_R_NO_SHARED_CIPHER)
         {
@@ -258,7 +265,16 @@ crypto_print_openssl_errors(const unsigned int flags)
                 "tls-version-min 1.0 to the client configuration to use TLS 1.0+ "
                 "instead of TLS 1.0 only");
         }
-        msg(flags, "OpenSSL: %s", ERR_error_string(err, NULL));
+
+        /* print file and line if verb >=8 */
+        if (!check_debug_level(D_TLS_DEBUG_MED))
+        {
+            msg(flags, "OpenSSL%s:%s", ERR_error_string(err, NULL), data);
+        }
+        else
+        {
+            msg(flags, "OpenSSL (%s:%d %s): %s:%s", file, line, func, ERR_error_string(err, NULL), data);
+        }
     }
 }
 
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index ffb64adf6..736ce1bd5 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -43,6 +43,7 @@
 #include <openssl/rsa.h>
 #include <openssl/ssl.h>
 #include <openssl/x509.h>
+#include <openssl/err.h>
 
 /* Functionality missing in 1.1.0 */
 #if OPENSSL_VERSION_NUMBER < 0x10101000L && !defined(ENABLE_CRYPTO_WOLFSSL)
@@ -799,6 +800,17 @@ EVP_MD_free(const EVP_MD *md)
     /* OpenSSL 1.1.1 and lower use only const EVP_MD, nothing to free */
 }
 
+static inline unsigned long
+ERR_get_error_all(const char **file, int *line,
+                  const char **func,
+                  const char **data, int *flags)
+{
+    static const char *empty = "";
+    *func = empty;
+    long err = ERR_get_error_line_data(file, line, data, flags);
+    return err;
+}
+
 #endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */
 
 #endif /* OPENSSL_COMPAT_H_ */
-- 
2.39.2 (Apple Git-143)


