From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 Aug 2020 10:55:37 +0200
Message-Id: <20200812085539.19620-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/3] Refactor
 key_state_export_keying_material functions
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

This refactors the common code between mbed SSL and OpenSSL into
export_user_keying_material and also prepares the backend functions
to export more than one key.

Also fix checking the return value of SSL_export_keying_material
only 1 is a sucess, -1 is also an error.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c         | 33 ++++++++++++++++++++++++-
 src/openvpn/ssl_backend.h | 18 ++++++++++++--
 src/openvpn/ssl_mbedtls.c | 22 ++++++-----------
 src/openvpn/ssl_openssl.c | 51 +++++++++++++++++++++------------------
 4 files changed, 83 insertions(+), 41 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index f16114c2..390114e1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2412,6 +2412,37 @@ error:
     return false;
 }
 
+static void
+export_user_keying_material(struct key_state_ssl *ssl,
+                            struct tls_session *session)
+{
+    if (session->opt->ekm_size > 0)
+    {
+        unsigned int size = session->opt->ekm_size;
+        struct gc_arena gc = gc_new();
+
+        unsigned char *ekm;
+        if ((ekm = key_state_export_keying_material(ssl, session,
+                                                    EXPORT_KEY_USER, &gc)))
+        {
+            unsigned int len = (size * 2) + 2;
+
+            const char *key = format_hex_ex(ekm, size, len, 0, NULL, &gc);
+            setenv_str(session->opt->es, "exported_keying_material", key);
+
+            dmsg(D_TLS_DEBUG_MED, "%s: exported keying material: %s",
+                 __func__, key);
+            secure_memzero(ekm, size);
+        }
+        else
+        {
+            msg(M_WARN, "WARNING: Export keying material failed!");
+            setenv_del(session->opt->es, "exported_keying_material");
+        }
+        gc_free(&gc);
+    }
+}
+
 /**
  * Handle reading key data, peer-info, username/password, OCC
  * from the TLS control channel (cleartext).
@@ -2541,7 +2572,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
     if ((ks->authenticated > KS_AUTH_FALSE)
         && plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
     {
-        key_state_export_keying_material(&ks->ks_ssl, session);
+        export_user_keying_material(&ks->ks_ssl, session);
 
         if (plugin_call(session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 7f52ab1e..8faaefd5 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -389,18 +389,32 @@ void key_state_ssl_free(struct key_state_ssl *ks_ssl);
 void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
                                 const char *crl_file, bool crl_inline);
 
+
+/* defines the different RFC5705 that are used in OpenVPN */
+enum export_key_identifier {
+    EXPORT_KEY_USER
+};
+
 /**
  * Keying Material Exporters [RFC 5705] allows additional keying material to be
  * derived from existing TLS channel. This exported keying material can then be
  * used for a variety of purposes.
  *
+ * Note
+ *
  * @param ks_ssl       The SSL channel's state info
  * @param session      The session associated with the given key_state
+ * @param key          The key to export.
+ * @param gc           gc_arena that might be used to allocate a string
+ * @returns            The exported key material, the caller may zero the
+ *                     string but should not free it
  */
 
-void
+unsigned char*
 key_state_export_keying_material(struct key_state_ssl *ks_ssl,
-                                 struct tls_session *session) __attribute__((nonnull));
+                                 struct tls_session *session,
+                                 enum export_key_identifier export_key,
+                                 struct gc_arena *gc) __attribute__((nonnull));
 
 /**************************************************************************/
 /** @addtogroup control_tls
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 9c874788..8ae6ec7b 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -231,24 +231,18 @@ mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
 }
 #endif /* HAVE_EXPORT_KEYING_MATERIAL */
 
-void
+unsigned char *
 key_state_export_keying_material(struct key_state_ssl *ssl,
-                                 struct tls_session *session)
+                                 struct tls_session *session,
+                                 enum export_key_identifier key_id,
+                                 struct gc_arena *gc)
 {
-    if (ssl->exported_key_material)
+    if (key_id == EXPORT_KEY_USER)
     {
-        unsigned int size = session->opt->ekm_size;
-        struct gc_arena gc = gc_new();
-        unsigned int len = (size * 2) + 2;
-
-        const char *key = format_hex_ex(ssl->exported_key_material,
-                                        size, len, 0, NULL, &gc);
-        setenv_str(session->opt->es, "exported_keying_material", key);
-
-        dmsg(D_TLS_DEBUG_MED, "%s: exported keying material: %s",
-             __func__, key);
-        gc_free(&gc);
+        return ssl->exported_key_material;
     }
+
+    return  NULL;
 }
 
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 5ba74402..1aad4f89 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -158,35 +158,38 @@ tls_ctx_initialised(struct tls_root_ctx *ctx)
     return NULL != ctx->ctx;
 }
 
-void
+unsigned char *
 key_state_export_keying_material(struct key_state_ssl *ssl,
-                                 struct tls_session *session)
+                                 struct tls_session *session,
+                                 enum export_key_identifier key_id,
+                                 struct gc_arena *gc)
+
 {
-    if (session->opt->ekm_size > 0)
-    {
-        unsigned int size = session->opt->ekm_size;
-        struct gc_arena gc = gc_new();
-        unsigned char *ekm = (unsigned char *) gc_malloc(size, true, &gc);
+    const char *label;
+    size_t label_size, ekm_size;
 
-        if (SSL_export_keying_material(ssl->ssl, ekm, size,
-                                       session->opt->ekm_label,
-                                       session->opt->ekm_label_size,
-                                       NULL, 0, 0))
-        {
-            unsigned int len = (size * 2) + 2;
+    if (key_id == EXPORT_KEY_USER)
+    {
+        label = session->opt->ekm_label;
+        label_size = session->opt->ekm_label_size;
+        ekm_size = session->opt->ekm_size;
+    }
+    else
+    {
+        ASSERT(0);
+    }
 
-            const char *key = format_hex_ex(ekm, size, len, 0, NULL, &gc);
-            setenv_str(session->opt->es, "exported_keying_material", key);
+    unsigned char *ekm = (unsigned char *) gc_malloc(ekm_size, true, gc);
 
-            dmsg(D_TLS_DEBUG_MED, "%s: exported keying material: %s",
-                 __func__, key);
-        }
-        else
-        {
-            msg(M_WARN, "WARNING: Export keying material failed!");
-            setenv_del(session->opt->es, "exported_keying_material");
-        }
-        gc_free(&gc);
+    if (SSL_export_keying_material(ssl->ssl, ekm, ekm_size, label,
+                                   label_size, NULL, 0, 0) == 1)
+    {
+        return ekm;
+    }
+    else
+    {
+        secure_memzero(ekm, ekm_size);
+        return NULL;
     }
 }
 
-- 
2.26.2


