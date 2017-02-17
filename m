Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: logout@...260...
Date: Fri, 17 Feb 2017 23:00:41 +0100
Message-Id: <8e6d66e3a9a40abb3d7c99c48ba59bad1037d0ef.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [RFC PATCH v1 02/15] OpenSSL: don't use direct
	access to the internal of X509_STORE
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Emmanuel Deloget <logout@...260...>

OpenSSL 1.1 does not allow us to directly access the internal of
any data type, including X509_STORE. We have to use the defined functions
to do so.

Compatibility with OpenSSL 1.0 is kept by defining the corresponding
functions when they are not found in the library.

Signed-off-by: Emmanuel Deloget <logout@...260...>
---
 configure.ac                     |  1 +
 src/openvpn/openssl_compat.h     | 15 +++++++++++++++
 src/openvpn/ssl_openssl.c        |  7 ++++---
 src/openvpn/ssl_verify_openssl.c |  6 ++++--
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5fe5d6046ceafa2b577296af772c347ac2ad8039..415128c9f8687a53e4a73419f3048d07f66b70cc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -902,6 +902,7 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 		[ \
 			SSL_CTX_get_default_passwd_cb \
 			SSL_CTX_get_default_passwd_cb_userdata \
+			X509_STORE_get0_objects \
 		],
 		,
 		[]
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 59bad9ff24d10b358419d345181a0e2e52a0c662..016008bc1705a41ee0ee09fecfc0b16b282cede3 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -42,6 +42,7 @@
 #endif
 
 #include <openssl/ssl.h>
+#include <openssl/x509.h>
 
 #if !defined(HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA)
 /**
@@ -71,4 +72,18 @@ SSL_CTX_get_default_passwd_cb(SSL_CTX *ctx)
 }
 #endif
 
+#if !defined(HAVE_X509_STORE_GET0_OBJECTS)
+/**
+ * Fetch the X509 object stack from the X509 store
+ *
+ * @param store              X509 object store
+ * @return                   the X509 object stack
+ */
+static inline STACK_OF(X509_OBJECT) *
+X509_STORE_get0_objects(X509_STORE *store)
+{
+    return store ? store->objs : NULL;
+}
+#endif
+
 #endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 39e92f8cdae52d54d0ad95a9362e4e0e1b2289f4..e57de43a748c89ff58ea00abade0b1c317013258 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -900,13 +900,14 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
     /* Always start with a cleared CRL list, for that we
      * we need to manually find the CRL object from the stack
      * and remove it */
-    for (int i = 0; i < sk_X509_OBJECT_num(store->objs); i++)
+    STACK_OF(X509_OBJECT) *objs = X509_STORE_get0_objects(store);
+    for (int i = 0; i < sk_X509_OBJECT_num(objs); i++)
     {
-        X509_OBJECT *obj = sk_X509_OBJECT_value(store->objs, i);
+        X509_OBJECT *obj = sk_X509_OBJECT_value(objs, i);
         ASSERT(obj);
         if (obj->type == X509_LU_CRL)
         {
-            sk_X509_OBJECT_delete(store->objs, i);
+            sk_X509_OBJECT_delete(objs, i);
             X509_OBJECT_free_contents(obj);
             OPENSSL_free(obj);
         }
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 274e2bbf96b6c943ce628eab143f8c76e1c47103..fabbb0c370b123f54ce4a1eaf5f9650b440f47f8 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -43,6 +43,7 @@
 #include "ssl_openssl.h"
 #include "ssl_verify.h"
 #include "ssl_verify_backend.h"
+#include "openssl_compat.h"
 
 #include <openssl/x509v3.h>
 #include <openssl/err.h>
@@ -715,9 +716,10 @@ tls_verify_crl_missing(const struct tls_options *opt)
         crypto_msg(M_FATAL, "Cannot get certificate store");
     }
 
-    for (int i = 0; i < sk_X509_OBJECT_num(store->objs); i++)
+    STACK_OF(X509_OBJECT) *objs = X509_STORE_get0_objects(store);
+    for (int i = 0; i < sk_X509_OBJECT_num(objs); i++)
     {
-        X509_OBJECT *obj = sk_X509_OBJECT_value(store->objs, i);
+        X509_OBJECT *obj = sk_X509_OBJECT_value(objs, i);
         ASSERT(obj);
         if (obj->type == X509_LU_CRL)
         {
-- 
2.7.4


