From: Gert Doering <gert@...1296...>
Date: Thu, 16 Apr 2026 19:41:35 +0200
Message-ID: <20260416174142.28918-1-gert@...1296...>
In-Reply-To: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
References: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v12] ssl_openssl: Fix some CRL mixups
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

From: David Benjamin <davidben@...410...>

There are two ways to load CRLs in OpenSSL. They can be loaded at the
X509_STORE, shared across verifications, or loaded per verification at
the X509_STORE_CTX.

OpenVPN currently does the former. However, it also supports CRL
reloading, and tries to reload the CRL file before each connection.
OpenSSL does not really have a good way to unload objects from an
X509_STORE. OpenVPN currently does it by grabbing the
STACK_OF(X509_OBJECT) out of the X509_STORE and manually deleting all
the CRLs from it.

This mutates an OpenSSL internal object which bumps into problems if
OpenSSL ever switches to a more efficient representation. See
https://github.com/openssl/openssl/pull/28599

(It's also not thread-safe, though it doesn't look like that impacts
OpenVPN? Actually even reading that list doesn't work. See
CVE-2024-0397. This OpenSSL API was simply broken.)

Additionally, this seems to cause two OpenVPN features to not work
together. I gather backend_tls_ctx_reload_crl is trying to clear the
CRLs loaded from last time it ran. But tls_ctx_load_ca with a ca_file
can also load CRLs. tls_ctx_load_ca with ca_path will also pick up CRLs
and backend_tls_ctx_reload_crl actually ends up clobbering some state
X509_LOOKUP_hash_dir internally maintains on the X509_STORE. Likewise,
tls_verify_crl_missing can get confused between
backend_tls_ctx_reload_crl's crl_file-based CRLs and CRLs from
tls_ctx_load_ca.

Avoid all this by tracking the two CRLs separately. crl_file-based CRLs
now go onto a STACK_OF(X509_CRL) tracked on the tls_root_ctx. Now this
field can be freely reloaded by OpenVPN without reconfiguring OpenSSL.
Instead, pass the current value into OpenSSL at verification time.  To
do so, we need to use the SSL_CTX_set_cert_verify_callback, which allows
swapping out the X509_verify_cert call, and also tweaking the
X509_STORE_CTX configuration before starting certificate verification.

Context: SSL_CTX_set_cert_verify_callback and the existing
verify_callback are not the same. SSL_CTX_set_cert_verify_callback wraps
the verification while verify_callback is called multiple times
throughout verification. It's too late to reconfigure X509_STORE_CTX in
verify_callback. verify_callback is usually not what you want.
Sometimes current_cert and error_depth don't quite line up, and
cert_hash_remember may end up called multiple times for a single
certificate.

I suspect some of the other verify_callback logic would also be better
done in the new callback, but I've left it alone to keep this change
minimal. verify_callback is really only usable for suppressing errors.
Application bookkeeping is better down elsewhere.

Add .clang-format section for STACK_OF since we otherwise format the
line as STACK_OF(X509_CRL) * crls

Signed-off-by: David Benjamin <davidben@...410...>
Change-Id: I31ac2a763209114267c35c4a9182a12d8d82f6fe
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1289
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1289
This mail reflects revision 12 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>
MaxF <max@...2606...>

        
diff --git a/.clang-format b/.clang-format
index cbec0a4..4774d1e 100644
--- a/.clang-format
+++ b/.clang-format
@@ -43,7 +43,10 @@
 SpacesBeforeTrailingComments: '2'
 SpacesInParens: Never
 TabWidth: '4'
-TypeNames: [DWORD]
+TypeNames:
+  - 'DWORD'
+  - 'STACK_OF'
+TypenameMacros: ['STACK_OF']
 UseTab: Never
 WhitespaceSensitiveMacros: [_STRINGIFY]
 ---
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 8fdb39a..3494ce6 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -61,21 +61,6 @@
 
 /* Functionality missing in LibreSSL before 3.5 */
 #if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER < 0x3050000fL
-/**
- * Destroy a X509 object
- *
- * @param obj                X509 object
- */
-static inline void
-X509_OBJECT_free(X509_OBJECT *obj)
-{
-    if (obj)
-    {
-        X509_OBJECT_free_contents(obj);
-        OPENSSL_free(obj);
-    }
-}
-
 #define EVP_CTRL_AEAD_SET_TAG EVP_CTRL_GCM_SET_TAG
 #define EVP_CTRL_AEAD_GET_TAG EVP_CTRL_GCM_GET_TAG
 #endif
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index e8d7262..04e3521 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -141,6 +141,8 @@
     ASSERT(NULL != ctx);
     SSL_CTX_free(ctx->ctx);
     ctx->ctx = NULL;
+    sk_X509_CRL_pop_free(ctx->crls, X509_CRL_free);
+    ctx->crls = NULL;
     unload_xkey_provider(); /* in case it is loaded */
 }
 
@@ -304,6 +306,22 @@
     return true;
 }
 
+static int
+cert_verify_callback(X509_STORE_CTX *ctx, void *arg)
+{
+    struct tls_session *session;
+    SSL *ssl;
+
+    ssl = X509_STORE_CTX_get_ex_data(ctx, SSL_get_ex_data_X509_STORE_CTX_idx());
+    ASSERT(ssl);
+    session = SSL_get_ex_data(ssl, mydata_index);
+    ASSERT(session);
+
+    /* Configure CRLs. */
+    X509_STORE_CTX_set0_crls(ctx, session->opt->ssl_ctx->crls);
+    return X509_verify_cert(ctx);
+}
+
 bool
 tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
@@ -346,6 +364,7 @@
         verify_flags = SSL_VERIFY_PEER;
     }
     SSL_CTX_set_verify(ctx->ctx, verify_flags, verify_callback);
+    SSL_CTX_set_cert_verify_callback(ctx->ctx, cert_verify_callback, NULL);
 
     SSL_CTX_set_info_callback(ctx->ctx, info_callback);
 
@@ -1374,6 +1393,7 @@
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file, bool crl_inline)
 {
     BIO *in = NULL;
+    STACK_OF(X509_CRL) *crls = NULL;
 
     X509_STORE *store = SSL_CTX_get_cert_store(ssl_ctx->ctx);
     if (!store)
@@ -1381,20 +1401,8 @@
         crypto_msg(M_FATAL, "Cannot get certificate store");
     }
 
-    /* Always start with a cleared CRL list, for that we
-     * we need to manually find the CRL object from the stack
-     * and remove it */
-    STACK_OF(X509_OBJECT) *objs = X509_STORE_get0_objects(store);
-    for (int i = 0; i < sk_X509_OBJECT_num(objs); i++)
-    {
-        X509_OBJECT *obj = sk_X509_OBJECT_value(objs, i);
-        ASSERT(obj);
-        if (X509_OBJECT_get_type(obj) == X509_LU_CRL)
-        {
-            sk_X509_OBJECT_delete(objs, i);
-            X509_OBJECT_free(obj);
-        }
-    }
+    sk_X509_CRL_pop_free(ssl_ctx->crls, X509_CRL_free);
+    ssl_ctx->crls = NULL;
 
     X509_STORE_set_flags(store, X509_V_FLAG_CRL_CHECK | X509_V_FLAG_CRL_CHECK_ALL);
 
@@ -1410,7 +1418,13 @@
     if (in == NULL)
     {
         msg(M_WARN, "CRL: cannot read: %s", print_key_filename(crl_file, crl_inline));
-        goto end;
+        return;
+    }
+
+    crls = sk_X509_CRL_new_null();
+    if (crls == NULL)
+    {
+        crypto_msg(M_FATAL, "CRL: cannot create CRL list");
     }
 
     int num_crls_loaded = 0;
@@ -1436,18 +1450,14 @@
             break;
         }
 
-        if (!X509_STORE_add_crl(store, crl))
+        if (!sk_X509_CRL_push(crls, crl))
         {
-            X509_CRL_free(crl);
-            crypto_msg(M_WARN, "CRL: cannot add %s to store",
-                       print_key_filename(crl_file, crl_inline));
-            break;
+            crypto_msg(M_FATAL, "CRL: cannot add CRL to list");
         }
-        X509_CRL_free(crl);
         num_crls_loaded++;
     }
     msg(M_INFO, "CRL: loaded %d CRLs from file %s", num_crls_loaded, crl_file);
-end:
+    ssl_ctx->crls = crls;
     BIO_free(in);
 }
 
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index 3926e91..373dc10 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -41,6 +41,7 @@
     SSL_CTX *ctx;
     time_t crl_last_mtime;
     off_t crl_last_size;
+    STACK_OF(X509_CRL) *crls;
 };
 
 struct key_state_ssl
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 96ca1a4..ef8231c 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -798,23 +798,7 @@
         return false;
     }
 
-    X509_STORE *store = SSL_CTX_get_cert_store(opt->ssl_ctx->ctx);
-    if (!store)
-    {
-        crypto_msg(M_FATAL, "Cannot get certificate store");
-    }
-
-    STACK_OF(X509_OBJECT) *objs = X509_STORE_get0_objects(store);
-    for (int i = 0; i < sk_X509_OBJECT_num(objs); i++)
-    {
-        X509_OBJECT *obj = sk_X509_OBJECT_value(objs, i);
-        ASSERT(obj);
-        if (X509_OBJECT_get_type(obj) == X509_LU_CRL)
-        {
-            return false;
-        }
-    }
-    return true;
+    return opt->ssl_ctx->crls == NULL || sk_X509_CRL_num(opt->ssl_ctx->crls) == 0;
 }
 
 #endif /* defined(ENABLE_CRYPTO_OPENSSL) */

