From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 13:34:31 +0200
Message-Id: <20201023113431.26691-5-arne@...1227...>
In-Reply-To: <20201023113431.26691-1-arne@...1227...>
References: <20201023113431.26691-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 5/5] Remove NULL checks before calling free
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

We (and OpenSSL) already use calling free on null pointers in a number
of places and also C99 standards says free(NULL) does nothing.

The if (x) free(x) calls more often make code harder to read, instead
of easier, remove these NULL checks in favour of directly calling
free(x).

The OpenSSL *_free methods are also safe to call with NULL and
pkcs11h_certificate_freeCertificateIdList is also safe to be called with
NULL.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .../client-connect/sample-client-connect.c    |  5 +-
 src/openvpn/buffer.c                          |  5 +-
 src/openvpn/error.c                           |  7 +--
 src/openvpn/init.c                            | 11 ++---
 src/openvpn/manage.c                          | 37 +++++---------
 src/openvpn/mtcp.c                            |  5 +-
 src/openvpn/multi.c                           | 10 +---
 src/openvpn/packet_id.c                       |  5 +-
 src/openvpn/pkcs11.c                          | 49 ++++++-------------
 src/openvpn/pkcs11_openssl.c                  | 28 +++--------
 src/openvpn/proxy.c                           |  5 +-
 src/openvpn/ssl.c                             | 17 ++-----
 src/openvpn/ssl_mbedtls.c                     | 36 +++-----------
 src/openvpn/ssl_openssl.c                     | 47 ++++--------------
 src/openvpn/ssl_verify.c                      |  8 ++-
 src/openvpn/ssl_verify_openssl.c              |  6 +--
 src/openvpn/status.c                          |  6 +--
 src/openvpn/tun.c                             | 16 ++----
 src/plugins/auth-pam/auth-pam.c               |  5 +-
 src/plugins/down-root/down-root.c             |  5 +-
 20 files changed, 79 insertions(+), 234 deletions(-)

diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index 6168076f..7ed2f72c 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -173,10 +173,7 @@ openvpn_plugin_open_v3(const int v3structver,
     return OPENVPN_PLUGIN_FUNC_SUCCESS;
 
 error:
-    if (context)
-    {
-        free(context);
-    }
+    free(context);
     return OPENVPN_PLUGIN_FUNC_ERROR;
 }
 
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index b32bc8b2..35d9ecdc 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -184,10 +184,7 @@ buf_assign(struct buffer *dest, const struct buffer *src)
 void
 free_buf(struct buffer *buf)
 {
-    if (buf->data)
-    {
-        free(buf->data);
-    }
+    free(buf->data);
     CLEAR(*buf);
 }
 
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index d6247fec..7d0fcb2d 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -488,11 +488,8 @@ close_syslog(void)
     {
         closelog();
         use_syslog = false;
-        if (pgmname_syslog)
-        {
-            free(pgmname_syslog);
-            pgmname_syslog = NULL;
-        }
+        free(pgmname_syslog);
+        pgmname_syslog = NULL;
     }
 #endif
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fdd9a6cc..7a4bac58 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3600,14 +3600,9 @@ do_close_tls(struct context *c)
     }
 
     /* free options compatibility strings */
-    if (c->c2.options_string_local)
-    {
-        free(c->c2.options_string_local);
-    }
-    if (c->c2.options_string_remote)
-    {
-        free(c->c2.options_string_remote);
-    }
+    free(c->c2.options_string_local);
+    free(c->c2.options_string_remote);
+
     c->c2.options_string_local = c->c2.options_string_remote = NULL;
 
     if (c->c2.pulled_options_state)
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index ac142177..85bd1227 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -826,14 +826,8 @@ man_pkcs11_id_get(struct management *man, const int index)
         msg(M_CLIENT, ">PKCS11ID-ENTRY:'%d'", index);
     }
 
-    if (id != NULL)
-    {
-        free(id);
-    }
-    if (base64 != NULL)
-    {
-        free(base64);
-    }
+    free(id);
+    free(base64);
 }
 
 #endif /* ifdef ENABLE_PKCS11 */
@@ -2613,10 +2607,7 @@ man_connection_close(struct management *man)
 {
     struct man_connection *mc = &man->connection;
 
-    if (mc->es)
-    {
-        event_free(mc->es);
-    }
+    event_free(mc->es);
 #ifdef _WIN32
     net_event_win32_close(&mc->ne32);
 #endif
@@ -2629,14 +2620,10 @@ man_connection_close(struct management *man)
     {
         man_close_socket(man, mc->sd_cli);
     }
-    if (mc->in)
-    {
-        command_line_free(mc->in);
-    }
-    if (mc->out)
-    {
-        buffer_list_free(mc->out);
-    }
+
+    command_line_free(mc->in);
+    buffer_list_free(mc->out);
+
     in_extra_reset(&man->connection, IER_RESET);
     buffer_list_free(mc->ext_key_input);
     man_connection_clear(mc);
@@ -3896,6 +3883,10 @@ command_line_reset(struct command_line *cl)
 void
 command_line_free(struct command_line *cl)
 {
+    if (!cl)
+    {
+        return;
+    }
     command_line_reset(cl);
     free_buf(&cl->buf);
     free_buf(&cl->residual);
@@ -4015,10 +4006,8 @@ log_entry_print(const struct log_entry *e, unsigned int flags, struct gc_arena *
 static void
 log_entry_free_contents(struct log_entry *e)
 {
-    if (e->string)
-    {
-        free((char *)e->string);
-    }
+    /* Cast away constness of const char* */
+    free((char *)e->string);
     CLEAR(*e);
 }
 
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 458e6e4c..22c824aa 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -229,10 +229,7 @@ multi_tcp_free(struct multi_tcp *mtcp)
     if (mtcp)
     {
         event_free(mtcp->es);
-        if (mtcp->esr)
-        {
-            free(mtcp->esr);
-        }
+        free(mtcp->esr);
         free(mtcp);
     }
 }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 009b46fa..ad4ec1c2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -73,10 +73,7 @@ id(struct multi_instance *mi)
 static void
 set_cc_config(struct multi_instance *mi, struct buffer_list *cc_config)
 {
-    if (mi->cc_config)
-    {
-        buffer_list_free(mi->cc_config);
-    }
+    buffer_list_free(mi->cc_config);
     mi->cc_config = cc_config;
 }
 #endif
@@ -4016,10 +4013,7 @@ management_client_pf(void *arg,
         ret = pf_load_from_buffer_list(&mi->context, pf_config);
     }
 
-    if (pf_config)
-    {
-        buffer_list_free(pf_config);
-    }
+    buffer_list_free(pf_config);
     return ret;
 }
 #endif /* ifdef MANAGEMENT_PF */
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 0c744875..2b9ef079 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -103,10 +103,7 @@ packet_id_free(struct packet_id *p)
     if (p)
     {
         dmsg(D_PID_DEBUG, "PID packet_id_free");
-        if (p->rec.seq_list)
-        {
-            free(p->rec.seq_list);
-        }
+        free(p->rec.seq_list);
         CLEAR(*p);
     }
 }
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index d40ca458..52422918 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -461,11 +461,8 @@ pkcs11_management_id_count(void)
 
 cleanup:
 
-    if (id_list != NULL)
-    {
-        pkcs11h_certificate_freeCertificateIdList(id_list);
-        id_list = NULL;
-    }
+    pkcs11h_certificate_freeCertificateIdList(id_list);
+    id_list = NULL;
 
     dmsg(
         D_PKCS11_DEBUG,
@@ -630,29 +627,17 @@ pkcs11_management_id_get(
 
 cleanup:
 
-    if (id_list != NULL)
-    {
-        pkcs11h_certificate_freeCertificateIdList(id_list);
-        id_list = NULL;
-    }
+    pkcs11h_certificate_freeCertificateIdList(id_list);
+    id_list = NULL;
 
-    if (internal_id != NULL)
-    {
-        free(internal_id);
-        internal_id = NULL;
-    }
+    free(internal_id);
+    internal_id = NULL;
 
-    if (internal_base64 != NULL)
-    {
-        free(internal_base64);
-        internal_base64 = NULL;
-    }
+    free(internal_base64);
+    internal_base64 = NULL;
 
-    if (certificate_blob != NULL)
-    {
-        free(certificate_blob);
-        certificate_blob = NULL;
-    }
+    free(certificate_blob);
+    certificate_blob = NULL;
 
     dmsg(
         D_PKCS11_DEBUG,
@@ -1005,19 +990,13 @@ cleanup1:
             certificate = NULL;
         }
 
-        if (ser != NULL)
-        {
-            free(ser);
-            ser = NULL;
-        }
+        free(ser);
+        ser = NULL;
     }
 
 cleanup:
-    if (user_certificates != NULL)
-    {
-        pkcs11h_certificate_freeCertificateIdList(user_certificates);
-        user_certificates = NULL;
-    }
+    pkcs11h_certificate_freeCertificateIdList(user_certificates);
+    user_certificates = NULL;
 
     pkcs11h_terminate();
     gc_free(&gc);
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 642769cc..a84bc635 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -102,17 +102,11 @@ cleanup:
      * openssl objects have reference
      * count, so release them
      */
-    if (x509 != NULL)
-    {
-        X509_free(x509);
-        x509 = NULL;
-    }
+    X509_free(x509);
+    x509 = NULL;
 
-    if (evp != NULL)
-    {
-        EVP_PKEY_free(evp);
-        evp = NULL;
-    }
+    EVP_PKEY_free(evp);
+    evp = NULL;
 
     if (openssl_session != NULL)
     {
@@ -138,11 +132,8 @@ pkcs11_certificate_dn(pkcs11h_certificate_t certificate, struct gc_arena *gc)
     dn = x509_get_subject(x509, gc);
 
 cleanup:
-    if (x509 != NULL)
-    {
-        X509_free(x509);
-        x509 = NULL;
-    }
+    X509_free(x509);
+    x509 = NULL;
 
     return dn;
 }
@@ -183,12 +174,9 @@ pkcs11_certificate_serial(pkcs11h_certificate_t certificate, char *serial,
     ret = 0;
 
 cleanup:
+    X509_free(x509);
+    x509 = NULL;
 
-    if (x509 != NULL)
-    {
-        X509_free(x509);
-        x509 = NULL;
-    }
     return ret;
 }
 #endif /* defined(ENABLE_PKCS11) && defined(ENABLE_OPENSSL) */
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 9998623a..f390daed 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -366,10 +366,7 @@ get_proxy_authenticate(socket_descriptor_t sd,
 static void
 store_proxy_authenticate(struct http_proxy_info *p, char *data)
 {
-    if (p->proxy_authenticate)
-    {
-        free(p->proxy_authenticate);
-    }
+    free(p->proxy_authenticate);
     p->proxy_authenticate = data;
 }
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index f6f06fa9..53dad9ff 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1105,10 +1105,7 @@ tls_session_free(struct tls_session *session, bool clear)
         key_state_free(&session->key[i], false);
     }
 
-    if (session->common_name)
-    {
-        free(session->common_name);
-    }
+    free(session->common_name);
 
     cert_hash_free(session->cert_hash_set);
 
@@ -1297,16 +1294,8 @@ tls_multi_free(struct tls_multi *multi, bool clear)
     auth_set_client_reason(multi, NULL);
 
     free(multi->peer_info);
-
-    if (multi->locked_cn)
-    {
-        free(multi->locked_cn);
-    }
-
-    if (multi->locked_username)
-    {
-        free(multi->locked_username);
-    }
+    free(multi->locked_cn);
+    free(multi->locked_username);
 
     cert_hash_free(multi->locked_cert_hash_set);
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 11fbeae4..b30b6b9d 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -138,53 +138,31 @@ tls_ctx_free(struct tls_root_ctx *ctx)
     if (ctx)
     {
         mbedtls_pk_free(ctx->priv_key);
-        if (ctx->priv_key)
-        {
-            free(ctx->priv_key);
-        }
+        free(ctx->priv_key);
 
         mbedtls_x509_crt_free(ctx->ca_chain);
-        if (ctx->ca_chain)
-        {
-            free(ctx->ca_chain);
-        }
+        free(ctx->ca_chain);
 
         mbedtls_x509_crt_free(ctx->crt_chain);
-        if (ctx->crt_chain)
-        {
-            free(ctx->crt_chain);
-        }
+        free(ctx->crt_chain);
 
         mbedtls_dhm_free(ctx->dhm_ctx);
-        if (ctx->dhm_ctx)
-        {
-            free(ctx->dhm_ctx);
-        }
+        free(ctx->dhm_ctx);
 
         mbedtls_x509_crl_free(ctx->crl);
-        if (ctx->crl)
-        {
-            free(ctx->crl);
-        }
+        free(ctx->crl);
 
 #if defined(ENABLE_PKCS11)
         pkcs11h_certificate_freeCertificate(ctx->pkcs11_cert);
 #endif
 
-        if (ctx->allowed_ciphers)
-        {
-            free(ctx->allowed_ciphers);
-        }
+        free(ctx->allowed_ciphers);
 
-        if (ctx->groups)
-        {
-            free(ctx->groups);
-        }
+        free(ctx->groups);
 
         CLEAR(*ctx);
 
         ctx->initialised = false;
-
     }
 }
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 122083a8..d161f48b 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -144,10 +144,7 @@ void
 tls_ctx_free(struct tls_root_ctx *ctx)
 {
     ASSERT(NULL != ctx);
-    if (NULL != ctx->ctx)
-    {
-        SSL_CTX_free(ctx->ctx);
-    }
+    SSL_CTX_free(ctx->ctx);
     ctx->ctx = NULL;
 }
 
@@ -978,14 +975,8 @@ end:
         crypto_print_openssl_errors(M_DEBUG);
     }
 
-    if (in != NULL)
-    {
-        BIO_free(in);
-    }
-    if (x)
-    {
-        X509_free(x);
-    }
+    BIO_free(in);
+    X509_free(x);
 }
 
 int
@@ -1044,14 +1035,8 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
     ret = 0;
 
 end:
-    if (pkey)
-    {
-        EVP_PKEY_free(pkey);
-    }
-    if (in)
-    {
-        BIO_free(in);
-    }
+    EVP_PKEY_free(pkey);
+    BIO_free(in);
     return ret;
 }
 
@@ -1312,12 +1297,9 @@ err:
     {
         RSA_free(rsa);
     }
-    else
+    else if (rsa_meth)
     {
-        if (rsa_meth)
-        {
-            RSA_meth_free(rsa_meth);
-        }
+        RSA_meth_free(rsa_meth);
     }
     return 0;
 }
@@ -1441,14 +1423,8 @@ tls_ctx_use_external_ec_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)
 
 err:
     /* Reach here only when ec and privkey can be independenly freed */
-    if (privkey)
-    {
-        EVP_PKEY_free(privkey);
-    }
-    if (ec)
-    {
-        EC_KEY_free(ec);
-    }
+    EVP_PKEY_free(privkey);
+    EC_KEY_free(ec);
     return 0;
 }
 #endif /* OPENSSL_VERSION_NUMBER > 1.1.0 dev && !defined(OPENSSL_NO_EC) */
@@ -1645,10 +1621,7 @@ tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
             }
         }
 
-        if (in)
-        {
-            BIO_free(in);
-        }
+        BIO_free(in);
     }
 
     /* Set a store for certs (CA & CRL) with a lookup on the "capath" hash directory */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 2d7abdde..95d8c918 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -841,11 +841,9 @@ cleanup:
 void
 auth_set_client_reason(struct tls_multi *multi, const char *client_reason)
 {
-    if (multi->client_reason)
-    {
-        free(multi->client_reason);
-        multi->client_reason = NULL;
-    }
+    free(multi->client_reason);
+    multi->client_reason = NULL;
+
     if (client_reason && strlen(client_reason))
     {
         multi->client_reason = string_alloc(client_reason, NULL);
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 39d381a1..d063aeda 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -372,11 +372,7 @@ x509_get_subject(X509 *cert, struct gc_arena *gc)
     subject[subject_mem->length] = '\0';
 
 err:
-    if (subject_bio)
-    {
-        BIO_free(subject_bio);
-    }
-
+    BIO_free(subject_bio);
     return subject;
 }
 
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index e8dcf7cd..11e24ae4 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -203,10 +203,8 @@ status_close(struct status_output *so)
                 ret = false;
             }
         }
-        if (so->filename)
-        {
-            free(so->filename);
-        }
+        free(so->filename);
+
         if (buf_defined(&so->read_buf))
         {
             free_buf(&so->read_buf);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8315a426..400a50ca 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1835,10 +1835,8 @@ close_tun_generic(struct tuntap *tt)
     {
         close(tt->fd);
     }
-    if (tt->actual_name)
-    {
-        free(tt->actual_name);
-    }
+
+    free(tt->actual_name);
     clear_tuntap(tt);
 }
 #endif /* !_WIN32 */
@@ -2522,10 +2520,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 
     solaris_close_tun(tt);
 
-    if (tt->actual_name)
-    {
-        free(tt->actual_name);
-    }
+    free(tt->actual_name);
 
     clear_tuntap(tt);
     free(tt);
@@ -6901,10 +6896,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         }
     }
 
-    if (tt->actual_name)
-    {
-        free(tt->actual_name);
-    }
+    free(tt->actual_name);
 
     if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
     {
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index f537652e..3d167233 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -506,10 +506,7 @@ openvpn_plugin_open_v3(const int v3structver,
     }
 
 error:
-    if (context)
-    {
-        free(context);
-    }
+    free(context);
     return OPENVPN_PLUGIN_FUNC_ERROR;
 }
 
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index da445c61..7a3d34a0 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -238,10 +238,7 @@ free_context(struct down_root_context *context)
 {
     if (context)
     {
-        if (context->command)
-        {
-            free(context->command);
-        }
+        free(context->command);
         free(context);
     }
 }
-- 
2.26.2


