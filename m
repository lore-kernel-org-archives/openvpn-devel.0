From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 15 Sep 2025 12:05:16 +0000
References: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <be096bf45e20adcc6e32e027fd3fdb1319d43275-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l2eTwLZuXto="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Enable
 -Wsign-conversion
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--l2eTwLZuXto=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1186?usp=3Demail

to review the following change.


Change subject: Enable -Wsign-conversion
......................................................................

Enable -Wsign-conversion

As before with -Wconversion override all the known issues
to be able to address them one by one.

Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M configure.ac
M src/openvpn/argv.c
M src/openvpn/base64.c
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/clinat.c
M src/openvpn/comp-lz4.c
M src/openvpn/console_builtin.c
M src/openvpn/crypto.c
M src/openvpn/crypto_epoch.c
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_openssl.c
M src/openvpn/dhcp.c
M src/openvpn/env_set.c
M src/openvpn/error.h
M src/openvpn/event.c
M src/openvpn/fragment.c
M src/openvpn/list.h
M src/openvpn/lzo.c
M src/openvpn/mbuf.c
M src/openvpn/networking_sitnl.c
M src/openvpn/ntlm.c
M src/openvpn/otime.h
M src/openvpn/packet_id.c
M src/openvpn/platform.h
M src/openvpn/plugin.c
M src/openvpn/pool.c
M src/openvpn/reliable.c
M src/openvpn/socket.h
M src/openvpn/ssl_util.c
M src/openvpn/status.c
M src/openvpn/wfp_block.c
M src/openvpn/xkey_provider.c
M src/openvpnmsica/dllmain.c
M src/openvpnserv/common.c
M src/openvpnserv/interactive.c
M src/tapctl/tap.c
M tests/unit_tests/openvpn/mock_get_random.c
M tests/unit_tests/openvpn/mock_msg.c
M tests/unit_tests/openvpn/test_networking.c
41 files changed, 228 insertions(+), 80 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/1186/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 51f4221..803cdb4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -113,7 +113,7 @@
     check_and_add_compiler_flag(-Wno-stringop-truncation NoStringOpTruncat=
ion)
     check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
-    add_compile_options(-Wconversion -Wno-sign-conversion)
+    add_compile_options(-Wconversion)
     if (USE_WERROR)
         add_compile_options(-Werror)
     endif ()
diff --git a/configure.ac b/configure.ac
index 957205e..b23939e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1396,7 +1396,7 @@
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sign-conversion])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])

 if test "${enable_pedantic}" =3D "yes"; then
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 55deef5..5d4ca57 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -323,6 +323,11 @@
     return f;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  *  Create a struct argv based on a format string
  *
@@ -418,6 +423,10 @@
     return res;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  *  printf() variant which populates a struct argv.  It processes the
  *  format string with the provided arguments.  For each space separator f=
ound
diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c
index 2a5a46d..00fef04 100644
--- a/src/openvpn/base64.c
+++ b/src/openvpn/base64.c
@@ -44,6 +44,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif

 static char base64_chars[] =3D "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnop=
qrstuvwxyz0123456789+/";
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index b6d6669..023f7fe 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -109,6 +109,11 @@
     return buf;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 struct buffer
 #ifdef DMALLOC
 clone_buf_debug(const struct buffer *buf, const char *file, int line)
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 1405667..15377e9 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -327,6 +327,11 @@
     return true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline void
 buf_set_write(struct buffer *buf, uint8_t *data, int size)
 {
@@ -851,6 +856,10 @@
     return memcmp(BPTR(src), match, size) =3D=3D 0;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool buf_string_match_head_str(const struct buffer *src, const char *match=
);

 bool buf_string_compare_advance(struct buffer *src, const char *match);
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 2d21daf..fdd1a34 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -180,6 +180,11 @@
     gc_free(&gc);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 client_nat_transform(const struct client_nat_option_list *list, struct buf=
fer *ipbuf,
                      const int direction)
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index a78c664..87173d6 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -91,6 +91,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif

 static void
@@ -118,10 +119,6 @@
     *buf =3D *work;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 lz4_decompress(struct buffer *buf, struct buffer work, struct compress_con=
text *compctx,
                const struct frame *frame)
@@ -207,6 +204,10 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const struct compress_alg lz4_alg =3D { "lz4", lz4_compress_init, lz4_comp=
ress_uninit, lz4_compress,
                                       lz4_decompress };

diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 71c0025..61d1657 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -187,6 +187,11 @@

 #endif /* HAVE_TERMIOS_H */

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif

 /**
  *  Core function for getting input from console
@@ -273,11 +278,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * @copydoc query_user_exec()
  *
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 8e56881..f033a97 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -62,6 +62,12 @@
  * happen unless the frame parameters are wrong.
  */

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 openvpn_encrypt_aead(struct buffer *buf, struct buffer work, struct crypto=
_options *opt)
 {
@@ -186,11 +192,6 @@
     return;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 openvpn_encrypt_v1(struct buffer *buf, struct buffer work, struct crypto_o=
ptions *opt)
 {
@@ -1537,10 +1538,6 @@
     gc_free(&gc);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 write_key_file(const int nkeys, const char *filename)
 {
@@ -1599,6 +1596,10 @@
     return nbits;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 must_have_n_keys(const char *filename, const char *option, const struct ke=
y2 *key2, int n)
 {
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 7026ff8..e0654d1 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -38,6 +38,12 @@
 #include "buffer.h"
 #include "integer.h"

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, int info_len,=
 uint8_t *out,
                  int out_len)
@@ -72,11 +78,6 @@
     hmac_ctx_free(hmac_ctx);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t =
*label, size_t label_len,
                   const uint8_t *context, size_t context_len, uint8_t *out=
, uint16_t out_len)
@@ -168,10 +169,6 @@
     key->epoch =3D epoch_key->epoch;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 epoch_init_send_key_ctx(struct crypto_options *co)
 {
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 40978d9..7a44416 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -233,6 +233,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif

 bool
@@ -765,10 +766,6 @@
     return 1;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  *
  * Generic message digest information functions
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index f1bfd9f..4c13fe4 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -520,6 +520,12 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 bool
 crypto_pem_decode(const char *name, struct buffer *dst, const struct buffe=
r *src)
 {
@@ -895,11 +901,6 @@
     return EVP_CIPHER_CTX_mode(ctx);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
 {
@@ -1003,10 +1004,6 @@
     return cipher_ctx_final(ctx, dst, dst_len);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  *
  * Generic message digest information functions
@@ -1221,21 +1218,12 @@
     HMAC_CTX_reset(ctx);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 hmac_ctx_size(HMAC_CTX *ctx)
 {
     return HMAC_size(ctx);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 hmac_ctx_reset(HMAC_CTX *ctx)
 {
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 38e8d40..302d6ac 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -75,6 +75,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif

 static in_addr_t
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 487a5e2..3de0374 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -434,6 +434,11 @@
     return (script_security() >=3D SSEC_PW_ENV || !is_password_env_var(str=
));
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /* Make arrays of strings */

 const char **
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 2ad2c5d..6f13f49 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -406,6 +406,11 @@
     return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline int
 openvpn_errno_maybe_crt(bool *crt_error)
 {
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index ca84d19..2f4a6bc 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -636,6 +636,11 @@
     return stat;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static struct event_set *
 ep_init(int *maxevents, unsigned int flags)
 {
@@ -1112,6 +1117,10 @@
 }
 #endif /* SELECT */

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static struct event_set *
 event_set_init_simple(int *maxevents, unsigned int flags)
 {
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 7fc42e5..9f7dcce 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -40,6 +40,11 @@
         goto error; \
     }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 fragment_list_buf_init(struct fragment_list *list, const struct frame *fra=
me)
 {
@@ -129,6 +134,10 @@
     f->outgoing_return =3D alloc_buf(BUF_SIZE(frame));
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Accept an incoming datagram (which may be a fragment) from remote.
  * If the datagram is whole (i.e not a fragment), pass through.
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index fb3302d..bdb7e41 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -121,6 +121,11 @@
     return hash->n_buckets;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline struct hash_bucket *
 hash_bucket(struct hash *hash, uint32_t hv)
 {
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 8daaec0..087de9d 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -40,6 +40,12 @@
 #include "memdbg.h"


+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 lzo_compress_init(struct compress_context *compctx)
 {
@@ -72,11 +78,6 @@
     *header =3D NO_COMPRESS_BYTE;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 lzo_decompress(struct buffer *buf, struct buffer work, struct compress_con=
text *compctx,
                const struct frame *frame)
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 448124c..dc6b42f 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -37,6 +37,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif

 struct mbuf_set *
@@ -49,10 +50,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 mbuf_free(struct mbuf_set *ms)
 {
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 168401f..c08ea7a 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -133,6 +133,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif

 /**
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 521677b..4ea8133 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -77,6 +77,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif

 static void
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 108d0f2..f9cc64e 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -62,6 +62,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif

 static inline int
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 63a4cae..e25bd40 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -74,6 +74,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif

 static void
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index f1a2b01..17479f1 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -93,6 +93,11 @@
  * Extract UID or GID
  */

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline int
 platform_state_user_uid(const struct platform_state_user *s)
 {
@@ -111,6 +116,10 @@
     return -1;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void platform_chroot(const char *path);

 void platform_nice(int niceval);
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 769fe65..66626c0 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -455,6 +455,11 @@
 #define _OPENVPN_PATCH_LEVEL "git:" CONFIGURE_GIT_REVISION CONFIGURE_GIT_F=
LAGS
 #endif

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static void
 plugin_open_item(struct plugin *p, const struct plugin_option *o,
                  struct openvpn_plugin_string_list **retlist, const char *=
*envp,
@@ -537,6 +542,10 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 plugin_call_item(const struct plugin *p, void *per_client_context, const i=
nt type,
                  const struct argv *av, struct openvpn_plugin_string_list =
**retlist,
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 0e95c5e..ee3ea5a 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -136,6 +136,11 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 struct ifconfig_pool *
 ifconfig_pool_init(const bool ipv4_pool, enum pool_type type, in_addr_t st=
art, in_addr_t end,
                    const bool duplicate_cn, const bool ipv6_pool, const st=
ruct in6_addr ipv6_base,
@@ -708,6 +713,10 @@
     }
 }
=20
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 ifconfig_pool_write(struct ifconfig_pool_persist *persist, const struct if=
config_pool *pool)
 {
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 0c8b552..26be1d9 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -344,6 +344,12 @@
  * struct reliable member functions.
  */

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 void
 reliable_init(struct reliable *rel, int buf_size, int offset, int array_si=
ze, bool hold)
 {
@@ -687,11 +693,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /* in how many seconds should we wake up to check for timeout */
 /* if we return BIG_TIMEOUT, nothing to wait for */
 interval_t
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index cce9183..466af7e 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -638,6 +638,11 @@
                                             struct link_socket_actual *to);


+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static inline ssize_t
 link_socket_write_udp_posix(struct link_socket *sock, struct buffer *buf,
                             struct link_socket_actual *to)
@@ -660,6 +665,10 @@
     return send(sock->sd, BPTR(buf), BLEN(buf), MSG_NOSIGNAL);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #endif /* ifdef _WIN32 */

 static inline ssize_t
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index 50e8c03..10970e8 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -56,6 +56,12 @@
     return var_value;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 unsigned int
 extract_iv_proto(const char *peer_info)
 {
@@ -290,11 +296,6 @@
     return NULL;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 get_num_elements(const char *string, char delimiter)
 {
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index a9f9498..d3f30b39 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -210,6 +210,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif

 #define STATUS_PRINTF_MAXLEN 512
diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c
index 506d41b..669031a 100644
--- a/src/openvpn/wfp_block.c
+++ b/src/openvpn/wfp_block.c
@@ -131,6 +131,11 @@
     return err;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /*
  * Block outgoing local traffic, possibly DNS only, except for
  * (i) adapter with the specified index (and loopback, if all is blocked)
@@ -340,6 +345,10 @@
     return err;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 DWORD
 delete_wfp_block_filters(HANDLE engine_handle)
 {
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 1819ab0..8dfbc1a 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -940,6 +940,11 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static int
 signature_sign(void *ctx, unsigned char *sig, size_t *siglen, size_t sigsi=
ze,
                const unsigned char *tbs, size_t tbslen)
@@ -1074,6 +1079,10 @@
     return signature_sign(ctx, sig, siglen, sigsize, buf, sz);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* Sign digest using native sign function -- will only work for native keys
  */
 int
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index e7d4a4b..e57285d 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -98,6 +98,10 @@
     return true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif

 void
 x_msg_va(const unsigned int flags, const char *format, va_list arglist)
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index a42c65d..38b6de6 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -26,6 +26,11 @@
 LPCWSTR service_instance =3D L"";
 static wchar_t win_sys_path[MAX_PATH];

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static DWORD
 GetRegString(HKEY key, LPCWSTR value, LPWSTR data, DWORD size, LPCWSTR def=
ault_value)
 {
@@ -52,7 +57,6 @@
     return ERROR_SUCCESS;
 }

-
 DWORD
 GetOpenvpnSettings(settings_t *s)
 {
@@ -274,6 +278,10 @@
     return utf16;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const wchar_t *
 get_win_sys_path(void)
 {
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ce0d4dd..1bddd24 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -512,6 +512,11 @@
     free(sud->directory);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif

 static SOCKADDR_INET
 sockaddr_inet(short family, inet_address_t *addr)
@@ -1383,11 +1388,6 @@
     return TRUE;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * Prepare DNS domain "SearchList" registry value, so additional
  * VPN domains can be added and its original state can be restored
@@ -2619,10 +2619,6 @@
     return err;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  * Return the registry key where NRPT rules are stored
  *
@@ -3561,6 +3557,9 @@
     return 0;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif

 static DWORD WINAPI
 ServiceCtrlInteractive(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID c=
tx)
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index b633e77..fb19118 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -100,6 +100,11 @@
     return fptr;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 /**
  * Returns length of string of strings
  *
diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/=
openvpn/mock_get_random.c
index 77db18e..58ca5f0 100644
--- a/tests/unit_tests/openvpn/mock_get_random.c
+++ b/tests/unit_tests/openvpn/mock_get_random.c
@@ -28,6 +28,11 @@
 #include <stdint.h>
 #include <cmocka.h>

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 unsigned long
 get_random(void)
 {
@@ -35,6 +40,10 @@
     return rand();
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 prng_bytes(uint8_t *output, int len)
 {
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn=
/mock_msg.c
index 603520b..38e036e 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -45,6 +45,10 @@

 char mock_msg_buf[MOCK_MSG_BUF];

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif

 void
 mock_set_debug_level(int level)
@@ -70,6 +74,10 @@
     return x_debug_level;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 x_msg_va(const unsigned int flags, const char *format, va_list arglist)
 {
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/=
openvpn/test_networking.c
index f2da83e..4bda473 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -39,6 +39,11 @@
     return net_iface_del(NULL, name);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-conversion"
+#endif
+
 static int
 net__iface_mtu_set(int mtu)
 {
@@ -47,6 +52,10 @@
     return net_iface_mtu_set(NULL, iface, mtu);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 net__addr_v4_add(const char *addr_str, int prefixlen)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1186?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb
Gerrit-Change-Number: 1186
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--l2eTwLZuXto=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1186?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Enable -Wsign-conversion<br><br>As before with -Wconversion =
override all the known issues<br>to be able to address them one by one.<br>=
<br>Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M =
configure.ac<br>M src/openvpn/argv.c<br>M src/openvpn/base64.c<br>M src/ope=
nvpn/buffer.c<br>M src/openvpn/buffer.h<br>M src/openvpn/clinat.c<br>M src/=
openvpn/comp-lz4.c<br>M src/openvpn/console_builtin.c<br>M src/openvpn/cryp=
to.c<br>M src/openvpn/crypto_epoch.c<br>M src/openvpn/crypto_mbedtls.c<br>M=
 src/openvpn/crypto_openssl.c<br>M src/openvpn/dhcp.c<br>M src/openvpn/env_=
set.c<br>M src/openvpn/error.h<br>M src/openvpn/event.c<br>M src/openvpn/fr=
agment.c<br>M src/openvpn/list.h<br>M src/openvpn/lzo.c<br>M src/openvpn/mb=
uf.c<br>M src/openvpn/networking_sitnl.c<br>M src/openvpn/ntlm.c<br>M src/o=
penvpn/otime.h<br>M src/openvpn/packet_id.c<br>M src/openvpn/platform.h<br>=
M src/openvpn/plugin.c<br>M src/openvpn/pool.c<br>M src/openvpn/reliable.c<=
br>M src/openvpn/socket.h<br>M src/openvpn/ssl_util.c<br>M src/openvpn/stat=
us.c<br>M src/openvpn/wfp_block.c<br>M src/openvpn/xkey_provider.c<br>M src=
/openvpnmsica/dllmain.c<br>M src/openvpnserv/common.c<br>M src/openvpnserv/=
interactive.c<br>M src/tapctl/tap.c<br>M tests/unit_tests/openvpn/mock_get_=
random.c<br>M tests/unit_tests/openvpn/mock_msg.c<br>M tests/unit_tests/ope=
nvpn/test_networking.c<br>41 files changed, 228 insertions(+), 80 deletions=
(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
86/1186/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><s=
pan>index 51f4221..803cdb4 100644</span><br><span>--- a/CMakeLists.txt</spa=
n><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -113,7 +113,7 @@</span>=
<br><span>     check_and_add_compiler_flag(-Wno-stringop-truncation NoStrin=
gOpTruncation)</span><br><span>     check_and_add_compiler_flag(-Wstrict-pr=
ototypes StrictPrototypes)</span><br><span>     check_and_add_compiler_flag=
(-Wold-style-definition OldStyleDefinition)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    add_compile_options(-Wconversion -Wno-sign-conver=
sion)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_compil=
e_options(-Wconversion)</span><br><span>     if (USE_WERROR)</span><br><spa=
n>         add_compile_options(-Werror)</span><br><span>     endif ()</span=
><br><span>diff --git a/configure.ac b/configure.ac</span><br><span>index 9=
57205e..b23939e 100644</span><br><span>--- a/configure.ac</span><br><span>+=
++ b/configure.ac</span><br><span>@@ -1396,7 +1396,7 @@</span><br><span> AC=
L_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])</span><br><span> ACL_=
CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])</span><br><span> ACL_CHECK_A=
DD_COMPILE_FLAGS([-Wold-style-definition])</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sign-co=
nversion])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ACL_CHECK=
_ADD_COMPILE_FLAGS([-Wconversion])</span><br><span> ACL_CHECK_ADD_COMPILE_F=
LAGS([-Wall])</span><br><span> </span><br><span> if test &quot;${enable_ped=
antic}&quot; =3D &quot;yes&quot;; then</span><br><span>diff --git a/src/ope=
nvpn/argv.c b/src/openvpn/argv.c</span><br><span>index 55deef5..5d4ca57 100=
644</span><br><span>--- a/src/openvpn/argv.c</span><br><span>+++ b/src/open=
vpn/argv.c</span><br><span>@@ -323,6 +323,11 @@</span><br><span>     return=
 f;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /**</span><br><span>  *  Create a struct argv based=
 on a format string</span><br><span>  *</span><br><span>@@ -418,6 +423,10 @=
@</span><br><span>     return res;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /**</span><br><span>  *  printf() variant which populates a st=
ruct argv.  It processes the</span><br><span>  *  format string with the pr=
ovided arguments.  For each space separator found</span><br><span>diff --gi=
t a/src/openvpn/base64.c b/src/openvpn/base64.c</span><br><span>index 2a5a4=
6d..00fef04 100644</span><br><span>--- a/src/openvpn/base64.c</span><br><sp=
an>+++ b/src/openvpn/base64.c</span><br><span>@@ -44,6 +44,7 @@</span><br><=
span> #if defined(__GNUC__) || defined(__clang__)</span><br><span> #pragma =
GCC diagnostic push</span><br><span> #pragma GCC diagnostic ignored &quot;-=
Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span>=
 #endif</span><br><span> </span><br><span> static char base64_chars[] =3D &=
quot;ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/&quot;=
;</span><br><span>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c<=
/span><br><span>index b6d6669..023f7fe 100644</span><br><span>--- a/src/ope=
nvpn/buffer.c</span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@=
 -109,6 +109,11 @@</span><br><span>     return buf;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conve=
rsion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> str=
uct buffer</span><br><span> #ifdef DMALLOC</span><br><span> clone_buf_debug=
(const struct buffer *buf, const char *file, int line)</span><br><span>diff=
 --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h</span><br><span>index =
1405667..15377e9 100644</span><br><span>--- a/src/openvpn/buffer.h</span><b=
r><span>+++ b/src/openvpn/buffer.h</span><br><span>@@ -327,6 +327,11 @@</sp=
an><br><span>     return true;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static inline void</spa=
n><br><span> buf_set_write(struct buffer *buf, uint8_t *data, int size)</sp=
an><br><span> {</span><br><span>@@ -851,6 +856,10 @@</span><br><span>     r=
eturn memcmp(BPTR(src), match, size) =3D=3D 0;</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> bool buf_string_match_head_str(const struct buffer=
 *src, const char *match);</span><br><span> </span><br><span> bool buf_stri=
ng_compare_advance(struct buffer *src, const char *match);</span><br><span>=
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c</span><br><span>in=
dex 2d21daf..fdd1a34 100644</span><br><span>--- a/src/openvpn/clinat.c</spa=
n><br><span>+++ b/src/openvpn/clinat.c</span><br><span>@@ -180,6 +180,11 @@=
</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br>=
<span> client_nat_transform(const struct client_nat_option_list *list, stru=
ct buffer *ipbuf,</span><br><span>                      const int direction=
)</span><br><span>diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz=
4.c</span><br><span>index a78c664..87173d6 100644</span><br><span>--- a/src=
/openvpn/comp-lz4.c</span><br><span>+++ b/src/openvpn/comp-lz4.c</span><br>=
<span>@@ -91,6 +91,7 @@</span><br><span> #if defined(__GNUC__) || defined(_=
_clang__)</span><br><span> #pragma GCC diagnostic push</span><br><span> #pr=
agma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsi=
gn-conversion&quot;</span><br><span> #endif</span><br><span> </span><br><sp=
an> static void</span><br><span>@@ -118,10 +119,6 @@</span><br><span>     *=
buf =3D *work;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</=
span><br><span> lz4_decompress(struct buffer *buf, struct buffer work, stru=
ct compress_context *compctx,</span><br><span>                const struct =
frame *frame)</span><br><span>@@ -207,6 +204,10 @@</span><br><span>     }</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const struct compress_a=
lg lz4_alg =3D { &quot;lz4&quot;, lz4_compress_init, lz4_compress_uninit, l=
z4_compress,</span><br><span>                                       lz4_dec=
ompress };</span><br><span> </span><br><span>diff --git a/src/openvpn/conso=
le_builtin.c b/src/openvpn/console_builtin.c</span><br><span>index 71c0025.=
.61d1657 100644</span><br><span>--- a/src/openvpn/console_builtin.c</span><=
br><span>+++ b/src/openvpn/console_builtin.c</span><br><span>@@ -187,6 +187=
,11 @@</span><br><span> </span><br><span> #endif /* HAVE_TERMIOS_H */</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /**</s=
pan><br><span>  *  Core function for getting input from console</span><br><=
span>@@ -273,11 +278,6 @@</span><br><span>     return ret;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversio=
n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><=
br><span>  * @copydoc query_user_exec()</span><br><span>  *</span><br><span=
>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>i=
ndex 8e56881..f033a97 100644</span><br><span>--- a/src/openvpn/crypto.c</sp=
an><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -62,6 +62,12 @@<=
/span><br><span>  * happen unless the frame parameters are wrong.</span><br=
><span>  */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><spa=
n> openvpn_encrypt_aead(struct buffer *buf, struct buffer work, struct cryp=
to_options *opt)</span><br><span> {</span><br><span>@@ -186,11 +192,6 @@</s=
pan><br><span>     return;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> static void</span><br><span> openvpn_encryp=
t_v1(struct buffer *buf, struct buffer work, struct crypto_options *opt)</s=
pan><br><span> {</span><br><span>@@ -1537,10 +1538,6 @@</span><br><span>   =
  gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span>=
<br><span> write_key_file(const int nkeys, const char *filename)</span><br>=
<span> {</span><br><span>@@ -1599,6 +1596,10 @@</span><br><span>     return=
 nbits;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br=
><span> must_have_n_keys(const char *filename, const char *option, const st=
ruct key2 *key2, int n)</span><br><span> {</span><br><span>diff --git a/src=
/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c</span><br><span>index =
7026ff8..e0654d1 100644</span><br><span>--- a/src/openvpn/crypto_epoch.c</s=
pan><br><span>+++ b/src/openvpn/crypto_epoch.c</span><br><span>@@ -38,6 +38=
,12 @@</span><br><span> #include &quot;buffer.h&quot;</span><br><span> #inc=
lude &quot;integer.h&quot;</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagno=
stic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span>=
<br><span> ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *info, int=
 info_len, uint8_t *out,</span><br><span>                  int out_len)</sp=
an><br><span>@@ -72,11 +78,6 @@</span><br><span>     hmac_ctx_free(hmac_ctx=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignore=
d &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> bool</span><br><span> ovpn_expand_label(const uint8_t *secret, size=
_t secret_len, const uint8_t *label, size_t label_len,</span><br><span>    =
               const uint8_t *context, size_t context_len, uint8_t *out, ui=
nt16_t out_len)</span><br><span>@@ -168,10 +169,6 @@</span><br><span>     k=
ey-&gt;epoch =3D epoch_key-&gt;epoch;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> static void</span><br><span> epoch_init_send_key_ctx(struct crypto_=
options *co)</span><br><span> {</span><br><span>diff --git a/src/openvpn/cr=
ypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index 40978d9=
..7a44416 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><=
br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -233,6 +233,=
7 @@</span><br><span> #if defined(__GNUC__) || defined(__clang__)</span><br=
><span> #pragma GCC diagnostic push</span><br><span> #pragma GCC diagnostic=
 ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;<=
/span><br><span> #endif</span><br><span> </span><br><span> bool</span><br><=
span>@@ -765,10 +766,6 @@</span><br><span>     return 1;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> /*</span><br><span>  *</span><br><span>  * Gener=
ic message digest information functions</span><br><span>diff --git a/src/op=
envpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c</span><br><span>index=
 f1bfd9f..4c13fe4 100644</span><br><span>--- a/src/openvpn/crypto_openssl.c=
</span><br><span>+++ b/src/openvpn/crypto_openssl.c</span><br><span>@@ -520=
,6 +520,12 @@</span><br><span>     return ret;</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagno=
stic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> bool</span><br><span> crypto_pem_decode(const c=
har *name, struct buffer *dst, const struct buffer *src)</span><br><span> {=
</span><br><span>@@ -895,11 +901,6 @@</span><br><span>     return EVP_CIPHE=
R_CTX_mode(ctx);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> bool</span><br><span> cipher_ctx_mode_cbc(const ciphe=
r_ctx_t *ctx)</span><br><span> {</span><br><span>@@ -1003,10 +1004,6 @@</sp=
an><br><span>     return cipher_ctx_final(ctx, dst, dst_len);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> /*</span><br><span>  *</span><br><span>  * =
Generic message digest information functions</span><br><span>@@ -1221,21 +1=
218,12 @@</span><br><span>     HMAC_CTX_reset(ctx);</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><spa=
n> hmac_ctx_size(HMAC_CTX *ctx)</span><br><span> {</span><br><span>     ret=
urn HMAC_size(ctx);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span=
><br><span> hmac_ctx_reset(HMAC_CTX *ctx)</span><br><span> {</span><br><spa=
n>diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c</span><br><span>inde=
x 38e8d40..302d6ac 100644</span><br><span>--- a/src/openvpn/dhcp.c</span><b=
r><span>+++ b/src/openvpn/dhcp.c</span><br><span>@@ -75,6 +75,7 @@</span><b=
r><span> #if defined(__GNUC__) || defined(__clang__)</span><br><span> #prag=
ma GCC diagnostic push</span><br><span> #pragma GCC diagnostic ignored &quo=
t;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><sp=
an> #endif</span><br><span> </span><br><span> static in_addr_t</span><br><s=
pan>diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c</span><br><s=
pan>index 487a5e2..3de0374 100644</span><br><span>--- a/src/openvpn/env_set=
.c</span><br><span>+++ b/src/openvpn/env_set.c</span><br><span>@@ -434,6 +4=
34,11 @@</span><br><span>     return (script_security() &gt;=3D SSEC_PW_ENV=
 || !is_password_env_var(str));</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Make arrays of strin=
gs */</span><br><span> </span><br><span> const char **</span><br><span>diff=
 --git a/src/openvpn/error.h b/src/openvpn/error.h</span><br><span>index 2a=
d2c5d..6f13f49 100644</span><br><span>--- a/src/openvpn/error.h</span><br><=
span>+++ b/src/openvpn/error.h</span><br><span>@@ -406,6 +406,11 @@</span><=
br><span>     return err &amp; M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic i=
gnored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> static inline int</span><br><span> openvpn_errno_mayb=
e_crt(bool *crt_error)</span><br><span> {</span><br><span>diff --git a/src/=
openvpn/event.c b/src/openvpn/event.c</span><br><span>index ca84d19..2f4a6b=
c 100644</span><br><span>--- a/src/openvpn/event.c</span><br><span>+++ b/sr=
c/openvpn/event.c</span><br><span>@@ -636,6 +636,11 @@</span><br><span>    =
 return stat;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static struct event_set *</span><br><span=
> ep_init(int *maxevents, unsigned int flags)</span><br><span> {</span><br>=
<span>@@ -1112,6 +1117,10 @@</span><br><span> }</span><br><span> #endif /* =
SELECT */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static struct event_set *</sp=
an><br><span> event_set_init_simple(int *maxevents, unsigned int flags)</sp=
an><br><span> {</span><br><span>diff --git a/src/openvpn/fragment.c b/src/o=
penvpn/fragment.c</span><br><span>index 7fc42e5..9f7dcce 100644</span><br><=
span>--- a/src/openvpn/fragment.c</span><br><span>+++ b/src/openvpn/fragmen=
t.c</span><br><span>@@ -40,6 +40,11 @@</span><br><span>         goto error;=
 \</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnos=
tic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> static void</span><br><span> fragment_list_buf_i=
nit(struct fragment_list *list, const struct frame *frame)</span><br><span>=
 {</span><br><span>@@ -129,6 +134,10 @@</span><br><span>     f-&gt;outgoing=
_return =3D alloc_buf(BUF_SIZE(frame));</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /*</span><br><span>  * Accept an incoming datagram (which=
 may be a fragment) from remote.</span><br><span>  * If the datagram is who=
le (i.e not a fragment), pass through.</span><br><span>diff --git a/src/ope=
nvpn/list.h b/src/openvpn/list.h</span><br><span>index fb3302d..bdb7e41 100=
644</span><br><span>--- a/src/openvpn/list.h</span><br><span>+++ b/src/open=
vpn/list.h</span><br><span>@@ -121,6 +121,11 @@</span><br><span>     return=
 hash-&gt;n_buckets;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> static inline struct hash_bucket *=
</span><br><span> hash_bucket(struct hash *hash, uint32_t hv)</span><br><sp=
an> {</span><br><span>diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c</s=
pan><br><span>index 8daaec0..087de9d 100644</span><br><span>--- a/src/openv=
pn/lzo.c</span><br><span>+++ b/src/openvpn/lzo.c</span><br><span>@@ -40,6 +=
40,12 @@</span><br><span> #include &quot;memdbg.h&quot;</span><br><span> </=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconvers=
ion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> static void</span><br><span> lzo_compre=
ss_init(struct compress_context *compctx)</span><br><span> {</span><br><spa=
n>@@ -72,11 +78,6 @@</span><br><span>     *header =3D NO_COMPRESS_BYTE;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quo=
t;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> static void</span><br><span> lzo_decompress(struct buffer *buf, struct bu=
ffer work, struct compress_context *compctx,</span><br><span>              =
  const struct frame *frame)</span><br><span>diff --git a/src/openvpn/mbuf.=
c b/src/openvpn/mbuf.c</span><br><span>index 448124c..dc6b42f 100644</span>=
<br><span>--- a/src/openvpn/mbuf.c</span><br><span>+++ b/src/openvpn/mbuf.c=
</span><br><span>@@ -37,6 +37,7 @@</span><br><span> #if defined(__GNUC__) |=
| defined(__clang__)</span><br><span> #pragma GCC diagnostic push</span><br=
><span> #pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored =
&quot;-Wsign-conversion&quot;</span><br><span> #endif</span><br><span> </sp=
an><br><span> struct mbuf_set *</span><br><span>@@ -49,10 +50,6 @@</span><b=
r><span>     return ret;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void<=
/span><br><span> mbuf_free(struct mbuf_set *ms)</span><br><span> {</span><b=
r><span>diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networkin=
g_sitnl.c</span><br><span>index 168401f..c08ea7a 100644</span><br><span>---=
 a/src/openvpn/networking_sitnl.c</span><br><span>+++ b/src/openvpn/network=
ing_sitnl.c</span><br><span>@@ -133,6 +133,7 @@</span><br><span> #if define=
d(__GNUC__) || defined(__clang__)</span><br><span> #pragma GCC diagnostic p=
ush</span><br><span> #pragma GCC diagnostic ignored &quot;-Wconversion&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagno=
stic ignored &quot;-Wsign-conversion&quot;</span><br><span> #endif</span><b=
r><span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/ntl=
m.c b/src/openvpn/ntlm.c</span><br><span>index 521677b..4ea8133 100644</spa=
n><br><span>--- a/src/openvpn/ntlm.c</span><br><span>+++ b/src/openvpn/ntlm=
.c</span><br><span>@@ -77,6 +77,7 @@</span><br><span> #if defined(__GNUC__)=
 || defined(__clang__)</span><br><span> #pragma GCC diagnostic push</span><=
br><span> #pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignore=
d &quot;-Wsign-conversion&quot;</span><br><span> #endif</span><br><span> </=
span><br><span> static void</span><br><span>diff --git a/src/openvpn/otime.=
h b/src/openvpn/otime.h</span><br><span>index 108d0f2..f9cc64e 100644</span=
><br><span>--- a/src/openvpn/otime.h</span><br><span>+++ b/src/openvpn/otim=
e.h</span><br><span>@@ -62,6 +62,7 @@</span><br><span> #if defined(__GNUC__=
) || defined(__clang__)</span><br><span> #pragma GCC diagnostic push</span>=
<br><span> #pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignor=
ed &quot;-Wsign-conversion&quot;</span><br><span> #endif</span><br><span> <=
/span><br><span> static inline int</span><br><span>diff --git a/src/openvpn=
/packet_id.c b/src/openvpn/packet_id.c</span><br><span>index 63a4cae..e25bd=
40 100644</span><br><span>--- a/src/openvpn/packet_id.c</span><br><span>+++=
 b/src/openvpn/packet_id.c</span><br><span>@@ -74,6 +74,7 @@</span><br><spa=
n> #if defined(__GNUC__) || defined(__clang__)</span><br><span> #pragma GCC=
 diagnostic push</span><br><span> #pragma GCC diagnostic ignored &quot;-Wco=
nversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span> #e=
ndif</span><br><span> </span><br><span> static void</span><br><span>diff --=
git a/src/openvpn/platform.h b/src/openvpn/platform.h</span><br><span>index=
 f1a2b01..17479f1 100644</span><br><span>--- a/src/openvpn/platform.h</span=
><br><span>+++ b/src/openvpn/platform.h</span><br><span>@@ -93,6 +93,11 @@<=
/span><br><span>  * Extract UID or GID</span><br><span>  */</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static inline =
int</span><br><span> platform_state_user_uid(const struct platform_state_us=
er *s)</span><br><span> {</span><br><span>@@ -111,6 +116,10 @@</span><br><s=
pan>     return -1;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> vo=
id platform_chroot(const char *path);</span><br><span> </span><br><span> vo=
id platform_nice(int niceval);</span><br><span>diff --git a/src/openvpn/plu=
gin.c b/src/openvpn/plugin.c</span><br><span>index 769fe65..66626c0 100644<=
/span><br><span>--- a/src/openvpn/plugin.c</span><br><span>+++ b/src/openvp=
n/plugin.c</span><br><span>@@ -455,6 +455,11 @@</span><br><span> #define _O=
PENVPN_PATCH_LEVEL &quot;git:&quot; CONFIGURE_GIT_REVISION CONFIGURE_GIT_FL=
AGS</span><br><span> #endif</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pu=
sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> static void</span><br><span> plugin_open_item(=
struct plugin *p, const struct plugin_option *o,</span><br><span>          =
        struct openvpn_plugin_string_list **retlist, const char **envp,</sp=
an><br><span>@@ -537,6 +542,10 @@</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> static int</span><br><span> plugin_call_=
item(const struct plugin *p, void *per_client_context, const int type,</spa=
n><br><span>                  const struct argv *av, struct openvpn_plugin_=
string_list **retlist,</span><br><span>diff --git a/src/openvpn/pool.c b/sr=
c/openvpn/pool.c</span><br><span>index 0e95c5e..ee3ea5a 100644</span><br><s=
pan>--- a/src/openvpn/pool.c</span><br><span>+++ b/src/openvpn/pool.c</span=
><br><span>@@ -136,6 +136,11 @@</span><br><span>     return ret;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot=
;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> struct ifconfig_pool *</span><br><span> ifconfig_pool_init(const =
bool ipv4_pool, enum pool_type type, in_addr_t start, in_addr_t end,</span>=
<br><span>                    const bool duplicate_cn, const bool ipv6_pool=
, const struct in6_addr ipv6_base,</span><br><span>@@ -708,6 +713,10 @@</sp=
an><br><span>     }</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> vo=
id</span><br><span> ifconfig_pool_write(struct ifconfig_pool_persist *persi=
st, const struct ifconfig_pool *pool)</span><br><span> {</span><br><span>di=
ff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c</span><br><span>=
index 0c8b552..26be1d9 100644</span><br><span>--- a/src/openvpn/reliable.c<=
/span><br><span>+++ b/src/openvpn/reliable.c</span><br><span>@@ -344,6 +344=
,12 @@</span><br><span>  * struct reliable member functions.</span><br><spa=
n>  */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-=
Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> reliable_=
init(struct reliable *rel, int buf_size, int offset, int array_size, bool h=
old)</span><br><span> {</span><br><span>@@ -687,11 +693,6 @@</span><br><spa=
n>     }</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic =
ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> /* in how many seconds should we wake up to check for timeout=
 */</span><br><span> /* if we return BIG_TIMEOUT, nothing to wait for */</s=
pan><br><span> interval_t</span><br><span>diff --git a/src/openvpn/socket.h=
 b/src/openvpn/socket.h</span><br><span>index cce9183..466af7e 100644</span=
><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/soc=
ket.h</span><br><span>@@ -638,6 +638,11 @@</span><br><span>                =
                             struct link_socket_actual *to);</span><br><spa=
n> </span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsi=
gn-conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> static inline ssize_t</span><br><span> link_socket_write_udp_posix(str=
uct link_socket *sock, struct buffer *buf,</span><br><span>                =
             struct link_socket_actual *to)</span><br><span>@@ -660,6 +665,=
10 @@</span><br><span>     return send(sock-&gt;sd, BPTR(buf), BLEN(buf), M=
SG_NOSIGNAL);</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /=
* ifdef _WIN32 */</span><br><span> </span><br><span> static inline ssize_t<=
/span><br><span>diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.=
c</span><br><span>index 50e8c03..10970e8 100644</span><br><span>--- a/src/o=
penvpn/ssl_util.c</span><br><span>+++ b/src/openvpn/ssl_util.c</span><br><s=
pan>@@ -56,6 +56,12 @@</span><br><span>     return var_value;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-W=
conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pr=
agma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> unsigned int</span><br><span> ex=
tract_iv_proto(const char *peer_info)</span><br><span> {</span><br><span>@@=
 -290,11 +296,6 @@</span><br><span>     return NULL;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><sp=
an> get_num_elements(const char *string, char delimiter)</span><br><span> {=
</span><br><span>diff --git a/src/openvpn/status.c b/src/openvpn/status.c</=
span><br><span>index a9f9498..d3f30b39 100644</span><br><span>--- a/src/ope=
nvpn/status.c</span><br><span>+++ b/src/openvpn/status.c</span><br><span>@@=
 -210,6 +210,7 @@</span><br><span> #if defined(__GNUC__) || defined(__clang=
__)</span><br><span> #pragma GCC diagnostic push</span><br><span> #pragma G=
CC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conv=
ersion&quot;</span><br><span> #endif</span><br><span> </span><br><span> #de=
fine STATUS_PRINTF_MAXLEN 512</span><br><span>diff --git a/src/openvpn/wfp_=
block.c b/src/openvpn/wfp_block.c</span><br><span>index 506d41b..669031a 10=
0644</span><br><span>--- a/src/openvpn/wfp_block.c</span><br><span>+++ b/sr=
c/openvpn/wfp_block.c</span><br><span>@@ -131,6 +131,11 @@</span><br><span>=
     return err;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Block outgoin=
g local traffic, possibly DNS only, except for</span><br><span>  * (i) adap=
ter with the specified index (and loopback, if all is blocked)</span><br><s=
pan>@@ -340,6 +345,10 @@</span><br><span>     return err;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> DWORD</span><br><span> delete_wfp_block=
_filters(HANDLE engine_handle)</span><br><span> {</span><br><span>diff --gi=
t a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c</span><br><sp=
an>index 1819ab0..8dfbc1a 100644</span><br><span>--- a/src/openvpn/xkey_pro=
vider.c</span><br><span>+++ b/src/openvpn/xkey_provider.c</span><br><span>@=
@ -940,6 +940,11 @@</span><br><span>     return ret;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conv=
ersion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> st=
atic int</span><br><span> signature_sign(void *ctx, unsigned char *sig, siz=
e_t *siglen, size_t sigsize,</span><br><span>                const unsigned=
 char *tbs, size_t tbslen)</span><br><span>@@ -1074,6 +1079,10 @@</span><br=
><span>     return signature_sign(ctx, sig, siglen, sigsize, buf, sz);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> /* Sign digest using nativ=
e sign function -- will only work for native keys</span><br><span>  */</spa=
n><br><span> int</span><br><span>diff --git a/src/openvpnmsica/dllmain.c b/=
src/openvpnmsica/dllmain.c</span><br><span>index e7d4a4b..e57285d 100644</s=
pan><br><span>--- a/src/openvpnmsica/dllmain.c</span><br><span>+++ b/src/op=
envpnmsica/dllmain.c</span><br><span>@@ -98,6 +98,10 @@</span><br><span>   =
  return true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>=
 void</span><br><span> x_msg_va(const unsigned int flags, const char *forma=
t, va_list arglist)</span><br><span>diff --git a/src/openvpnserv/common.c b=
/src/openvpnserv/common.c</span><br><span>index a42c65d..38b6de6 100644</sp=
an><br><span>--- a/src/openvpnserv/common.c</span><br><span>+++ b/src/openv=
pnserv/common.c</span><br><span>@@ -26,6 +26,11 @@</span><br><span> LPCWSTR=
 service_instance =3D L&quot;&quot;;</span><br><span> static wchar_t win_sy=
s_path[MAX_PATH];</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic igno=
red &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> static DWORD</span><br><span> GetRegString(HKEY key, LPC=
WSTR value, LPWSTR data, DWORD size, LPCWSTR default_value)</span><br><span=
> {</span><br><span>@@ -52,7 +57,6 @@</span><br><span>     return ERROR_SUC=
CESS;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span> DWORD</span><br><span> GetOpenvpnSet=
tings(settings_t *s)</span><br><span> {</span><br><span>@@ -274,6 +278,10 @=
@</span><br><span>     return utf16;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> const wchar_t *</span><br><span> get_win_sys_path(void)</spa=
n><br><span> {</span><br><span>diff --git a/src/openvpnserv/interactive.c b=
/src/openvpnserv/interactive.c</span><br><span>index ce0d4dd..1bddd24 10064=
4</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b=
/src/openvpnserv/interactive.c</span><br><span>@@ -512,6 +512,11 @@</span><=
br><span>     free(sud-&gt;directory);</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ign=
ored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span> </span><br><span> static SOCKADDR_IN=
ET</span><br><span> sockaddr_inet(short family, inet_address_t *addr)</span=
><br><span>@@ -1383,11 +1388,6 @@</span><br><span>     return TRUE;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
/**</span><br><span>  * Prepare DNS domain &quot;SearchList&quot; registry =
value, so additional</span><br><span>  * VPN domains can be added and its o=
riginal state can be restored</span><br><span>@@ -2619,10 +2619,6 @@</span>=
<br><span>     return err;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**=
</span><br><span>  * Return the registry key where NRPT rules are stored</s=
pan><br><span>  *</span><br><span>@@ -3561,6 +3557,9 @@</span><br><span>   =
  return 0;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span> </span><br><span> static DWORD WINAPI</span><br><span> ServiceCtrl=
Interactive(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)</span><b=
r><span>diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c</span><br><span>in=
dex b633e77..fb19118 100644</span><br><span>--- a/src/tapctl/tap.c</span><b=
r><span>+++ b/src/tapctl/tap.c</span><br><span>@@ -100,6 +100,11 @@</span><=
br><span>     return fptr;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Retu=
rns length of string of strings</span><br><span>  *</span><br><span>diff --=
git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/openvpn=
/mock_get_random.c</span><br><span>index 77db18e..58ca5f0 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/mock_get_random.c</span><br><span>+++ =
b/tests/unit_tests/openvpn/mock_get_random.c</span><br><span>@@ -28,6 +28,1=
1 @@</span><br><span> #include &lt;stdint.h&gt;</span><br><span> #include &=
lt;cmocka.h&gt;</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignore=
d &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> unsigned long</span><br><span> get_random(void)</span><br>=
<span> {</span><br><span>@@ -35,6 +40,10 @@</span><br><span>     return ran=
d();</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><s=
pan> prng_bytes(uint8_t *output, int len)</span><br><span> {</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openv=
pn/mock_msg.c</span><br><span>index 603520b..38e036e 100644</span><br><span=
>--- a/tests/unit_tests/openvpn/mock_msg.c</span><br><span>+++ b/tests/unit=
_tests/openvpn/mock_msg.c</span><br><span>@@ -45,6 +45,10 @@</span><br><spa=
n> </span><br><span> char mock_msg_buf[MOCK_MSG_BUF];</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> <=
/span><br><span> void</span><br><span> mock_set_debug_level(int level)</spa=
n><br><span>@@ -70,6 +74,10 @@</span><br><span>     return x_debug_level;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> x=
_msg_va(const unsigned int flags, const char *format, va_list arglist)</spa=
n><br><span> {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_n=
etworking.c b/tests/unit_tests/openvpn/test_networking.c</span><br><span>in=
dex f2da83e..4bda473 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_networking.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_netwo=
rking.c</span><br><span>@@ -39,6 +39,11 @@</span><br><span>     return net_=
iface_del(NULL, name);</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC=
 diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pr=
agma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> static int</span><br><span> net_=
_iface_mtu_set(int mtu)</span><br><span> {</span><br><span>@@ -47,6 +52,10 =
@@</span><br><span>     return net_iface_mtu_set(NULL, iface, mtu);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static int</span><br><span> n=
et__addr_v4_add(const char *addr_str, int prefixlen)</span><br><span> {</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1186?usp=3Demail">change 1186</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1186?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iecf502ec811e99c56647b2d4529=
8fa0fb66960fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1186 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--l2eTwLZuXto=--

