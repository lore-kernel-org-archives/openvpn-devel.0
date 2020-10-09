From: Steffan Karger <steffan@...1856...>
Date: Fri,  9 Oct 2020 16:47:55 +0200
Message-Id: <20201009144755.39719-1-steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Simplify key material exporter backend API
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

Just pass pointer and length, instead of a gc and return (possibly)
allocated memory. Saves us some gc instantiations and memcpy()s. Exact
same functionality, 19 lines less code.

(Didn't want to delay the TLS EKM reviews for this, so submitted as a
patch afterwards.)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c         | 26 ++++++++------------------
 src/openvpn/ssl_backend.h | 14 +++++---------
 src/openvpn/ssl_mbedtls.c | 12 +++++-------
 src/openvpn/ssl_openssl.c | 11 ++++-------
 4 files changed, 22 insertions(+), 41 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b572b7b8..87b51d96 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1786,23 +1786,14 @@ init_key_contexts(struct key_ctx_bi *key,
 static bool
 generate_key_expansion_tls_export(struct tls_session *session, struct key2 *key2)
 {
-    struct gc_arena gc = gc_new();
-    unsigned char *key2data;
-
-    key2data = key_state_export_keying_material(session,
-                                                EXPORT_KEY_DATA_LABEL,
-                                                strlen(EXPORT_KEY_DATA_LABEL),
-                                                sizeof(key2->keys),
-                                                &gc);
-    if (!key2data)
+    if (!key_state_export_keying_material(session, EXPORT_KEY_DATA_LABEL,
+                                          strlen(EXPORT_KEY_DATA_LABEL),
+                                          key2->keys, sizeof(key2->keys)))
     {
         return false;
     }
-    memcpy(key2->keys, key2data, sizeof(key2->keys));
-    secure_memzero(key2data, sizeof(key2->keys));
     key2->n = 2;
 
-    gc_free(&gc);
     return true;
 }
 
@@ -2499,12 +2490,11 @@ export_user_keying_material(struct key_state_ssl *ssl,
         unsigned int size = session->opt->ekm_size;
         struct gc_arena gc = gc_new();
 
-        unsigned char *ekm;
-        if ((ekm = key_state_export_keying_material(session,
-                                                    session->opt->ekm_label,
-                                                    session->opt->ekm_label_size,
-                                                    session->opt->ekm_size,
-                                                    &gc)))
+        unsigned char *ekm = gc_malloc(session->opt->ekm_size, true, &gc);
+        if (key_state_export_keying_material(session,
+                                             session->opt->ekm_label,
+                                             session->opt->ekm_label_size,
+                                             ekm, session->opt->ekm_size))
         {
             unsigned int len = (size * 2) + 2;
 
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 4bcb3181..c3d12e5b 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -398,18 +398,14 @@ void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
  * @param session      The session associated with the given key_state
  * @param label        The label to use when exporting the key
  * @param label_size   The size of the label to use when exporting the key
- * @param ekm_size     THe size of the exported/returned key material
- * @param gc           gc_arena that might be used to allocate the string
- *                     returned
- * @returns            The exported key material, the caller may zero the
- *                     string but should not free it
+ * @param ekm          Buffer to return the exported key material in
+ * @param ekm_size     The size of ekm, in bytes
+ * @returns            true if exporting succeeded, false otherwise
  */
-
-unsigned char*
+bool
 key_state_export_keying_material(struct tls_session *session,
                                  const char* label, size_t label_size,
-                                 size_t ekm_size,
-                                 struct gc_arena *gc) __attribute__((nonnull));
+                                 void *ekm, size_t ekm_size);
 
 /**************************************************************************/
 /** @addtogroup control_tls
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index f375e957..bb5633b7 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -219,11 +219,10 @@ mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
     return true;
 }
 
-unsigned char *
+bool
 key_state_export_keying_material(struct tls_session *session,
                                  const char* label, size_t label_size,
-                                 size_t ekm_size,
-                                 struct gc_arena *gc)
+                                 void *ekm, size_t ekm_size)
 {
     ASSERT(strlen(label) == label_size);
 
@@ -233,10 +232,9 @@ key_state_export_keying_material(struct tls_session *session,
      * there is no PRF, in both cases we cannot generate key material */
     if (cache->tls_prf_type == MBEDTLS_SSL_TLS_PRF_NONE)
     {
-        return NULL;
+        return false;
     }
 
-    unsigned char *ekm = (unsigned char *) gc_malloc(ekm_size, true, gc);
     int ret = mbedtls_ssl_tls_prf(cache->tls_prf_type, cache->master_secret,
                                   sizeof(cache->master_secret),
                                   label, cache->client_server_random,
@@ -245,12 +243,12 @@ key_state_export_keying_material(struct tls_session *session,
 
     if (mbed_ok(ret))
     {
-        return ekm;
+        return true;
     }
     else
     {
         secure_memzero(ekm, session->opt->ekm_size);
-        return  NULL;
+        return  false;
     }
 }
 #else
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index f52c7c39..122083a8 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -158,26 +158,23 @@ tls_ctx_initialised(struct tls_root_ctx *ctx)
     return NULL != ctx->ctx;
 }
 
-unsigned char*
+bool
 key_state_export_keying_material(struct tls_session *session,
                                  const char* label, size_t label_size,
-                                 size_t ekm_size,
-                                 struct gc_arena *gc)
+                                 void *ekm, size_t ekm_size)
 
 {
-    unsigned char *ekm = (unsigned char *) gc_malloc(ekm_size, true, gc);
-
     SSL* ssl = session->key[KS_PRIMARY].ks_ssl.ssl;
 
     if (SSL_export_keying_material(ssl, ekm, ekm_size, label,
                                    label_size, NULL, 0, 0) == 1)
     {
-        return ekm;
+        return true;
     }
     else
     {
         secure_memzero(ekm, ekm_size);
-        return NULL;
+        return false;
     }
 }
 
-- 
2.25.1


