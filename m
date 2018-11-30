From: Gert Doering <gert@...1296...>
Date: Fri, 30 Nov 2018 14:56:41 +0100
Message-Id: <20181130135641.11533-3-gert@...1296...>
In-Reply-To: <20181130135641.11533-1-gert@...1296...>
References: <20181130135641.11533-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] uncrustify openvpn/ sources
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

There are an amazing number of brackets that were either
totally missing, or have snuck up on the "for(...){"
line.  Further, uncrustify wants "|" in multi-line
logical expressions now at the beginning of the new
line, and "PRIi64" now gets surrounding spaces.

Added "sp_after_semi_for_empty=Add" to uncrustify.conf
to leave a few for() statements alone that look better
the way they are.

Signed-off-by: Gert Doering <gert@...1296...>
---
 dev-tools/uncrustify.conf        |  3 ++
 src/openvpn/block_dns.h          |  4 +--
 src/openvpn/buffer.c             |  4 +--
 src/openvpn/buffer.h             |  1 +
 src/openvpn/console.h            |  2 +-
 src/openvpn/crypto.c             | 10 +++++--
 src/openvpn/crypto.h             |  5 ++--
 src/openvpn/crypto_backend.h     |  2 +-
 src/openvpn/crypto_mbedtls.c     |  7 +++--
 src/openvpn/crypto_mbedtls.h     |  3 +-
 src/openvpn/crypto_openssl.c     | 37 +++++++++++++------------
 src/openvpn/crypto_openssl.h     |  3 +-
 src/openvpn/cryptoapi.c          | 26 ++++++++++--------
 src/openvpn/env_set.c            |  2 +-
 src/openvpn/env_set.h            |  6 ++--
 src/openvpn/error.c              |  2 +-
 src/openvpn/event.c              |  4 +--
 src/openvpn/forward.c            |  4 +--
 src/openvpn/forward.h            |  2 ++
 src/openvpn/init.c               | 22 +++++++--------
 src/openvpn/integer.h            |  4 +--
 src/openvpn/manage.c             |  4 +--
 src/openvpn/mss.c                |  2 +-
 src/openvpn/multi.c              |  2 +-
 src/openvpn/multi.h              |  1 +
 src/openvpn/ntlm.c               |  4 +--
 src/openvpn/openssl_compat.h     | 47 ++++++++++++++++----------------
 src/openvpn/options.c            | 10 +++++--
 src/openvpn/otime.c              |  4 +--
 src/openvpn/packet_id.c          | 12 ++++----
 src/openvpn/packet_id.h          |  2 +-
 src/openvpn/ping.h               |  2 +-
 src/openvpn/plugin.c             |  3 +-
 src/openvpn/proxy.c              |  4 +--
 src/openvpn/reliable.c           |  4 +--
 src/openvpn/route.c              |  4 +--
 src/openvpn/run_command.c        |  6 ++--
 src/openvpn/shaper.c             |  2 +-
 src/openvpn/shaper.h             |  2 +-
 src/openvpn/socket.c             |  6 +++-
 src/openvpn/socket.h             |  2 +-
 src/openvpn/ssl.c                | 20 +++++++-------
 src/openvpn/ssl_common.h         |  4 +--
 src/openvpn/ssl_mbedtls.c        | 32 +++++++++++-----------
 src/openvpn/ssl_mbedtls.h        |  4 +--
 src/openvpn/ssl_openssl.c        | 32 +++++++++++-----------
 src/openvpn/ssl_verify.c         | 42 ++++++++++++++--------------
 src/openvpn/ssl_verify_backend.h |  1 +
 src/openvpn/ssl_verify_openssl.c |  7 +++--
 src/openvpn/tls_crypt.c          |  6 ++--
 src/openvpn/tls_crypt.h          |  6 ++--
 src/openvpn/tun.c                | 15 +++++-----
 src/openvpn/win32.c              |  2 +-
 53 files changed, 243 insertions(+), 204 deletions(-)

diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
index d8ea870e..25eb4cdd 100644
--- a/dev-tools/uncrustify.conf
+++ b/dev-tools/uncrustify.conf
@@ -60,6 +60,9 @@ mod_add_long_ifdef_else_comment=5
 # Misc cleanup
 mod_remove_extra_semicolon=true
 
+# leave blank at end of empty for() statements
+sp_after_semi_for_empty=Add
+
 # Use C-style comments (/* .. */)
 cmt_c_nl_end=true
 cmt_star_cont=true
diff --git a/src/openvpn/block_dns.h b/src/openvpn/block_dns.h
index 50b383f6..f9b1e5d0 100644
--- a/src/openvpn/block_dns.h
+++ b/src/openvpn/block_dns.h
@@ -65,5 +65,5 @@ DWORD
 set_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family,
                      const ULONG metric);
 
-#endif
-#endif
+#endif /* ifndef OPENVPN_BLOCK_DNS_H */
+#endif /* ifdef _WIN32 */
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 27c75271..2aae5c4c 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -312,7 +312,7 @@ openvpn_snprintf(char *str, size_t size, const char *format, ...)
 
 /*
  * openvpn_swprintf() is currently only used by Windows code paths
- * and when enabled for all platforms it will currently break older 
+ * and when enabled for all platforms it will currently break older
  * OpenBSD versions lacking vswprintf(3) support in their libc.
  */
 
@@ -474,7 +474,7 @@ x_gc_freespecial(struct gc_arena *a)
 }
 
 void
-gc_addspecial(void *addr, void(free_function)(void *), struct gc_arena *a)
+gc_addspecial(void *addr, void (free_function)(void *), struct gc_arena *a)
 {
     ASSERT(a);
     struct gc_entry_special *e;
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index d402d05b..a4fe6f9b 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -458,6 +458,7 @@ __attribute__ ((format(__printf__, 3, 4)))
  */
 bool
 openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...);
+
 /*
  * Unlike in openvpn_snprintf, we cannot use format attributes since
  * GCC doesn't support wprintf as archetype.
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 5a70e5fd..0ffd6683 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -21,7 +21,7 @@
  *  You should have received a copy of the GNU General Public License along
  *  with this program; if not, write to the Free Software Foundation, Inc.,
  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-*/
+ */
 
 #ifndef CONSOLE_H
 #define CONSOLE_H
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e9bf22b0..df6f36ca 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -920,10 +920,12 @@ key_is_zero(struct key *key, const struct key_type *kt)
 {
     int i;
     for (i = 0; i < kt->cipher_length; ++i)
+    {
         if (key->cipher[i])
         {
             return false;
         }
+    }
     msg(D_CRYPT_ERRORS, "CRYPTO INFO: WARNING: zero key detected");
     return true;
 }
@@ -1270,7 +1272,9 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
     {
         in = buffer_read_from_file(file, &gc);
         if (!buf_valid(&in))
+        {
             msg(M_FATAL, "Read error on key file ('%s')", file);
+        }
 
         size = in.len;
     }
@@ -1462,7 +1466,7 @@ write_key_file(const int nkeys, const char *filename)
     buf_printf(&out, "%s\n", static_key_foot);
 
     /* write key file, now formatted in out, to file */
-    if(!buffer_write_file(filename, &out))
+    if (!buffer_write_file(filename, &out))
     {
         nbits = -1;
     }
@@ -1692,7 +1696,9 @@ prng_reset_nonce(void)
     {
         int i;
         for (i = 0; i < size; ++i)
+        {
             nonce_data[i] = (uint8_t) i;
+        }
     }
 #endif
 }
@@ -1773,7 +1779,7 @@ void
 print_cipher(const cipher_kt_t *cipher)
 {
     const char *var_key_size = cipher_kt_var_key_size(cipher) ?
-        " by default" : "";
+                               " by default" : "";
 
     printf("%s  (%d bit key%s, ",
            translate_cipher_name_to_openvpn(cipher_kt_name(cipher)),
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 96ba8586..1edde2e3 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -318,7 +318,7 @@ void free_key_ctx(struct key_ctx *ctx);
 
 void init_key_ctx_bi(struct key_ctx_bi *ctx, const struct key2 *key2,
                      int key_direction, const struct key_type *kt,
-		     const char *name);
+                     const char *name);
 
 void free_key_ctx_bi(struct key_ctx_bi *ctx);
 
@@ -504,7 +504,8 @@ memcmp_constant_time(const void *a, const void *b, size_t size)
     int ret = 0;
     size_t i;
 
-    for (i = 0; i < size; i++) {
+    for (i = 0; i < size; i++)
+    {
         ret |= *a1++ ^ *b1++;
     }
 
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 38b2c175..a04e01f4 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -51,7 +51,7 @@
 typedef enum {
     MD_SHA1,
     MD_SHA256
-} hash_algo_type ;
+} hash_algo_type;
 
 /** Struct used in cipher name translation table */
 typedef struct {
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 77e84c3c..2e931440 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -233,8 +233,8 @@ crypto_pem_encode(const char *name, struct buffer *dst,
 
     size_t out_len = 0;
     if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL !=
-            mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src),
-                                     NULL, 0, &out_len))
+        mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src),
+                                 NULL, 0, &out_len))
     {
         return false;
     }
@@ -858,7 +858,8 @@ md_ctx_new(void)
     return ctx;
 }
 
-void md_ctx_free(mbedtls_md_context_t *ctx)
+void
+md_ctx_free(mbedtls_md_context_t *ctx)
 {
     free(ctx);
 }
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 81b542bc..c4b13b7b 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -146,7 +146,8 @@ mbed_log_func_line_lite(unsigned int flags, int errval,
 #define mbed_ok(errval) \
     mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
 
-static inline bool cipher_kt_var_key_size(const cipher_kt_t *cipher)
+static inline bool
+cipher_kt_var_key_size(const cipher_kt_t *cipher)
 {
     return cipher->flags & MBEDTLS_CIPHER_VARIABLE_KEY_LEN;
 }
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 0bff1a25..9691ce05 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -202,12 +202,12 @@ crypto_print_openssl_errors(const unsigned int flags)
         else if (ERR_GET_REASON(err) == SSL_R_UNSUPPORTED_PROTOCOL)
         {
             msg(D_CRYPT_ERRORS, "TLS error: Unsupported protocol. This typically "
-                 "indicates that client and server have no common TLS version enabled. "
-                 "This can be caused by mismatched tls-version-min and tls-version-max "
-                 "options on client and server. "
-                 "If your OpenVPN client is between v2.3.6 and v2.3.2 try adding "
-                 "tls-version-min 1.0 to the client configuration to use TLS 1.0+ "
-                 "instead of TLS 1.0 only");
+                "indicates that client and server have no common TLS version enabled. "
+                "This can be caused by mismatched tls-version-min and tls-version-max "
+                "options on client and server. "
+                "If your OpenVPN client is between v2.3.6 and v2.3.2 try adding "
+                "tls-version-min 1.0 to the client configuration to use TLS 1.0+ "
+                "instead of TLS 1.0 only");
         }
         msg(flags, "OpenSSL: %s", ERR_error_string(err, NULL));
     }
@@ -315,7 +315,8 @@ show_available_ciphers(void)
 
     qsort(cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_cmp);
 
-    for (i = 0; i < num_ciphers; i++) {
+    for (i = 0; i < num_ciphers; i++)
+    {
         if (!cipher_kt_insecure(cipher_list[i]))
         {
             print_cipher(cipher_list[i]);
@@ -324,7 +325,8 @@ show_available_ciphers(void)
 
     printf("\nThe following ciphers have a block size of less than 128 bits, \n"
            "and are therefore deprecated.  Do not use unless you have to.\n\n");
-    for (i = 0; i < num_ciphers; i++) {
+    for (i = 0; i < num_ciphers; i++)
+    {
         if (cipher_kt_insecure(cipher_list[i]))
         {
             print_cipher(cipher_list[i]);
@@ -405,7 +407,7 @@ crypto_pem_encode(const char *name, struct buffer *dst,
 cleanup:
     if (!BIO_free(bio))
     {
-        ret = false;;
+        ret = false;
     }
 
     return ret;
@@ -458,7 +460,7 @@ cleanup:
     OPENSSL_free(data_read);
     if (!BIO_free(bio))
     {
-        ret = false;;
+        ret = false;
     }
 
     return ret;
@@ -688,7 +690,7 @@ cipher_kt_insecure(const EVP_CIPHER *cipher)
 #ifdef NID_chacha20_poly1305
              || EVP_CIPHER_nid(cipher) == NID_chacha20_poly1305
 #endif
-            );
+             );
 }
 
 int
@@ -729,13 +731,13 @@ cipher_kt_mode_aead(const cipher_kt_t *cipher)
     {
         switch (EVP_CIPHER_nid(cipher))
         {
-        case NID_aes_128_gcm:
-        case NID_aes_192_gcm:
-        case NID_aes_256_gcm:
+            case NID_aes_128_gcm:
+            case NID_aes_192_gcm:
+            case NID_aes_256_gcm:
 #ifdef NID_chacha20_poly1305
-        case NID_chacha20_poly1305:
+            case NID_chacha20_poly1305:
 #endif
-            return true;
+                return true;
         }
     }
 #endif
@@ -962,7 +964,8 @@ md_ctx_new(void)
     return ctx;
 }
 
-void md_ctx_free(EVP_MD_CTX *ctx)
+void
+md_ctx_free(EVP_MD_CTX *ctx)
 {
     EVP_MD_CTX_free(ctx);
 }
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 1ea3e858..64754480 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -101,7 +101,8 @@ void crypto_print_openssl_errors(const unsigned int flags);
         msg((flags), __VA_ARGS__); \
     } while (false)
 
-static inline bool cipher_kt_var_key_size(const cipher_kt_t *cipher)
+static inline bool
+cipher_kt_var_key_size(const cipher_kt_t *cipher)
 {
     return EVP_CIPHER_flags(cipher) & EVP_CIPH_VARIABLE_LENGTH;
 }
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index fa057cb2..9687d8c2 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -159,7 +159,8 @@ ms_error_text(DWORD ms_err)
         /* trim to the left */
         if (rv)
         {
-            for (p = rv + strlen(rv) - 1; p >= rv; p--) {
+            for (p = rv + strlen(rv) - 1; p >= rv; p--)
+            {
                 if (isspace(*p))
                 {
                     *p = '\0';
@@ -198,7 +199,8 @@ err_put_ms_error(DWORD ms_err, int func, const char *file, int line)
     }
     /* since MS error codes are 32 bit, and the ones in the ERR_... system is
      * only 12, we must have a mapping table between them.  */
-    for (i = 0; i < ERR_MAP_SZ; i++) {
+    for (i = 0; i < ERR_MAP_SZ; i++)
+    {
         if (err_map[i].ms_err == ms_err)
         {
             ERR_PUT_error(ERR_LIB_CRYPTOAPI, func, err_map[i].err, file, line);
@@ -267,8 +269,8 @@ priv_enc_CNG(const CAPI_DATA *cd, const wchar_t *hash_algo, const unsigned char
     BCRYPT_PKCS1_PADDING_INFO padinfo = {hash_algo};
     DWORD status;
 
-    status = NCryptSignHash(hkey, padding? &padinfo : NULL, (BYTE*) from, flen,
-                            to, tlen, &len, padding? BCRYPT_PAD_PKCS1 : 0);
+    status = NCryptSignHash(hkey, padding ? &padinfo : NULL, (BYTE *) from, flen,
+                            to, tlen, &len, padding ? BCRYPT_PAD_PKCS1 : 0);
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
@@ -375,7 +377,7 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
  */
 static int
 rsa_sign_CNG(int type, const unsigned char *m, unsigned int m_len,
-              unsigned char *sig, unsigned int *siglen, const RSA *rsa)
+             unsigned char *sig, unsigned int *siglen, const RSA *rsa)
 {
     CAPI_DATA *cd = (CAPI_DATA *) RSA_meth_get0_app_data(RSA_get_method(rsa));
     const wchar_t *alg = NULL;
@@ -419,6 +421,7 @@ rsa_sign_CNG(int type, const unsigned char *m, unsigned int m_len,
             /* No DigestInfo header is required -- set alg-name to NULL */
             alg = NULL;
             break;
+
         default:
             msg(M_WARN, "cryptoapicert: Unknown hash type NID=0x%x", type);
             RSAerr(RSA_F_RSA_SIGN, RSA_R_UNKNOWN_ALGORITHM_TYPE);
@@ -459,7 +462,7 @@ finish(RSA *rsa)
         return 0;
     }
     CAPI_DATA_free(cd);
-    RSA_meth_free((RSA_METHOD*) rsa_meth);
+    RSA_meth_free((RSA_METHOD *) rsa_meth);
     return 1;
 }
 
@@ -586,7 +589,7 @@ ssl_ctx_set_eckey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, EVP_PKEY *pkey)
     if (cd->key_spec != CERT_NCRYPT_KEY_SPEC)
     {
         msg(M_NONFATAL, "ERROR: cryptoapicert with only legacy private key handle available."
-                    " EC certificate not supported.");
+            " EC certificate not supported.");
         goto err;
     }
     /* create a method struct with default callbacks filled in */
@@ -686,7 +689,8 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
 
         /* skip the tag */
         cert_prop += 6;
-        for (p = (char *) cert_prop, i = 0; *p && i < sizeof(hash); i++) {
+        for (p = (char *) cert_prop, i = 0; *p && i < sizeof(hash); i++)
+        {
             if (*p >= '0' && *p <= '9')
             {
                 x = (*p - '0') << 4;
@@ -739,7 +743,7 @@ ssl_ctx_set_rsakey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, EVP_PKEY *pkey)
     bool rsa_method_set = false;
 
     my_rsa_method = RSA_meth_new("Microsoft Cryptography API RSA Method",
-                                  RSA_METHOD_FLAG_NO_CHECK);
+                                 RSA_METHOD_FLAG_NO_CHECK);
     check_malloc_return(my_rsa_method);
     RSA_meth_set_pub_enc(my_rsa_method, rsa_pub_enc);
     RSA_meth_set_pub_dec(my_rsa_method, rsa_pub_dec);
@@ -797,7 +801,7 @@ ssl_ctx_set_rsakey(SSL_CTX *ssl_ctx, CAPI_DATA *cd, EVP_PKEY *pkey)
         goto err;
     }
     /* SSL_CTX_use_RSAPrivateKey() increased the reference count in 'rsa', so
-     * we decrease it here with RSA_free(), or it will never be cleaned up. */
+    * we decrease it here with RSA_free(), or it will never be cleaned up. */
     RSA_free(rsa);
     return 1;
 
@@ -867,7 +871,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     DWORD flags = CRYPT_ACQUIRE_COMPARE_KEY_FLAG
                   | CRYPT_ACQUIRE_PREFER_NCRYPT_KEY_FLAG;
     if (!CryptAcquireCertificatePrivateKey(cd->cert_context, flags, NULL,
-                    &cd->crypt_prov, &cd->key_spec, &cd->free_crypt_prov))
+                                           &cd->crypt_prov, &cd->key_spec, &cd->free_crypt_prov))
     {
         /* if we don't have a smart card reader here, and we try to access a
          * smart card certificate, we get:
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index e7fb2d83..0ab0262a 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -277,7 +277,7 @@ void
 setenv_long_long(struct env_set *es, const char *name, long long value)
 {
     char buf[64];
-    openvpn_snprintf(buf, sizeof(buf), "%"PRIi64, (int64_t)value);
+    openvpn_snprintf(buf, sizeof(buf), "%" PRIi64, (int64_t)value);
     setenv_str(es, name, buf);
 }
 
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index 5dc33485..cf8415cc 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -94,13 +94,15 @@ void env_set_print(int msglevel, const struct env_set *es);
 void env_set_inherit(struct env_set *es, const struct env_set *src);
 
 /* returns true if environmental variable name starts with 'password' */
-static inline bool is_password_env_var(const char *str)
+static inline bool
+is_password_env_var(const char *str)
 {
     return (strncmp(str, "password", 8) == 0);
 }
 
 /* returns true if environmental variable safe to print to log */
-static inline bool env_safe_to_print(const char *str)
+static inline bool
+env_safe_to_print(const char *str)
 {
 #ifndef UNSAFE_DEBUG
     if (is_password_env_var(str))
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 51294687..b2492f2b 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -343,7 +343,7 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
                 struct timeval tv;
                 gettimeofday(&tv, NULL);
 
-                fprintf(fp, "%"PRIi64".%06ld %x %s%s%s%s",
+                fprintf(fp, "%" PRIi64 ".%06ld %x %s%s%s%s",
                         (int64_t)tv.tv_sec,
                         (long)tv.tv_usec,
                         flags,
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 37276905..49dfa861 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -1041,7 +1041,7 @@ se_wait_fast(struct event_set *es, const struct timeval *tv, struct event_set_re
     struct timeval tv_tmp = *tv;
     int stat;
 
-    dmsg(D_EVENT_WAIT, "SE_WAIT_FAST maxfd=%d tv=%"PRIi64"/%ld",
+    dmsg(D_EVENT_WAIT, "SE_WAIT_FAST maxfd=%d tv=%" PRIi64 "/%ld",
          ses->maxfd,
          (int64_t)tv_tmp.tv_sec,
          (long)tv_tmp.tv_usec);
@@ -1065,7 +1065,7 @@ se_wait_scalable(struct event_set *es, const struct timeval *tv, struct event_se
     fd_set write = ses->writefds;
     int stat;
 
-    dmsg(D_EVENT_WAIT, "SE_WAIT_SCALEABLE maxfd=%d tv=%"PRIi64"/%ld",
+    dmsg(D_EVENT_WAIT, "SE_WAIT_SCALEABLE maxfd=%d tv=%" PRIi64 "/%ld",
          ses->maxfd, (int64_t)tv_tmp.tv_sec, (long)tv_tmp.tv_usec);
 
     stat = select(ses->maxfd + 1, &read, &write, NULL, &tv_tmp);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f8faa810..37719dbe 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -757,7 +757,7 @@ static void
 process_coarse_timers(struct context *c)
 {
     /* flush current packet-id to file once per 60
-     * seconds if --replay-persist was specified */
+    * seconds if --replay-persist was specified */
     check_packet_id_persist_flush(c);
 
     /* should we update status file? */
@@ -836,7 +836,7 @@ check_coarse_timers_dowork(struct context *c)
     process_coarse_timers(c);
     c->c2.coarse_timer_wakeup = now + c->c2.timeval.tv_sec;
 
-    dmsg(D_INTERVAL, "TIMER: coarse timer wakeup %"PRIi64" seconds", (int64_t)c->c2.timeval.tv_sec);
+    dmsg(D_INTERVAL, "TIMER: coarse timer wakeup %" PRIi64 " seconds", (int64_t)c->c2.timeval.tv_sec);
 
     /* Is the coarse timeout NOT the earliest one? */
     if (c->c2.timeval.tv_sec > save.tv_sec)
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 58b75d64..b534c723 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -80,10 +80,12 @@ void check_incoming_control_channel_dowork(struct context *c);
 void check_scheduled_exit_dowork(struct context *c);
 
 void check_push_request_dowork(struct context *c);
+
 #endif /* P2MP */
 
 #ifdef ENABLE_FRAGMENT
 void check_fragment_dowork(struct context *c);
+
 #endif /* ENABLE_FRAGMENT */
 
 void check_connection_established_dowork(struct context *c);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2a1b38ea..a1841604 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1077,13 +1077,13 @@ do_genkey(const struct options *options)
     }
     if (options->tls_crypt_v2_genkey_type)
     {
-        if(!strcmp(options->tls_crypt_v2_genkey_type, "server"))
+        if (!strcmp(options->tls_crypt_v2_genkey_type, "server"))
         {
             tls_crypt_v2_write_server_key_file(options->tls_crypt_v2_genkey_file);
             return true;
         }
         if (options->tls_crypt_v2_genkey_type
-                 && !strcmp(options->tls_crypt_v2_genkey_type, "client"))
+            && !strcmp(options->tls_crypt_v2_genkey_type, "client"))
         {
             if (!options->tls_crypt_v2_file)
             {
@@ -1091,8 +1091,8 @@ do_genkey(const struct options *options)
             }
 
             tls_crypt_v2_write_client_key_file(options->tls_crypt_v2_genkey_file,
-                    options->tls_crypt_v2_metadata, options->tls_crypt_v2_file,
-                    options->tls_crypt_v2_inline);
+                                               options->tls_crypt_v2_metadata, options->tls_crypt_v2_file,
+                                               options->tls_crypt_v2_inline);
             return true;
         }
 
@@ -2570,8 +2570,8 @@ do_init_tls_wrap_key(struct context *c)
         if (!streq(options->authname, "none"))
         {
             c->c1.ks.tls_auth_key_type.digest = md_kt_get(options->authname);
-                c->c1.ks.tls_auth_key_type.hmac_length =
-                    md_kt_size(c->c1.ks.tls_auth_key_type.digest);
+            c->c1.ks.tls_auth_key_type.hmac_length =
+                md_kt_size(c->c1.ks.tls_auth_key_type.digest);
         }
         else
         {
@@ -2655,7 +2655,7 @@ do_init_crypto_tls_c1(struct context *c)
             return;
 #else  /* if P2MP */
             msg(M_FATAL, "Error: private key password verification failed");
-#endif
+#endif /* if P2MP */
         }
 
         /* Get cipher & hash algorithms */
@@ -2763,15 +2763,15 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     {
         /* Add 10% jitter to reneg-sec by default (server side only) */
         int auto_jitter = options->mode != MODE_SERVER ? 0 :
-                get_random() % max_int(options->renegotiate_seconds / 10, 1);
+                          get_random() % max_int(options->renegotiate_seconds / 10, 1);
         to.renegotiate_seconds = options->renegotiate_seconds - auto_jitter;
     }
     else
     {
         /* Add user-specified jitter to reneg-sec */
-        to.renegotiate_seconds = options->renegotiate_seconds -
-                (get_random() % max_int(options->renegotiate_seconds
-                                        - options->renegotiate_seconds_min, 1));
+        to.renegotiate_seconds = options->renegotiate_seconds
+                                 -(get_random() % max_int(options->renegotiate_seconds
+                                                          - options->renegotiate_seconds_min, 1));
     }
     to.single_session = options->single_session;
     to.mode = options->mode;
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index b1ae0eda..3755f43f 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -28,12 +28,12 @@
 
 #ifndef htonll
 #define htonll(x) ((1==htonl(1)) ? (x) : \
-                  ((uint64_t)htonl((x) & 0xFFFFFFFF) << 32) | htonl((x) >> 32))
+                   ((uint64_t)htonl((x) & 0xFFFFFFFF) << 32) | htonl((x) >> 32))
 #endif
 
 #ifndef ntohll
 #define ntohll(x) ((1==ntohl(1)) ? (x) : \
-                  ((uint64_t)ntohl((x) & 0xFFFFFFFF) << 32) | ntohl((x) >> 32))
+                   ((uint64_t)ntohl((x) & 0xFFFFFFFF) << 32) | ntohl((x) >> 32))
 #endif
 
 /*
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 8b633f20..2d86dad4 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3640,7 +3640,7 @@ management_query_multiline_flatten(struct management *man,
 char *
 /* returns allocated base64 signature */
 management_query_pk_sig(struct management *man,
-                         const char *b64_data)
+                        const char *b64_data)
 {
     const char *prompt = "PK_SIGN";
     const char *desc = "pk-sign";
@@ -3650,7 +3650,7 @@ management_query_pk_sig(struct management *man,
         desc = "rsa-sign";
     }
     return management_query_multiline_flatten(man, b64_data, prompt, desc,
-            &man->connection.ext_key_state, &man->connection.ext_key_input);
+                                              &man->connection.ext_key_state, &man->connection.ext_key_input);
 }
 
 char *
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index facdf7b5..b0e2c42b 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -150,7 +150,7 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
 
     if (BLEN(buf) < (int) sizeof(struct openvpn_tcphdr))
     {
-	return;
+        return;
     }
 
     verify_align_4(buf);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 8440f311..53d6f0cf 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2394,7 +2394,7 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
         multi_set_pending(m, ANY_OUT(&mi->context) ? mi : NULL);
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
-        printf("POST %s[%d] to=%d lo=%d/%d w=%"PRIi64"/%ld\n",
+        printf("POST %s[%d] to=%d lo=%d/%d w=%" PRIi64 "/%ld\n",
                id(mi),
                (int) (mi == m->pending),
                mi ? mi->context.c2.to_tun.len : -1,
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3d3d6875..7216865e 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -537,6 +537,7 @@ clear_prefix(void)
 #define MULTI_CACHE_ROUTE_TTL 60
 
 void multi_reap_process_dowork(const struct multi_context *m);
+
 void multi_process_per_second_timers_dowork(struct multi_context *m);
 
 static inline void
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 077fa3e2..e3707484 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -314,8 +314,8 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
          * byte order on the wire for the NTLM header is LE.
          */
         const size_t hoff = 0x14;
-        unsigned long flags = buf2[hoff] | (buf2[hoff + 1] << 8) |
-                              (buf2[hoff + 2] << 16) | (buf2[hoff + 3] << 24);
+        unsigned long flags = buf2[hoff] | (buf2[hoff + 1] << 8)
+                              |(buf2[hoff + 2] << 16) | (buf2[hoff + 3] << 24);
         if ((flags & 0x00800000) == 0x00800000)
         {
             tib_len = buf2[0x28];            /* Get Target Information block size */
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 9560b29f..a4072b9a 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -193,8 +193,8 @@ X509_get0_pubkey(const X509 *x)
  * @param store              X509 object store
  * @return                   the X509 object stack
  */
-static inline STACK_OF(X509_OBJECT) *
-X509_STORE_get0_objects(X509_STORE *store)
+static inline STACK_OF(X509_OBJECT)
+*X509_STORE_get0_objects(X509_STORE *store)
 {
     return store ? store->objs : NULL;
 }
@@ -369,7 +369,7 @@ RSA_set0_key(RSA *rsa, BIGNUM *n, BIGNUM *e, BIGNUM *d)
 
     return 1;
 }
-#endif
+#endif /* if !defined(HAVE_RSA_SET0_KEY) */
 
 #if !defined(HAVE_RSA_BITS)
 /**
@@ -483,9 +483,9 @@ RSA_meth_free(RSA_METHOD *meth)
  */
 static inline int
 RSA_meth_set_pub_enc(RSA_METHOD *meth,
-                     int (*pub_enc) (int flen, const unsigned char *from,
-                                     unsigned char *to, RSA *rsa,
-                                     int padding))
+                     int (*pub_enc)(int flen, const unsigned char *from,
+                                    unsigned char *to, RSA *rsa,
+                                    int padding))
 {
     if (meth)
     {
@@ -506,9 +506,9 @@ RSA_meth_set_pub_enc(RSA_METHOD *meth,
  */
 static inline int
 RSA_meth_set_pub_dec(RSA_METHOD *meth,
-                     int (*pub_dec) (int flen, const unsigned char *from,
-                                     unsigned char *to, RSA *rsa,
-                                     int padding))
+                     int (*pub_dec)(int flen, const unsigned char *from,
+                                    unsigned char *to, RSA *rsa,
+                                    int padding))
 {
     if (meth)
     {
@@ -529,9 +529,9 @@ RSA_meth_set_pub_dec(RSA_METHOD *meth,
  */
 static inline int
 RSA_meth_set_priv_enc(RSA_METHOD *meth,
-                      int (*priv_enc) (int flen, const unsigned char *from,
-                                       unsigned char *to, RSA *rsa,
-                                       int padding))
+                      int (*priv_enc)(int flen, const unsigned char *from,
+                                      unsigned char *to, RSA *rsa,
+                                      int padding))
 {
     if (meth)
     {
@@ -552,9 +552,9 @@ RSA_meth_set_priv_enc(RSA_METHOD *meth,
  */
 static inline int
 RSA_meth_set_priv_dec(RSA_METHOD *meth,
-                      int (*priv_dec) (int flen, const unsigned char *from,
-                                       unsigned char *to, RSA *rsa,
-                                       int padding))
+                      int (*priv_dec)(int flen, const unsigned char *from,
+                                      unsigned char *to, RSA *rsa,
+                                      int padding))
 {
     if (meth)
     {
@@ -574,7 +574,7 @@ RSA_meth_set_priv_dec(RSA_METHOD *meth,
  * @return                   1 on success, 0 on error
  */
 static inline int
-RSA_meth_set_init(RSA_METHOD *meth, int (*init) (RSA *rsa))
+RSA_meth_set_init(RSA_METHOD *meth, int (*init)(RSA *rsa))
 {
     if (meth)
     {
@@ -594,11 +594,12 @@ RSA_meth_set_init(RSA_METHOD *meth, int (*init) (RSA *rsa))
  * @return                   1 on success, 0 on error
  */
 static inline
-int RSA_meth_set_sign(RSA_METHOD *meth,
-                      int (*sign) (int type, const unsigned char *m,
-                                   unsigned int m_length,
-                                   unsigned char *sigret, unsigned int *siglen,
-                                   const RSA *rsa))
+int
+RSA_meth_set_sign(RSA_METHOD *meth,
+                  int (*sign)(int type, const unsigned char *m,
+                              unsigned int m_length,
+                              unsigned char *sigret, unsigned int *siglen,
+                              const RSA *rsa))
 {
     meth->rsa_sign = sign;
     return 1;
@@ -614,7 +615,7 @@ int RSA_meth_set_sign(RSA_METHOD *meth,
  * @return                   1 on success, 0 on error
  */
 static inline int
-RSA_meth_set_finish(RSA_METHOD *meth, int (*finish) (RSA *rsa))
+RSA_meth_set_finish(RSA_METHOD *meth, int (*finish)(RSA *rsa))
 {
     if (meth)
     {
@@ -669,7 +670,7 @@ RSA_meth_get0_app_data(const RSA_METHOD *meth)
 static inline int
 EC_GROUP_order_bits(const EC_GROUP *group)
 {
-    BIGNUM* order = BN_new();
+    BIGNUM *order = BN_new();
     EC_GROUP_get_order(group, order, NULL);
     int bits = BN_num_bits(order);
     BN_free(order);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9ee1836b..6d53dea5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2134,7 +2134,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
             "passwords is STRONGLY discouraged and considered insecure");
     }
 
-#endif
+#endif /* ifdef ENABLE_MANAGEMENT */
 
     /*
      * Windows-specific options.
@@ -2859,8 +2859,10 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         {
             struct buffer in = buffer_read_from_file(o->tls_auth_file, &o->gc);
             if (!buf_valid(&in))
+            {
                 msg(M_FATAL, "Cannot pre-load tls-auth keyfile (%s)",
                     o->tls_auth_file);
+            }
 
             ce->tls_auth_file = INLINE_FILE_TAG;
             ce->tls_auth_file_inline = (char *)in.data;
@@ -2870,8 +2872,10 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         {
             struct buffer in = buffer_read_from_file(o->tls_crypt_file, &o->gc);
             if (!buf_valid(&in))
+            {
                 msg(M_FATAL, "Cannot pre-load tls-crypt keyfile (%s)",
                     o->tls_auth_file);
+            }
 
             ce->tls_crypt_file = INLINE_FILE_TAG;
             ce->tls_crypt_inline = (char *)in.data;
@@ -3040,7 +3044,7 @@ options_postprocess_mutate(struct options *o)
     {
         /* DH file is only meaningful in a tls-server context. */
         msg(M_WARN, "WARNING: Ignoring option 'dh' in tls-client mode, please only "
-                    "include this in your server configuration");
+            "include this in your server configuration");
         o->dh_file = NULL;
     }
 
@@ -7146,7 +7150,7 @@ add_option(struct options *options,
         {
             if (strstr(p[2], ":"))
             {
-                ipv6dns=true;
+                ipv6dns = true;
                 foreign_option(options, p, 3, es);
                 dhcp_option_dns6_parse(p[2], o->dns6, &o->dns6_len, msglevel);
             }
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index e0b1b0ee..759a7fb5 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -88,7 +88,7 @@ const char *
 tv_string(const struct timeval *tv, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(64, gc);
-    buf_printf(&out, "[%"PRIi64"/%ld]",
+    buf_printf(&out, "[%" PRIi64 "/%ld]",
                (int64_t)tv->tv_sec,
                (long)tv->tv_usec);
     return BSTR(&out);
@@ -198,7 +198,7 @@ time_test(void)
         t = time(NULL);
         gettimeofday(&tv, NULL);
 #if 1
-        msg(M_INFO, "t=%"PRIi64" s=%"PRIi64" us=%ld",
+        msg(M_INFO, "t=%" PRIi64 " s=%" PRIi64 " us=%ld",
             (int64_t)t,
             (int64_t)tv.tv_sec,
             (long)tv.tv_usec);
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index dc44f36b..0c744875 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -347,7 +347,7 @@ packet_id_send_update(struct packet_id_send *p, bool long_form)
 
 bool
 packet_id_write(struct packet_id_send *p, struct buffer *buf, bool long_form,
-        bool prepend)
+                bool prepend)
 {
     if (!packet_id_send_update(p, long_form))
     {
@@ -606,13 +606,13 @@ packet_id_debug_print(int msglevel,
         }
         buf_printf(&out, "%c", c);
     }
-    buf_printf(&out, "] %"PRIi64":" packet_id_format, (int64_t)p->time, (packet_id_print_type)p->id);
+    buf_printf(&out, "] %" PRIi64 ":" packet_id_format, (int64_t)p->time, (packet_id_print_type)p->id);
     if (pin)
     {
-        buf_printf(&out, " %"PRIi64":" packet_id_format, (int64_t)pin->time, (packet_id_print_type)pin->id);
+        buf_printf(&out, " %" PRIi64 ":" packet_id_format, (int64_t)pin->time, (packet_id_print_type)pin->id);
     }
 
-    buf_printf(&out, " t=%"PRIi64"[%d]",
+    buf_printf(&out, " t=%" PRIi64 "[%d]",
                (int64_t)prev_now,
                (int)(prev_now - tv.tv_sec));
 
@@ -666,7 +666,7 @@ packet_id_interactive_test(void)
         {
             packet_id_reap_test(&pid.rec);
             test = packet_id_test(&pid.rec, &pin);
-            printf("packet_id_test (%"PRIi64", " packet_id_format ") returned %d\n",
+            printf("packet_id_test (%" PRIi64 ", " packet_id_format ") returned %d\n",
                    (int64_t)pin.time,
                    (packet_id_print_type)pin.id,
                    test);
@@ -679,7 +679,7 @@ packet_id_interactive_test(void)
         {
             long_form = (count < 20);
             packet_id_alloc_outgoing(&pid.send, &pin, long_form);
-            printf("(%"PRIi64"(" packet_id_format "), %d)\n",
+            printf("(%" PRIi64 "(" packet_id_format "), %d)\n",
                    (int64_t)pin.time,
                    (packet_id_print_type)pin.id,
                    long_form);
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index ec03e348..26b07975 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -263,7 +263,7 @@ bool packet_id_read(struct packet_id_net *pin, struct buffer *buf, bool long_for
  * @return true if successful, false otherwise.
  */
 bool packet_id_write(struct packet_id_send *p, struct buffer *buf,
-        bool long_form, bool prepend);
+                     bool long_form, bool prepend);
 
 /*
  * Inline functions.
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index a196b32b..b51f082a 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -84,4 +84,4 @@ check_ping_send(struct context *c)
     }
 }
 
-#endif
+#endif /* ifndef PING_H */
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 4d17c821..33687d44 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -552,8 +552,7 @@ plugin_call_item(const struct plugin *p,
                                                         p->plugin_handle,
                                                         per_client_context,
                                                         (current_cert ? certdepth : -1),
-                                                        current_cert
-            };
+                                                        current_cert};
 
             struct openvpn_plugin_args_func_return retargs;
 
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index fdad3ed5..c8bd86dd 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -884,10 +884,10 @@ establish_http_proxy_passthru(struct http_proxy_info *p,
                 const char *algor = get_pa_var("algorithm", pa, &gc);
                 const char *opaque = get_pa_var("opaque", pa, &gc);
 
-                if ( !realm || !nonce )
+                if (!realm || !nonce)
                 {
                     msg(D_LINK_ERRORS, "HTTP proxy: digest auth failed, malformed response "
-                            "from server: realm= or nonce= missing" );
+                        "from server: realm= or nonce= missing" );
                     goto error;
                 }
 
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index a7f4ed96..eae1e0cb 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -762,14 +762,14 @@ reliable_debug_print(const struct reliable *rel, char *desc)
     printf("********* struct reliable %s\n", desc);
     printf("  initial_timeout=%d\n", (int)rel->initial_timeout);
     printf("  packet_id=" packet_id_format "\n", rel->packet_id);
-    printf("  now=%"PRIi64"\n", (int64_t)now);
+    printf("  now=%" PRIi64 "\n", (int64_t)now);
     for (i = 0; i < rel->size; ++i)
     {
         const struct reliable_entry *e = &rel->array[i];
         if (e->active)
         {
             printf("  %d: packet_id=" packet_id_format " len=%d", i, e->packet_id, e->buf.len);
-            printf(" next_try=%"PRIi64, (int64_t)e->next_try);
+            printf(" next_try=%" PRIi64, (int64_t)e->next_try);
             printf("\n");
         }
     }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d97e8dba..346f08e2 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3074,7 +3074,7 @@ do_route_ipv6_service(const bool add, const struct route_ipv6 *r, const struct t
      * (only do this for routes actually using the tun/tap device)
      */
     if (tt->type == DEV_TYPE_TUN
-	 && msg.iface.index == tt->adapter_index )
+        && msg.iface.index == tt->adapter_index)
     {
         inet_pton(AF_INET6, "fe80::8", &msg.gateway.ipv6);
     }
@@ -3298,7 +3298,7 @@ get_default_gateway(struct route_gateway_info *rgi)
                 if (rgi->flags & RGI_ON_LINK)
                 {
                     /* check that interface name of current interface
-                     * matches interface name of best default route */
+                    * matches interface name of best default route */
                     if (strcmp(ifreq.ifr_name, best_name))
                     {
                         continue;
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 4e198676..04ad2312 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -41,12 +41,14 @@
 /* contains an SSEC_x value defined in platform.h */
 static int script_security_level = SSEC_BUILT_IN; /* GLOBAL */
 
-int script_security(void)
+int
+script_security(void)
 {
     return script_security_level;
 }
 
-void script_security_set(int level)
+void
+script_security_set(int level)
 {
     script_security_level = level;
 }
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index 92364f29..62579840 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -76,7 +76,7 @@ shaper_soonest_event(struct timeval *tv, int delay)
         }
     }
 #ifdef SHAPER_DEBUG
-    dmsg(D_SHAPER_DEBUG, "SHAPER shaper_soonest_event sec=%"PRIi64" usec=%ld ret=%d",
+    dmsg(D_SHAPER_DEBUG, "SHAPER shaper_soonest_event sec=%" PRIi64 " usec=%ld ret=%d",
          (int64_t)tv->tv_sec, (long)tv->tv_usec, (int)ret);
 #endif
     return ret;
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index 4efe398a..bcdb5e36 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -147,7 +147,7 @@ shaper_wrote_bytes(struct shaper *s, int nbytes)
         tv_add(&s->wakeup, &tv);
 
 #ifdef SHAPER_DEBUG
-        dmsg(D_SHAPER_DEBUG, "SHAPER shaper_wrote_bytes bytes=%d delay=%ld sec=%"PRIi64" usec=%ld",
+        dmsg(D_SHAPER_DEBUG, "SHAPER shaper_wrote_bytes bytes=%d delay=%ld sec=%" PRIi64 " usec=%ld",
              nbytes,
              (long)tv.tv_usec,
              (int64_t)s->wakeup.tv_sec,
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 3f2b97e4..db944245 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -100,10 +100,12 @@ get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,
             bits = 0;
             max_bits = sizeof(in_addr_t) * 8;
             break;
+
         case AF_INET6:
             bits = 64;
             max_bits = sizeof(struct in6_addr) * 8;
             break;
+
         default:
             msg(M_WARN,
                 "Unsupported AF family passed to getaddrinfo for %s (%d)",
@@ -125,7 +127,7 @@ get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,
     }
 
     /* check if this hostname has a /bits suffix */
-    sep = strchr(var_host , '/');
+    sep = strchr(var_host, '/');
     if (sep)
     {
         bits = strtoul(sep + 1, &endp, 10);
@@ -156,10 +158,12 @@ get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,
                     *ip4 = ntohl(*ip4);
                 }
                 break;
+
             case AF_INET6:
                 ip6 = network;
                 *ip6 = ((struct sockaddr_in6 *)ai->ai_addr)->sin6_addr;
                 break;
+
             default:
                 /* can't get here because 'af' was previously checked */
                 msg(M_WARN,
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 0f22d479..17801418 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -138,7 +138,7 @@ struct stream_buf
     int len;   /* -1 if not yet known */
 
     bool error; /* if true, fatal TCP error has occurred,
-                *  requiring that connection be restarted */
+                 *  requiring that connection be restarted */
 #if PORT_SHARE
 #define PS_DISABLED 0
 #define PS_ENABLED  1
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 74b88ce6..d783c598 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -680,7 +680,7 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
     {
         if (tls_ctx_use_management_external_key(new_ctx))
         {
-            msg (M_WARN, "Cannot initialize mamagement-external-key");
+            msg(M_WARN, "Cannot initialize mamagement-external-key");
             goto err;
         }
     }
@@ -1099,7 +1099,7 @@ tls_session_init(struct tls_multi *multi, struct tls_session *session)
         else
         {
             session->initial_opcode = session->opt->tls_crypt_v2 ?
-                    P_CONTROL_HARD_RESET_CLIENT_V3 : P_CONTROL_HARD_RESET_CLIENT_V2;
+                                      P_CONTROL_HARD_RESET_CLIENT_V3 : P_CONTROL_HARD_RESET_CLIENT_V2;
         }
     }
 
@@ -1527,9 +1527,9 @@ read_control_auth(struct buffer *buf,
     if (opcode == P_CONTROL_HARD_RESET_CLIENT_V3
         && !tls_crypt_v2_extract_client_key(buf, ctx, opt))
     {
-        msg (D_TLS_ERRORS,
-             "TLS Error: can not extract tls-crypt-v2 client key from %s",
-             print_link_socket_actual(from, &gc));
+        msg(D_TLS_ERRORS,
+            "TLS Error: can not extract tls-crypt-v2 client key from %s",
+            print_link_socket_actual(from, &gc));
         goto cleanup;
     }
 
@@ -3781,7 +3781,7 @@ tls_pre_decrypt(struct tls_multi *multi,
                                 /* Save incoming ciphertext packet to reliable buffer */
                                 struct buffer *in = reliable_get_buf(ks->rec_reliable);
                                 ASSERT(in);
-                                if(!buf_copy(in, buf))
+                                if (!buf_copy(in, buf))
                                 {
                                     msg(D_MULTI_DROPPED,
                                         "Incoming control channel packet too big, dropping.");
@@ -4182,10 +4182,10 @@ show_available_tls_ciphers(const char *cipher_list,
     show_available_tls_ciphers_list(cipher_list, tls_cert_profile, false);
 
     printf("\n"
-    "Be aware that that whether a cipher suite in this list can actually work\n"
-    "depends on the specific setup of both peers. See the man page entries of\n"
-    "--tls-cipher and --show-tls for more details.\n\n"
-    );
+           "Be aware that that whether a cipher suite in this list can actually work\n"
+           "depends on the specific setup of both peers. See the man page entries of\n"
+           "--tls-cipher and --show-tls for more details.\n\n"
+           );
 }
 
 /*
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 7bf82b3a..410b2163 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -215,10 +215,10 @@ struct tls_wrap_ctx
     struct buffer work;         /**< Work buffer (only for --tls-crypt) */
     struct key_ctx tls_crypt_v2_server_key;  /**< Decrypts client keys */
     const struct buffer *tls_crypt_v2_wkc;   /**< Wrapped client key,
-                                                  sent to server */
+                                              *   sent to server */
     struct buffer tls_crypt_v2_metadata;     /**< Received from client */
     bool cleanup_key_ctx;                    /**< opt.key_ctx_bi is owned by
-                                                  this context */
+                                              *   this context */
 };
 
 /*
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index f7e8c2d0..a4197cba 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -65,12 +65,12 @@
 static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =
 {
     /* Hashes from SHA-1 and above */
-    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA1 ) |
-    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_RIPEMD160 ) |
-    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 ) |
-    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
-    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
-    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA1 )
+    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_RIPEMD160 )
+    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 )
+    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 )
+    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 )
+    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
     0xFFFFFFF, /* Any PK alg    */
     0xFFFFFFF, /* Any curve     */
     1024,      /* RSA-1024 and larger */
@@ -79,10 +79,10 @@ static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =
 static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_preferred =
 {
     /* SHA-2 and above */
-    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 ) |
-    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
-    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
-    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
+    MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 )
+    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 )
+    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 )
+    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
     0xFFFFFFF, /* Any PK alg    */
     0xFFFFFFF, /* Any curve     */
     2048,      /* RSA-2048 and larger */
@@ -232,7 +232,7 @@ tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)
     }
 
     msg(M_WARN, "mbed TLS does not support setting tls-ciphersuites. "
-                "Ignoring TLS 1.3 cipher list: %s", ciphers);
+        "Ignoring TLS 1.3 cipher list: %s", ciphers);
 }
 
 void
@@ -299,7 +299,7 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
     }
     else
     {
-        msg (M_FATAL, "ERROR: Invalid cert profile: %s", profile);
+        msg(M_FATAL, "ERROR: Invalid cert profile: %s", profile);
     }
 }
 
@@ -600,14 +600,14 @@ tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx,
 
     if (ctx->crt_chain == NULL)
     {
-        msg (M_WARN, "ERROR: external key requires a certificate.");
+        msg(M_WARN, "ERROR: external key requires a certificate.");
         return 1;
     }
 
     if (mbedtls_pk_get_type(&ctx->crt_chain->pk) != MBEDTLS_PK_RSA)
     {
         msg(M_WARN, "ERROR: external key with mbed TLS requires a "
-                     "certificate with an RSA key.");
+            "certificate with an RSA key.");
         return 1;
     }
 
@@ -653,8 +653,8 @@ management_sign_func(void *sign_ctx, const void *src, size_t src_len,
 
     ret = true;
 cleanup:
-    free (src_b64);
-    free (dst_b64);
+    free(src_b64);
+    free(dst_b64);
 
     return ret;
 }
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 998d6f2f..1328ceb7 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -71,8 +71,8 @@ typedef struct {
  * @return true if signing succeeded, false otherwise.
  */
 typedef bool (*external_sign_func)(
-        void *sign_ctx, const void *src, size_t src_size,
-        void *dst, size_t dst_size);
+    void *sign_ctx, const void *src, size_t src_size,
+    void *dst, size_t dst_size);
 
 /** Context used by external_pkcs1_sign() */
 struct external_context {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index da573cfa..ddb78da7 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -217,7 +217,7 @@ tls_version_max(void)
     return TLS_VER_1_2;
 #elif defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)
     return TLS_VER_1_1;
-#else
+#else  /* if defined(TLS1_3_VERSION) */
     return TLS_VER_1_0;
 #endif
 }
@@ -322,7 +322,7 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 }
 
 void
-convert_tls_list_to_openssl(char* openssl_ciphers, size_t len,const char *ciphers)
+convert_tls_list_to_openssl(char *openssl_ciphers, size_t len,const char *ciphers)
 {
     /* Parse supplied cipher list and pass on to OpenSSL */
     size_t begin_of_cipher, end_of_cipher;
@@ -466,9 +466,9 @@ tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphers)
     }
 
 #if (OPENSSL_VERSION_NUMBER < 0x1010100fL)
-        crypto_msg(M_WARN, "Not compiled with OpenSSL 1.1.1 or higher. "
-                       "Ignoring TLS 1.3 only tls-ciphersuites '%s' setting.",
-                        ciphers);
+    crypto_msg(M_WARN, "Not compiled with OpenSSL 1.1.1 or higher. "
+               "Ignoring TLS 1.3 only tls-ciphersuites '%s' setting.",
+               ciphers);
 #else
     ASSERT(NULL != ctx);
 
@@ -509,13 +509,13 @@ tls_ctx_set_cert_profile(struct tls_root_ctx *ctx, const char *profile)
     {
         msg(M_FATAL, "ERROR: Invalid cert profile: %s", profile);
     }
-#else
+#else  /* ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL */
     if (profile)
     {
         msg(M_WARN, "WARNING: OpenSSL 1.0.1 does not support --tls-cert-profile"
             ", ignoring user-set profile: '%s'", profile);
     }
-#endif
+#endif /* ifdef HAVE_SSL_CTX_SET_SECURITY_LEVEL */
 }
 
 void
@@ -658,7 +658,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
         {
             nid = EC_GROUP_get_curve_name(ecgrp);
         }
-#endif
+#endif /* if OPENSSL_VERSION_NUMBER >= 0x10002000L */
     }
 
     /* Translate NID back to name , just for kicks */
@@ -1137,7 +1137,7 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
 
     ret = get_sig_from_man(from, flen, to, len);
 
-    return (ret == len)? ret : -1;
+    return (ret == len) ? ret : -1;
 }
 
 static int
@@ -1325,7 +1325,7 @@ err:
     {
         EVP_PKEY_free(privkey);
     }
-    if(ec)
+    if (ec)
     {
         EC_KEY_free(ec);
     }
@@ -1375,7 +1375,7 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
         crypto_msg(M_WARN, "management-external-key requires an RSA or EC certificate");
         goto cleanup;
     }
-#else
+#else  /* if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO_EC) && !defined(LIBRESSL_VERSION_NUMBER) */
     else
     {
         crypto_msg(M_WARN, "management-external-key requires an RSA certificate");
@@ -1644,7 +1644,7 @@ bio_debug_data(const char *mode, BIO *bio, const uint8_t *buf, int len, const ch
     if (len > 0)
     {
         open_biofp();
-        fprintf(biofp, "BIO_%s %s time=%"PRIi64" bio=" ptr_format " len=%d data=%s\n",
+        fprintf(biofp, "BIO_%s %s time=%" PRIi64 " bio=" ptr_format " len=%d data=%s\n",
                 mode, desc, (int64_t)time(NULL), (ptr_type)bio, len, format_hex(buf, len, 0, &gc));
         fflush(biofp);
     }
@@ -1655,7 +1655,7 @@ static void
 bio_debug_oc(const char *mode, BIO *bio)
 {
     open_biofp();
-    fprintf(biofp, "BIO %s time=%"PRIi64" bio=" ptr_format "\n",
+    fprintf(biofp, "BIO %s time=%" PRIi64 " bio=" ptr_format "\n",
             mode, (int64_t)time(NULL), (ptr_type)bio);
     fflush(biofp);
 }
@@ -1963,7 +1963,7 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
             {
                 EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
                 const EC_GROUP *group = EC_KEY_get0_group(ec);
-                const char* curve;
+                const char *curve;
 
                 int nid = EC_GROUP_get_curve_name(group);
                 if (nid == 0 || (curve = OBJ_nid2sn(nid)) == NULL)
@@ -2024,7 +2024,7 @@ show_available_tls_ciphers_list(const char *cipher_list,
 #else
     STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);
 #endif
-    for (int i=0;i < sk_SSL_CIPHER_num(sk);i++)
+    for (int i = 0; i < sk_SSL_CIPHER_num(sk); i++)
     {
         const SSL_CIPHER *c = sk_SSL_CIPHER_value(sk, i);
 
@@ -2035,7 +2035,7 @@ show_available_tls_ciphers_list(const char *cipher_list,
 
         if (tls13)
         {
-              printf("%s\n", cipher_name);
+            printf("%s\n", cipher_name);
         }
         else if (NULL == pair)
         {
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 03c0b661..a7f51751 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -72,7 +72,7 @@ setenv_untrusted(struct tls_session *session)
 static void
 wipe_auth_token(struct tls_multi *multi)
 {
-    if(multi)
+    if (multi)
     {
         if (multi->auth_token)
         {
@@ -712,24 +712,24 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
 
         switch (opt->verify_hash_algo)
         {
-        case MD_SHA1:
-            ca_hash = x509_get_sha1_fingerprint(cert, &gc);
-            break;
-
-        case MD_SHA256:
-            ca_hash = x509_get_sha256_fingerprint(cert, &gc);
-            break;
-
-        default:
-            /* This should normally not happen at all; the algorithm used
-             * is parsed by add_option() [options.c] and set to a predefined
-             * value in an enumerated type.  So if this unlikely scenario
-             * happens, consider this a failure
-             */
-            msg(M_WARN, "Unexpected invalid algorithm used with "
-                "--verify-hash (%i)", opt->verify_hash_algo);
-            ret = FAILURE;
-            goto cleanup;
+            case MD_SHA1:
+                ca_hash = x509_get_sha1_fingerprint(cert, &gc);
+                break;
+
+            case MD_SHA256:
+                ca_hash = x509_get_sha256_fingerprint(cert, &gc);
+                break;
+
+            default:
+                /* This should normally not happen at all; the algorithm used
+                 * is parsed by add_option() [options.c] and set to a predefined
+                 * value in an enumerated type.  So if this unlikely scenario
+                 * happens, consider this a failure
+                 */
+                msg(M_WARN, "Unexpected invalid algorithm used with "
+                    "--verify-hash (%i)", opt->verify_hash_algo);
+                ret = FAILURE;
+                goto cleanup;
         }
 
         if (memcmp(BPTR(&ca_hash), opt->verify_hash, BLEN(&ca_hash)))
@@ -1178,8 +1178,8 @@ verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up)
         /* generate filename for deferred auth control file */
         if (!key_state_gen_auth_control_file(ks, session->opt))
         {
-            msg (D_TLS_ERRORS, "TLS Auth Error (%s): "
-                 "could not create deferred auth control file", __func__);
+            msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
+                "could not create deferred auth control file", __func__);
             goto cleanup;
         }
 #endif
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 2a9e8bb7..f4cc2c54 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -130,6 +130,7 @@ result_t backend_x509_get_username(char *common_name, int cn_len,
  * --x509-username-field option.
  */
 bool x509_username_field_ext_supported(const char *extname);
+
 #endif
 
 /*
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 10085b29..ff14db23 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -114,7 +114,8 @@ cleanup:
 }
 
 #ifdef ENABLE_X509ALTUSERNAME
-bool x509_username_field_ext_supported(const char *fieldname)
+bool
+x509_username_field_ext_supported(const char *fieldname)
 {
     int nid = OBJ_txt2nid(fieldname);
     return nid == NID_subject_alt_name || nid == NID_issuer_alt_name;
@@ -587,7 +588,7 @@ x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int usage)
          * prevent it to take a const argument
          */
         result_t result = X509_check_purpose(peer_cert, X509_PURPOSE_SSL_CLIENT, 0) ?
-	       SUCCESS : FAILURE;
+                          SUCCESS : FAILURE;
 
         /*
          * old versions of OpenSSL allow us to make the less strict check we used to
@@ -615,7 +616,7 @@ x509_verify_ns_cert_type(openvpn_x509_cert_t *peer_cert, const int usage)
          * prevent it to take a const argument
          */
         result_t result = X509_check_purpose(peer_cert, X509_PURPOSE_SSL_SERVER, 0) ?
-	       SUCCESS : FAILURE;
+                          SUCCESS : FAILURE;
 
         /*
          * old versions of OpenSSL allow us to make the less strict check we used to
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index c3ed2b93..85495d7f 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -86,7 +86,7 @@ tls_crypt_init_key(struct key_ctx_bi *key, const char *key_file,
     struct key_type kt = tls_crypt_kt();
     if (!kt.cipher || !kt.digest)
     {
-        msg (M_FATAL, "ERROR: --tls-crypt not supported");
+        msg(M_FATAL, "ERROR: --tls-crypt not supported");
     }
     crypto_read_openvpn_key(&kt, key, key_file, key_inline, key_direction,
                             "Control Channel Encryption", "tls-crypt");
@@ -530,7 +530,7 @@ tls_crypt_v2_unwrap_client_key(struct key2 *client_key, struct buffer *metadata,
     memcpy(&client_key->keys, BPTR(&plaintext), sizeof(client_key->keys));
     ASSERT(buf_advance(&plaintext, sizeof(client_key->keys)));
 
-    if(!buf_copy(metadata, &plaintext))
+    if (!buf_copy(metadata, &plaintext))
     {
         CRYPT_ERROR("metadata too large for supplied buffer");
     }
@@ -613,7 +613,7 @@ tls_crypt_v2_extract_client_key(struct buffer *buf,
     if (!ctx->tls_crypt_v2_server_key.cipher)
     {
         msg(D_TLS_ERRORS,
-             "Client wants tls-crypt-v2, but no server key present.");
+            "Client wants tls-crypt-v2, but no server key present.");
         return false;
     }
 
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 9b5ea971..43bf8122 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -99,10 +99,10 @@
 #define TLS_CRYPT_V2_SERVER_KEY_LEN (sizeof(struct key))
 #define TLS_CRYPT_V2_TAG_SIZE (TLS_CRYPT_TAG_SIZE)
 #define TLS_CRYPT_V2_MAX_METADATA_LEN (unsigned)(TLS_CRYPT_V2_MAX_WKC_LEN \
-         - (TLS_CRYPT_V2_CLIENT_KEY_LEN + TLS_CRYPT_V2_TAG_SIZE \
-            + sizeof(uint16_t)))
+                                                 - (TLS_CRYPT_V2_CLIENT_KEY_LEN + TLS_CRYPT_V2_TAG_SIZE \
+                                                    + sizeof(uint16_t)))
 #define TLS_CRYPT_V2_MAX_B64_METADATA_LEN \
-        OPENVPN_BASE64_LENGTH(TLS_CRYPT_V2_MAX_METADATA_LEN - 1)
+    OPENVPN_BASE64_LENGTH(TLS_CRYPT_V2_MAX_METADATA_LEN - 1)
 
 /**
  * Initialize a key_ctx_bi structure for use with --tls-crypt.
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index c091401f..12e6eb00 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -553,8 +553,8 @@ is_tun_p2p(const struct tuntap *tt)
     bool tun = false;
 
     if (tt->type == DEV_TYPE_TAP
-          || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
-          || tt->type == DEV_TYPE_NULL )
+        || (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)
+        || tt->type == DEV_TYPE_NULL)
     {
         tun = false;
     }
@@ -893,7 +893,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
                 ifconfig_ipv6_local, tt->netbits_ipv6, ifname);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, S_FATAL, "Linux ip -6 addr add failed");
-#else
+#else  /* ifdef ENABLE_IPROUTE */
     argv_printf(&argv, "%s %s add %s/%d mtu %d up", IFCONFIG_PATH, ifname,
                 ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
     argv_msg(M_INFO, &argv);
@@ -1387,6 +1387,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
                     ifname, ifconfig_local,
                     print_in_addr_t(tt->adapter_netmask, 0, &gc));
                 break;
+
             case IPW32_SET_NETSH:
                 netsh_ifconfig(&tt->options, ifname, tt->local,
                                tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
@@ -2442,7 +2443,7 @@ close_tun(struct tuntap *tt)
     struct argv argv = argv_new();
 
     /* setup command, close tun dev (clears tt->actual_name!), run command
-    */
+     */
 
     argv_printf(&argv, "%s %s destroy",
                 IFCONFIG_PATH, tt->actual_name);
@@ -2528,7 +2529,7 @@ close_tun(struct tuntap *tt)
     struct argv argv = argv_new();
 
     /* setup command, close tun dev (clears tt->actual_name!), run command
-    */
+     */
 
     argv_printf(&argv, "%s %s destroy",
                 IFCONFIG_PATH, tt->actual_name);
@@ -2668,7 +2669,7 @@ close_tun(struct tuntap *tt)
     struct argv argv = argv_new();
 
     /* setup command, close tun dev (clears tt->actual_name!), run command
-    */
+     */
 
     argv_printf(&argv, "%s %s destroy",
                 IFCONFIG_PATH, tt->actual_name);
@@ -5923,7 +5924,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
                 };
 
                 if (send_msg_iservice(tt->options.msg_channel, &msg, sizeof(msg),
-                    &ack, "TUN"))
+                                      &ack, "TUN"))
                 {
                     status = ack.error_number;
                 }
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index e43296eb..be526945 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1481,7 +1481,7 @@ send_msg_iservice(HANDLE pipe, const void *data, size_t size,
         || !ReadFile(pipe, ack, sizeof(*ack), &len, NULL))
     {
         msg(M_WARN, "%s: could not talk to service: %s [%lu]",
-            context? context : "Unknown",
+            context ? context : "Unknown",
             strerror_win32(GetLastError(), &gc), GetLastError());
         ret = false;
     }
-- 
2.19.2


