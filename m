From: Gert Doering <gert@...1296...>
Date: Wed, 24 Sep 2025 14:27:47 +0200
Message-ID: <20250924122755.14391-1-gert@...1296...>
In-Reply-To: <gerrit.1756894870000.Iad5b00c35a1f1993b1fa99e8b945ab17b230ef59@...2715...>
References: <gerrit.1756894870000.Iad5b00c35a1f1993b1fa99e8b945ab17b230ef59@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v14] Enable -Wconversion
 -Wno-sign-conversion by default
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

From: Frank Lichtenheld <frank@...2641...>

Grand-father all known locations of existing errors,
so that -Werror builds still pass and we do not spam
build logs.

Still, this should give us a much better roadmap to
work on these issues one by one while still enabling
the warnings for a lot of code-paths.

In general I did go for least amount of pragmas, so
usually there is only one override per file, covering
ALL of the failures in that file. While this protects
a lot of code that doesn't need it, it also cut down
the amount of pragmas by a lot.

This does cover gcc builds including mingw and clang
builds. Does not cover MSVC.

Once the amount of issues has been suitable reduced
more warnings could be enabled.

Change-Id: Iad5b00c35a1f1993b1fa99e8b945ab17b230ef59
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1168
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1168
This mail reflects revision 14 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index fdc0162..3f6196f 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -113,8 +113,7 @@
     check_and_add_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)
     check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
-    # We are not ready for this
-    #add_compile_options(-Wconversion -Wno-sign-conversion)
+    add_compile_options(-Wconversion -Wno-sign-conversion)
     add_compile_options(-Wextra -Wno-sign-compare -Wno-type-limits -Wno-unused-parameter)
     # clang doesn't have the different levels but also doesn't include it in -Wextra
     check_and_add_compiler_flag(-Wimplicit-fallthrough=2 GCCImplicitFallthrough)
diff --git a/configure.ac b/configure.ac
index c2feeea..8f3c01d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1397,6 +1397,7 @@
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sign-conversion])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-type-limits -Wno-unused-parameter])
 # clang doesn't have the different levels but also doesn't include it in -Wextra
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 6736469..a78c664 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -88,6 +88,11 @@
     compv2_escape_data_ifneeded(buf);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 do_lz4_decompress(size_t zlen_max, struct buffer *work, struct buffer *buf,
                   struct compress_context *compctx)
@@ -113,6 +118,10 @@
     *buf = *work;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 lz4_decompress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
                const struct frame *frame)
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index b0228dd..71c0025 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -45,6 +45,11 @@
 
 #include "win32.h"
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  * Get input from a Windows console.
  *
@@ -134,6 +139,10 @@
     return false;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* _WIN32 */
 
 
@@ -264,6 +273,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
 
 /**
  * @copydoc query_user_exec()
@@ -296,3 +309,7 @@
 
     return ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ec7da43..6376c11 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -186,6 +186,11 @@
     return;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 openvpn_encrypt_v1(struct buffer *buf, struct buffer work, struct crypto_options *opt)
 {
@@ -1532,6 +1537,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 write_key_file(const int nkeys, const char *filename)
 {
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index b5cbc8d..7026ff8 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -72,6 +72,11 @@
     hmac_ctx_free(hmac_ctx);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 bool
 ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t *label, size_t label_len,
                   const uint8_t *context, size_t context_len, uint8_t *out, uint16_t out_len)
@@ -163,6 +168,10 @@
     key->epoch = epoch_key->epoch;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 epoch_init_send_key_ctx(struct crypto_options *co)
 {
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 2bab312..076d4ee 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -230,6 +230,11 @@
            "available\n");
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 bool
 crypto_pem_encode(const char *name, struct buffer *dst, const struct buffer *src,
                   struct gc_arena *gc)
@@ -760,7 +765,6 @@
     return 1;
 }
 
-
 /*
  *
  * Generic message digest information functions
@@ -1119,4 +1123,9 @@
     return true;
 }
 #endif /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 2d0265a..7688add 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -895,6 +895,10 @@
     return EVP_CIPHER_CTX_mode(ctx);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
 
 bool
 cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
@@ -999,6 +1003,9 @@
     return cipher_ctx_final(ctx, dst, dst_len);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
 
 /*
  *
@@ -1214,12 +1221,21 @@
     HMAC_CTX_reset(ctx);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 int
 hmac_ctx_size(HMAC_CTX *ctx)
 {
     return HMAC_size(ctx);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 hmac_ctx_reset(HMAC_CTX *ctx)
 {
@@ -1398,6 +1414,11 @@
     CRYPTO_tls1_prf(EVP_md5_sha1(), out1, olen, sec, slen, label, label_len, NULL, 0, NULL, 0);
 }
 #elif !defined(LIBRESSL_VERSION_NUMBER) && !defined(ENABLE_CRYPTO_WOLFSSL)
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 bool
 ssl_tls1_PRF(const uint8_t *seed, size_t seed_len, const uint8_t *secret, size_t secret_len,
              uint8_t *output, size_t output_len)
@@ -1443,6 +1464,11 @@
     EVP_PKEY_CTX_free(pctx);
     return ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #else  /* if defined(LIBRESSL_VERSION_NUMBER) */
 /* LibreSSL and wolfSSL do not expose a TLS 1.0/1.1 PRF via the same APIs as
  * OpenSSL does. As result they will only be able to support
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index d91d9a1..bba6ed2 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -62,7 +62,7 @@
     return 0;
 }
 
-#else  /* HAVE_XKEY_PROVIDER */
+#else /* HAVE_XKEY_PROVIDER */
 
 static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;
 
@@ -342,6 +342,11 @@
     return rv;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /** Sign hash in tbs using EC key in cd and NCryptSignHash */
 static int
 xkey_cng_ec_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsigned char *tbs,
@@ -438,6 +443,10 @@
     return (*siglen > 0);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /** Dispatch sign op to xkey_cng_<rsa/ec>_sign */
 static int
 xkey_cng_sign(void *handle, unsigned char *sig, size_t *siglen, const unsigned char *tbs,
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 881459c..2cf90af 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -491,6 +491,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 int
 dco_p2p_add_new_peer(struct context *c)
 {
@@ -645,6 +650,10 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 dco_install_iroute(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *addr)
 {
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index d5ca277..b9f6bc7 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -72,6 +72,11 @@
     return (nvl);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static bool
 nvlist_to_sockaddr(const nvlist_t *nvl, struct sockaddr_storage *ss)
 {
@@ -854,6 +859,10 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index d8357ca..395a38f 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -62,6 +62,11 @@
 
 typedef int (*ovpn_nl_cb)(struct nl_msg *msg, void *arg);
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  * @brief resolves the netlink ID for ovpn-dco
  *
@@ -1298,4 +1303,8 @@
     return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 2d08ed8..9e52859 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -525,6 +525,11 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 int
 dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_slot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
@@ -564,6 +569,11 @@
     }
     return 0;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
 {
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 7abade5..38e8d40 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -72,6 +72,11 @@
     return -1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static in_addr_t
 do_extract(struct dhcp *dhcp, int optlen)
 {
@@ -185,3 +190,7 @@
     }
     return 0;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 581bdbb..2f60b78 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -65,6 +65,11 @@
 #define SELECT_MAX_FDS 256
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static inline int
 tv_to_ms_timeout(const struct timeval *tv)
 {
@@ -78,6 +83,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #ifdef _WIN32
 
 struct we_set
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 12dd6a7..f342958 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -367,6 +367,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 bool
 send_control_channel_string_dowork(struct tls_session *session, const char *str,
                                    msglvl_t msglevel)
@@ -1966,6 +1971,10 @@
     perf_pop();
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 pre_select(struct context *c)
 {
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index e6ebbef..0e5e93f 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -98,6 +98,11 @@
     return (get_random() % n) == 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * Return uniformly distributed random number between
  * low and high.
@@ -229,4 +234,9 @@
         }
     }
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ifdef ENABLE_DEBUG */
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index be20638..f665b17 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -61,6 +61,11 @@
     Hex[HASHHEXLEN] = '\0';
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /* calculate H(A1) as per spec */
 void
 DigestCalcHA1(IN char *pszAlg, IN char *pszUserName, IN char *pszRealm, IN char *pszPassword,
@@ -145,4 +150,8 @@
     CvtHex(RespHash, Response);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* if PROXY_DIGEST_AUTH */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0d7a2ec..f8a0fee 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -455,6 +455,11 @@
 }
 #endif /* ENABLE_MANAGEMENT */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * Initialize and possibly randomize the connection list.
  *
@@ -3490,6 +3495,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * No encryption or authentication.
  */
diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
index 2b35314..fbefcd9 100644
--- a/src/openvpn/interval.c
+++ b/src/openvpn/interval.c
@@ -38,6 +38,11 @@
     top->horizon = horizon;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 bool
 event_timeout_trigger(struct event_timeout *et, struct timeval *tv, const int et_const_retry)
 {
@@ -77,3 +82,7 @@
     }
     return ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 3a73d5f..8daaec0 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -72,6 +72,11 @@
     *header = NO_COMPRESS_BYTE;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 lzo_decompress(struct buffer *buf, struct buffer work, struct compress_context *compctx,
                const struct frame *frame)
@@ -121,6 +126,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const struct compress_alg lzo_alg = { "lzo", lzo_compress_init, lzo_compress_uninit, lzo_compress,
                                       lzo_decompress };
 #endif /* ENABLE_LZO */
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index c675e95..5a41a0f 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -206,6 +206,11 @@
     return man->settings.up.defined && !man->connection.password_verified;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 man_check_password(struct management *man, const char *line)
 {
@@ -236,6 +241,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 man_update_io_state(struct management *man)
 {
@@ -2305,6 +2314,11 @@
 
 #endif /* ifdef TARGET_ANDROID */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static int
 man_read(struct management *man)
 {
@@ -2442,6 +2456,10 @@
     return sent;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 man_connection_clear(struct man_connection *mc)
 {
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 0750fec..448124c 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -34,6 +34,11 @@
 
 #include "memdbg.h"
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 struct mbuf_set *
 mbuf_init(unsigned int size)
 {
@@ -44,6 +49,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 mbuf_free(struct mbuf_set *ms)
 {
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index d3d316d..caf4725 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -72,6 +72,11 @@
 #endif
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 #ifdef ENABLE_MANAGEMENT
 /* Get username/password from the management interface */
 static bool
@@ -184,6 +189,10 @@
 
 #endif /* ifdef ENABLE_MANAGEMENT */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Get and store a username/password
  */
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index ab01874..88ea647 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -103,6 +103,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static inline void
 mroute_get_in_addr_t(struct mroute_addr *ma, const in_addr_t src, unsigned int mask)
 {
@@ -547,6 +552,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 mroute_helper_free(struct mroute_helper *mh)
 {
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 32cd3f8..e7111a8 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -130,6 +130,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * change TCP MSS option in SYN/SYN-ACK packets, if present
  * this is generic for IPv4 and IPv6, as the TCP header is the same
@@ -199,6 +204,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static inline size_t
 adjust_payload_max_cbc(const struct key_type *kt, size_t target)
 {
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 81310a2..83edec6 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -45,6 +45,11 @@
     unsigned int sock;
 };
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 struct multi_instance *
 multi_create_instance_tcp(struct multi_context *m, struct link_socket *sock)
 {
@@ -120,6 +125,10 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 multi_tcp_instance_specific_free(struct multi_instance *mi)
 {
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 9c1a772..66f81a6 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -280,6 +280,11 @@
     struct timeval tv;
 };
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 const char *
 format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc)
 {
@@ -389,6 +394,10 @@
     return BSTR(&out);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 set_sock_extended_error_passing(int sd, sa_family_t proto_af)
 {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 31134be..a373a6a 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -180,6 +180,11 @@
     return false;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * Get a client instance based on real address.  If
  * the instance doesn't exist, create it while
@@ -310,6 +315,10 @@
     return mi;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Send a packet to UDP socket.
  */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 1d2ee53..2863ff1 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -256,6 +256,11 @@
 
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 #ifdef ENABLE_ASYNC_PUSH
 static uint32_t
 /*
@@ -3982,6 +3987,10 @@
     return count;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 management_delete_event(void *arg, event_t event)
 {
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 00d6106..1815faf 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -131,6 +131,11 @@
     inet_address_t gw;
 };
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  * Helper function used to easily add attributes to a rtnl message
  */
@@ -1469,6 +1474,10 @@
     return sitnl_send(&req.n, 0, 0, NULL, NULL);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* !ENABLE_SITNL */
 
 #endif /* TARGET_LINUX */
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index c2a93e8..521677b 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -74,6 +74,11 @@
     hmac_ctx_free(hmac_ctx);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 gen_timestamp(uint8_t *timestamp)
 {
@@ -383,4 +388,8 @@
 
     return ((const char *)make_base64_string2((unsigned char *)phase3, phase3_bufpos, gc));
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
 #endif /* if NTLM */
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 8821a06..78013ae 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -174,6 +174,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 void
 check_send_occ_load_test_dowork(struct context *c)
 {
@@ -347,6 +352,10 @@
     c->c2.occ_op = -1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 process_received_occ_msg(struct context *c)
 {
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 6fd7390..e3e7cf8 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -194,12 +194,21 @@
           LIBRESSL_VERSION_NUMBER > 0x3050400fL) */
 
 #if OPENSSL_VERSION_NUMBER < 0x30200000L && OPENSSL_VERSION_NUMBER >= 0x30000000L
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static inline const char *
 SSL_get0_group_name(SSL *s)
 {
     int nid = SSL_get_negotiated_group(s);
     return SSL_group_to_name(s, nid);
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
 #endif
 
 #endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 151a016..f801743 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1158,6 +1158,11 @@
     return get_ipv6_addr(ipv6_prefix_spec, &t_addr, &t_bits, M_WARN);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static char *
 string_substitute(const char *src, int from, int to, struct gc_arena *gc)
 {
@@ -9900,6 +9905,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 has_udp_in_local_list(const struct options *options)
 {
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index fdc0c55..8a1c083 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -162,6 +162,11 @@
     return (int)i;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 bool
 atoi_constrained(const char *str, int *value, const char *name, int min, int max, msglvl_t msglevel)
 {
@@ -193,6 +198,10 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static const char *updatable_options[] = { "block-ipv6", "block-outside-dns",
                                            "dhcp-option", "dns",
                                            "ifconfig", "ifconfig-ipv6",
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 717f749..d9bf157 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -100,6 +100,11 @@
 
 /* format a time_t as ascii, or use current time if 0 */
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 const char *
 time_string(time_t t, long usec, bool show_usec, struct gc_arena *gc)
 {
@@ -130,6 +135,10 @@
     return BSTR(&out);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Limit the frequency of an event stream.
  *
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 5c700bb..108d0f2 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -59,6 +59,11 @@
 extern time_t now_usec;
 void update_now_usec(struct timeval *tv);
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static inline int
 openvpn_gettimeofday(struct timeval *tv, void *tz)
 {
@@ -236,6 +241,10 @@
     dest->tv_usec = usec;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #define TV_WITHIN_SIGMA_MAX_SEC  600
 #define TV_WITHIN_SIGMA_MAX_USEC (TV_WITHIN_SIGMA_MAX_SEC * 1000000)
 
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index ca318eb..880eee1 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -71,6 +71,11 @@
 #endif
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 packet_id_init_recv(struct packet_id_rec *rec, int seq_backtrack, int time_backtrack,
                     const char *name, int unit)
@@ -663,6 +668,10 @@
     return epoch;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 packet_id_write_epoch(struct packet_id_send *p, uint16_t epoch, struct buffer *buf)
 {
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index a7eb256..e9d3647 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -280,6 +280,11 @@
     return p->fd >= 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /* transfer packet_id -> packet_id_persist */
 static inline void
 packet_id_persist_save_obj(struct packet_id_persist *p, const struct packet_id *pid)
@@ -291,6 +296,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * Reset the current send packet id to its initial state.
  * Use very carefully (e.g. in the standalone reset packet context) to
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 8a7a320..16149ca 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -53,6 +53,11 @@
 }
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 __mysleep(const unsigned long usec)
 {
@@ -558,6 +563,10 @@
     return success;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 tls_ctx_use_pkcs11(struct tls_root_ctx *const ssl_ctx, bool pkcs11_id_management,
                    const char *const pkcs11_id)
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 23c01ab..f619b95 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -428,6 +428,11 @@
     return dn;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 int
 pkcs11_certificate_serial(pkcs11h_certificate_t certificate, char *serial, size_t serial_len)
 {
@@ -468,4 +473,9 @@
 
     return ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* defined(ENABLE_PKCS11) && defined(ENABLE_OPENSSL) */
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 9d8fe75..02554ba 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -54,6 +54,11 @@
 }
 
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /* cached proxy username/password */
 static struct user_pass static_proxy_user_pass;
 
@@ -1063,3 +1068,7 @@
     gc_free(&gc);
     return ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index a10df2e..1d14367 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -475,6 +475,11 @@
     return true;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * This function runs in the context of the background proxy process.
  * Receive a control message from the parent (sent by the port_share_sendmsg
@@ -792,6 +797,10 @@
     msg(M_INFO, "PORT SHARE PROXY: proxy exiting");
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Called from the main OpenVPN process to enable the port
  * share proxy.
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 60ca25f..e7fc50c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -429,6 +429,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
 
 bool
 send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_session *session,
@@ -1086,6 +1090,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 process_incoming_push_msg(struct context *c, const struct buffer *buffer,
                           bool honor_received_options, unsigned int permission_mask,
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index f7a4fca..9138bdb 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -9,6 +9,11 @@
 #include "multi.h"
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 int
 process_incoming_push_update(struct context *c, unsigned int permission_mask,
                              unsigned int *option_types_found, struct buffer *buf,
@@ -306,3 +311,7 @@
     RETURN_UPDATE_STATUS(n_sent);
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index b4a747f..0c8b552 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -687,6 +687,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /* in how many seconds should we wake up to check for timeout */
 /* if we return BIG_TIMEOUT, nothing to wait for */
 interval_t
@@ -719,6 +724,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Enable an incoming buffer previously returned by a get function as active.
  */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index aa5ce69..156a99e 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1760,6 +1760,10 @@
     return (status != RTA_ERROR);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
 
 void
 route_ipv6_clear_host_bits(struct route_ipv6 *r6)
@@ -2364,6 +2368,10 @@
     net_ctx_reset(ctx);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * The --redirect-gateway option requires OS-specific code below
  * to get the current default gateway.
@@ -3360,6 +3368,11 @@
 
 #define max(a, b) ((a) > (b) ? (a) : (b))
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 void
 get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
@@ -3733,6 +3746,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #undef max
 
 #elif defined(TARGET_HAIKU)
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index c9fef24..1389889 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -65,6 +65,11 @@
 }
 #endif
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static inline void
 schedule_set_pri(struct schedule_entry *e)
 {
@@ -75,6 +80,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* This is the master key comparison routine.  A key is
  * simply a struct timeval containing the absolute time for
  * an event.  The unique treap priority (pri) is used to ensure
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index afedf5d..5fcf820 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -72,6 +72,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * Functions related to the translation of DNS names to IP addresses.
  */
@@ -2449,6 +2454,10 @@
 #endif
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #if ENABLE_IP_PKTINFO
 
 ssize_t
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 1102421..85bbde5 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -80,6 +80,11 @@
     free(sp);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static bool
 socks_proxy_recv_char(char *c, const char *name, socket_descriptor_t sd,
                       struct event_timeout *server_poll_timeout,
@@ -438,6 +443,10 @@
     return;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
                                socket_descriptor_t ctrl_sd, /* already open to proxy */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index ba6919b..34036f2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -180,6 +180,11 @@
     frame->tun_mtu = max_int(frame->tun_mtu, TLS_CHANNEL_MTU_MIN);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  * calculate the maximum overhead that control channel frames have
  * This includes header, op code and everything apart from the
@@ -222,6 +227,10 @@
     return overhead;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 init_ssl_lib(void)
 {
@@ -1120,6 +1129,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * Return true if "lame duck" or retiring key has expired and can
  * no longer be used.
@@ -3979,6 +3993,10 @@
     ASSERT(buf_write_prepend(buf, &op, 1));
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 tls_prepend_opcode_v2(const struct tls_multi *multi, struct buffer *buf)
 {
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b2d511e..80eb51b 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -585,6 +585,11 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  * external_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that uses
  * the management interface to request an RSA signature for the supplied hash.
@@ -1004,6 +1009,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 tls_version_max(void)
 {
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 958acea..790e50f 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -534,6 +534,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  * Replaces the string DEFAULT with the string \c replace.
  *
@@ -566,6 +571,10 @@
     o->ncp_ciphers = (char *)ncp_ciphers;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * Checks for availibility of Chacha20-Poly1305 and sets
  * the ncp_cipher to either AES-256-GCM:AES-128-GCM or
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8c8b1e21..89deeaa 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -272,6 +272,11 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static bool
 tls_ctx_set_tls_versions(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 {
@@ -424,6 +429,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
@@ -2513,6 +2522,11 @@
     msg(D_HANDSHAKE, "%s%s%s%s%s", s1, s2, s3, s4, s5);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 void
 show_available_tls_ciphers_list(const char *cipher_list, const char *tls_cert_profile, bool tls13)
 {
@@ -2580,6 +2594,10 @@
     SSL_CTX_free(tls_ctx.ctx);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Show the Elliptic curves that are available for us to use
  * in the OpenSSL library.
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 6ec05a7..825719c 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -160,6 +160,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 void
 write_control_auth(struct tls_session *session, struct key_state *ks, struct buffer *buf,
                    struct link_socket_actual **to_link_addr, int opcode, int max_ack,
@@ -495,6 +500,10 @@
     return result.sid;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,
                               const struct openvpn_sockaddr *from,
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index 918a1f1..50e8c03 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -290,6 +290,11 @@
     return NULL;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 int
 get_num_elements(const char *string, char delimiter)
 {
@@ -309,3 +314,7 @@
 
     return element_count;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 7658f2d..04ef27e 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -874,6 +874,11 @@
     return supported;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  *  Checks if the deferred state should also send auth pending
  *  request to the client. Also removes the auth_pending control file
@@ -945,6 +950,9 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
 
 /**
  *  Removes auth_pending and auth_control files from file system
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index c92eaf1..472eb49 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -250,6 +250,11 @@
     return FAILURE;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static struct buffer
 x509_get_fingerprint(const mbedtls_md_info_t *md_info, mbedtls_x509_crt *cert, struct gc_arena *gc)
 {
@@ -260,6 +265,10 @@
     return fingerprint;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 struct buffer
 x509_get_sha1_fingerprint(mbedtls_x509_crt *cert, struct gc_arena *gc)
 {
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index f1b8902..40d117b 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -667,6 +667,11 @@
     return FAILURE;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 result_t
 x509_verify_cert_ku(X509 *x509, const unsigned *const expected_ku, int expected_len)
 {
@@ -726,6 +731,10 @@
     return fFound;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 result_t
 x509_verify_cert_eku(X509 *x509, const char *const expected_oid)
 {
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index cea31f5..1e1e3fb 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -207,6 +207,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 #define STATUS_PRINTF_MAXLEN 512
 
 void
@@ -303,3 +308,7 @@
 
     return ret;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 737b556..51b4eb3 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -205,6 +205,11 @@
     return false;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 bool
 tls_crypt_unwrap(const struct buffer *src, struct buffer *dst, struct crypto_options *opt)
 {
@@ -413,6 +418,10 @@
     return buf_copy(wkc, &work);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static bool
 tls_crypt_v2_unwrap_client_key(struct key2 *client_key, struct buffer *metadata,
                                struct buffer wrapped_client_key, struct key_ctx *server_key)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index c213c4b..e35f889 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1720,6 +1720,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static int
 write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {
@@ -1773,6 +1778,11 @@
         return read(tt->fd, buf, len);
     }
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */
 
 bool
@@ -2244,6 +2254,11 @@
     free(tt);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 int
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
@@ -2256,6 +2271,10 @@
     return read(tt->fd, buf, len);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #elif defined(TARGET_SOLARIS)
 
 #ifndef TUNNEWPPA
@@ -2935,6 +2954,11 @@
     argv_free(&argv);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 int
 write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
@@ -2989,6 +3013,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #elif defined(TARGET_DRAGONFLY)
 
 static inline int
@@ -3277,6 +3305,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 void
 close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
@@ -3326,6 +3359,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #elif defined(TARGET_AIX)
 
 void
@@ -5517,6 +5554,11 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * Convert DHCP options from the command line / config file
  * into a raw DHCP-format options string.
@@ -5656,6 +5698,10 @@
     buf_write(buf, tmp_buf, len);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static bool
 build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
 {
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index a6a6e93..3da470a 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -43,6 +43,11 @@
     return ntohs(hdr->pcp_cfi_vid & OPENVPN_8021Q_MASK_VID);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /*
  * Set the VLAN Identifier (VID) in an IEEE 802.1Q header.
  *
@@ -56,6 +61,10 @@
         (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) | (htons(vid) & OPENVPN_8021Q_MASK_VID);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * vlan_decapsulate - remove 802.1q header and return VID
  *
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 15bcf37..eac2352 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1418,6 +1418,11 @@
     return (const char *)out.data;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 bool
 send_msg_iservice(HANDLE pipe, const void *data, size_t size, ack_message_t *ack,
                   const char *context)
@@ -1632,4 +1637,8 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 0983e59..ce0d4dd 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1383,6 +1383,11 @@
     return TRUE;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  * Prepare DNS domain "SearchList" registry value, so additional
  * VPN domains can be added and its original state can be restored
@@ -2614,6 +2619,10 @@
     return err;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * Return the registry key where NRPT rules are stored
  *
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 3f327c2..22e6912 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -674,6 +674,11 @@
     struct crypto_options co;
 };
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static int
 crypto_test_epoch_setup(void **state)
 {
@@ -694,6 +699,10 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 crypto_test_epoch_teardown(void **state)
 {
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index d568865..a4ba088 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -378,7 +378,7 @@
         /* decode the base64 data and convert to X509 and get its sha1 fingerprint */
         unsigned char *der = malloc(strlen(base64));
         assert_non_null(der);
-        int derlen = openvpn_base64_decode(base64, der, strlen(base64));
+        int derlen = openvpn_base64_decode(base64, der, (int)strlen(base64));
         free(base64);
         assert_true(derlen > 0);
 
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index bb02fcc..ed40a7d 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -133,6 +133,11 @@
     const char *keyfile;
 } global_state;
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static int
 init(void **state)
 {
@@ -154,6 +159,10 @@
     return 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 cleanup(void **state)
 {

