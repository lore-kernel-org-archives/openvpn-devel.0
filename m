From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 23 Sep 2025 16:15:48 +0000
In-Reply-To: <gerrit.1756894870000.Iad5b00c35a1f1993b1fa99e8b945ab17b230ef59@...2715...>
References: <gerrit.1756894870000.Iad5b00c35a1f1993b1fa99e8b945ab17b230ef59@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <419d339b7c87c336f072a710f83a96e163eab452-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m4jK79s8V8c="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Enable -Wconversion
 -Wno-sign-conversion by default
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

--m4jK79s8V8c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1168?usp=3Demail

to look at the new patch set (#13).


Change subject: Enable -Wconversion -Wno-sign-conversion by default
......................................................................

Enable -Wconversion -Wno-sign-conversion by default

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
---
M CMakeLists.txt
M configure.ac
M src/openvpn/comp-lz4.c
M src/openvpn/console_builtin.c
M src/openvpn/crypto.c
M src/openvpn/crypto_epoch.c
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_openssl.c
M src/openvpn/cryptoapi.c
M src/openvpn/dco.c
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/dhcp.c
M src/openvpn/event.c
M src/openvpn/forward.c
M src/openvpn/gremlin.c
M src/openvpn/httpdigest.c
M src/openvpn/init.c
M src/openvpn/interval.c
M src/openvpn/lzo.c
M src/openvpn/manage.c
M src/openvpn/mbuf.c
M src/openvpn/misc.c
M src/openvpn/mroute.c
M src/openvpn/mss.c
M src/openvpn/mtcp.c
M src/openvpn/mtu.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/networking_sitnl.c
M src/openvpn/ntlm.c
M src/openvpn/occ.c
M src/openvpn/openssl_compat.h
M src/openvpn/options.c
M src/openvpn/options_util.c
M src/openvpn/otime.c
M src/openvpn/otime.h
M src/openvpn/packet_id.c
M src/openvpn/packet_id.h
M src/openvpn/pkcs11.c
M src/openvpn/pkcs11_openssl.c
M src/openvpn/proxy.c
M src/openvpn/ps.c
M src/openvpn/push.c
M src/openvpn/push_util.c
M src/openvpn/reliable.c
M src/openvpn/route.c
M src/openvpn/schedule.c
M src/openvpn/socket.c
M src/openvpn/socks.c
M src/openvpn/ssl.c
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_pkt.c
M src/openvpn/ssl_util.c
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
M src/openvpn/status.c
M src/openvpn/tls_crypt.c
M src/openvpn/tun.c
M src/openvpn/vlan.c
M src/openvpn/win32.c
M src/openvpnserv/interactive.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_ssl.c
68 files changed, 687 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/1168/13

diff --git a/CMakeLists.txt b/CMakeLists.txt
index fdc0162..3f6196f 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -113,8 +113,7 @@
     check_and_add_compiler_flag(-Wno-stringop-truncation NoStringOpTruncat=
ion)
     check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
-    # We are not ready for this
-    #add_compile_options(-Wconversion -Wno-sign-conversion)
+    add_compile_options(-Wconversion -Wno-sign-conversion)
     add_compile_options(-Wextra -Wno-sign-compare -Wno-type-limits -Wno-un=
used-parameter)
     # clang doesn't have the different levels but also doesn't include it =
in -Wextra
     check_and_add_compiler_flag(-Wimplicit-fallthrough=3D2 GCCImplicitFall=
through)
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
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-type-limits -W=
no-unused-parameter])
 # clang doesn't have the different levels but also doesn't include it in -=
Wextra
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
     *buf =3D *work;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 lz4_decompress(struct buffer *buf, struct buffer work, struct compress_con=
text *compctx,
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
 openvpn_encrypt_v1(struct buffer *buf, struct buffer work, struct crypto_o=
ptions *opt)
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
 ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t =
*label, size_t label_len,
                   const uint8_t *context, size_t context_len, uint8_t *out=
, uint16_t out_len)
@@ -163,6 +168,10 @@
     key->epoch =3D epoch_key->epoch;
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
 crypto_pem_encode(const char *name, struct buffer *dst, const struct buffe=
r *src,
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
     CRYPTO_tls1_prf(EVP_md5_sha1(), out1, olen, sec, slen, label, label_le=
n, NULL, 0, NULL, 0);
 }
 #elif !defined(LIBRESSL_VERSION_NUMBER) && !defined(ENABLE_CRYPTO_WOLFSSL)
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 bool
 ssl_tls1_PRF(const uint8_t *seed, size_t seed_len, const uint8_t *secret, =
size_t secret_len,
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
 /* LibreSSL and wolfSSL do not expose a TLS 1.0/1.1 PRF via the same APIs =
as
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
 xkey_cng_ec_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const =
unsigned char *tbs,
@@ -438,6 +443,10 @@
     return (*siglen > 0);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /** Dispatch sign op to xkey_cng_<rsa/ec>_sign */
 static int
 xkey_cng_sign(void *handle, unsigned char *sig, size_t *siglen, const unsi=
gned char *tbs,
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
 dco_install_iroute(struct multi_context *m, struct multi_instance *mi, str=
uct mroute_addr *addr)
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
 dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_sl=
ot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const u=
int8_t *decrypt_key,
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
 send_control_channel_string_dowork(struct tls_session *session, const char=
 *str,
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
     return (get_random() % n) =3D=3D 0;
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
     Hex[HASHHEXLEN] =3D '\0';
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /* calculate H(A1) as per spec */
 void
 DigestCalcHA1(IN char *pszAlg, IN char *pszUserName, IN char *pszRealm, IN=
 char *pszPassword,
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
     top->horizon =3D horizon;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 bool
 event_timeout_trigger(struct event_timeout *et, struct timeval *tv, const =
int et_const_retry)
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
     *header =3D NO_COMPRESS_BYTE;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 lzo_decompress(struct buffer *buf, struct buffer work, struct compress_con=
text *compctx,
                const struct frame *frame)
@@ -121,6 +126,10 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const struct compress_alg lzo_alg =3D { "lzo", lzo_compress_init, lzo_comp=
ress_uninit, lzo_compress,
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
 mroute_get_in_addr_t(struct mroute_addr *ma, const in_addr_t src, unsigned=
 int mask)
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
 multi_create_instance_tcp(struct multi_context *m, struct link_socket *soc=
k)
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
index 9256127..777c62e 100644
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

     return ((const char *)make_base64_string2((unsigned char *)phase3, pha=
se3_bufpos, gc));
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
     c->c2.occ_op =3D -1;
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

 #if OPENSSL_VERSION_NUMBER < 0x30200000L && OPENSSL_VERSION_NUMBER >=3D 0x=
30000000L
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static inline const char *
 SSL_get0_group_name(SSL *s)
 {
     int nid =3D SSL_get_negotiated_group(s);
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
 atoi_constrained(const char *str, int *value, const char *name, int min, i=
nt max, msglvl_t msglevel)
 {
@@ -193,6 +198,10 @@
     return true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static const char *updatable_options[] =3D { "block-ipv6", "block-outside-=
dns",
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
     dest->tv_usec =3D usec;
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
 packet_id_init_recv(struct packet_id_rec *rec, int seq_backtrack, int time=
_backtrack,
                     const char *name, int unit)
@@ -663,6 +668,10 @@
     return epoch;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 packet_id_write_epoch(struct packet_id_send *p, uint16_t epoch, struct buf=
fer *buf)
 {
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index a7eb256..e9d3647 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -280,6 +280,11 @@
     return p->fd >=3D 0;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /* transfer packet_id -> packet_id_persist */
 static inline void
 packet_id_persist_save_obj(struct packet_id_persist *p, const struct packe=
t_id *pid)
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
 tls_ctx_use_pkcs11(struct tls_root_ctx *const ssl_ctx, bool pkcs11_id_mana=
gement,
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
 pkcs11_certificate_serial(pkcs11h_certificate_t certificate, char *serial,=
 size_t serial_len)
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
  * Receive a control message from the parent (sent by the port_share_sendm=
sg
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
 send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_session=
 *session,
@@ -1086,6 +1090,10 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 process_incoming_push_msg(struct context *c, const struct buffer *buffer,
                           bool honor_received_options, unsigned int permis=
sion_mask,
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
 process_incoming_push_update(struct context *c, unsigned int permission_ma=
sk,
                              unsigned int *option_types_found, struct buff=
er *buf,
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
  * Enable an incoming buffer previously returned by a get function as acti=
ve.
  */
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index aa5ce69..156a99e 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1760,6 +1760,10 @@
     return (status !=3D RTA_ERROR);
 }
=20
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
 get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvp=
n_net_ctx_t *ctx)
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
                                socket_descriptor_t ctrl_sd, /* already ope=
n to proxy */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index ba6919b..34036f2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -180,6 +180,11 @@
     frame->tun_mtu =3D max_int(frame->tun_mtu, TLS_CHANNEL_MTU_MIN);
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
  * external_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that =
uses
  * the management interface to request an RSA signature for the supplied h=
ash.
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
     o->ncp_ciphers =3D (char *)ncp_ciphers;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * Checks for availibility of Chacha20-Poly1305 and sets
  * the ncp_cipher to either AES-256-GCM:AES-128-GCM or
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8c8b1e21..eb7f2ea 100644
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
 write_control_auth(struct tls_session *session, struct key_state *ks, stru=
ct buffer *buf,
                    struct link_socket_actual **to_link_addr, int opcode, i=
nt max_ack,
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
=20
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif

 /**
  *  Removes auth_pending and auth_control files from file system
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
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
 x509_get_fingerprint(const mbedtls_md_info_t *md_info, mbedtls_x509_crt *c=
ert, struct gc_arena *gc)
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
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
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
 x509_verify_cert_ku(X509 *x509, const unsigned *const expected_ku, int exp=
ected_len)
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
 tls_crypt_unwrap(const struct buffer *src, struct buffer *dst, struct cryp=
to_options *opt)
 {
@@ -413,6 +418,10 @@
     return buf_copy(wkc, &work);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static bool
 tls_crypt_v2_unwrap_client_key(struct key2 *client_key, struct buffer *met=
adata,
                                struct buffer wrapped_client_key, struct ke=
y_ctx *server_key)
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
 build_dhcp_options_string(struct buffer *buf, const struct tuntap_options =
*o)
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
         (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID) | (htons(vid) & OPENV=
PN_8021Q_MASK_VID);
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
 send_msg_iservice(HANDLE pipe, const void *data, size_t size, ack_message_=
t *ack,
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
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
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
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1168?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad5b00c35a1f1993b1fa99e8b945ab17b230ef59
Gerrit-Change-Number: 1168
Gerrit-PatchSet: 13
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--m4jK79s8V8c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #13</strong> to this change.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1168?usp=3Demail">View =
Change</a></p><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">Enable -Wconversion -Wno-sign-conversion by default<br><br>Grand=
-father all known locations of existing errors,<br>so that -Werror builds s=
till pass and we do not spam<br>build logs.<br><br>Still, this should give =
us a much better roadmap to<br>work on these issues one by one while still =
enabling<br>the warnings for a lot of code-paths.<br><br>In general I did g=
o for least amount of pragmas, so<br>usually there is only one override per=
 file, covering<br>ALL of the failures in that file. While this protects<br=
>a lot of code that doesn&#39;t need it, it also cut down<br>the amount of =
pragmas by a lot.<br><br>This does cover gcc builds including mingw and cla=
ng<br>builds. Does not cover MSVC.<br><br>Once the amount of issues has bee=
n suitable reduced<br>more warnings could be enabled.<br><br>Change-Id: Iad=
5b00c35a1f1993b1fa99e8b945ab17b230ef59<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M configure.ac<br>M =
src/openvpn/comp-lz4.c<br>M src/openvpn/console_builtin.c<br>M src/openvpn/=
crypto.c<br>M src/openvpn/crypto_epoch.c<br>M src/openvpn/crypto_mbedtls.c<=
br>M src/openvpn/crypto_openssl.c<br>M src/openvpn/cryptoapi.c<br>M src/ope=
nvpn/dco.c<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M=
 src/openvpn/dco_win.c<br>M src/openvpn/dhcp.c<br>M src/openvpn/event.c<br>=
M src/openvpn/forward.c<br>M src/openvpn/gremlin.c<br>M src/openvpn/httpdig=
est.c<br>M src/openvpn/init.c<br>M src/openvpn/interval.c<br>M src/openvpn/=
lzo.c<br>M src/openvpn/manage.c<br>M src/openvpn/mbuf.c<br>M src/openvpn/mi=
sc.c<br>M src/openvpn/mroute.c<br>M src/openvpn/mss.c<br>M src/openvpn/mtcp=
.c<br>M src/openvpn/mtu.c<br>M src/openvpn/mudp.c<br>M src/openvpn/multi.c<=
br>M src/openvpn/networking_sitnl.c<br>M src/openvpn/ntlm.c<br>M src/openvp=
n/occ.c<br>M src/openvpn/openssl_compat.h<br>M src/openvpn/options.c<br>M s=
rc/openvpn/options_util.c<br>M src/openvpn/otime.c<br>M src/openvpn/otime.h=
<br>M src/openvpn/packet_id.c<br>M src/openvpn/packet_id.h<br>M src/openvpn=
/pkcs11.c<br>M src/openvpn/pkcs11_openssl.c<br>M src/openvpn/proxy.c<br>M s=
rc/openvpn/ps.c<br>M src/openvpn/push.c<br>M src/openvpn/push_util.c<br>M s=
rc/openvpn/reliable.c<br>M src/openvpn/route.c<br>M src/openvpn/schedule.c<=
br>M src/openvpn/socket.c<br>M src/openvpn/socks.c<br>M src/openvpn/ssl.c<b=
r>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_ncp.c<br>M src/openvpn/s=
sl_openssl.c<br>M src/openvpn/ssl_pkt.c<br>M src/openvpn/ssl_util.c<br>M sr=
c/openvpn/ssl_verify.c<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openv=
pn/ssl_verify_openssl.c<br>M src/openvpn/status.c<br>M src/openvpn/tls_cryp=
t.c<br>M src/openvpn/tun.c<br>M src/openvpn/vlan.c<br>M src/openvpn/win32.c=
<br>M src/openvpnserv/interactive.c<br>M tests/unit_tests/openvpn/test_cryp=
to.c<br>M tests/unit_tests/openvpn/test_ssl.c<br>68 files changed, 687 inse=
rtions(+), 4 deletions(-)<br><br></pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/68/1168/13</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMak=
eLists.txt</span><br><span>index fdc0162..3f6196f 100644</span><br><span>--=
- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ =
-113,8 +113,7 @@</span><br><span>     check_and_add_compiler_flag(-Wno-stri=
ngop-truncation NoStringOpTruncation)</span><br><span>     check_and_add_co=
mpiler_flag(-Wstrict-prototypes StrictPrototypes)</span><br><span>     chec=
k_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    # We are not ready for thi=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #add_compile_opt=
ions(-Wconversion -Wno-sign-conversion)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    add_compile_options(-Wconversion -Wno-sign-conversi=
on)</span><br><span>     add_compile_options(-Wextra -Wno-sign-compare -Wno=
-type-limits -Wno-unused-parameter)</span><br><span>     # clang doesn&#39;=
t have the different levels but also doesn&#39;t include it in -Wextra</spa=
n><br><span>     check_and_add_compiler_flag(-Wimplicit-fallthrough=3D2 GCC=
ImplicitFallthrough)</span><br><span>diff --git a/configure.ac b/configure.=
ac</span><br><span>index c2feeea..8f3c01d 100644</span><br><span>--- a/conf=
igure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -1397,6 +139=
7,7 @@</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncati=
on])</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])</s=
pan><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ACL_CHECK_ADD_COMPILE_FLAG=
S([-Wconversion -Wno-sign-conversion])</span><br><span> ACL_CHECK_ADD_COMPI=
LE_FLAGS([-Wall])</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wn=
o-sign-compare -Wno-type-limits -Wno-unused-parameter])</span><br><span> # =
clang doesn&#39;t have the different levels but also doesn&#39;t include it=
 in -Wextra</span><br><span>diff --git a/src/openvpn/comp-lz4.c b/src/openv=
pn/comp-lz4.c</span><br><span>index 6736469..a78c664 100644</span><br><span=
>--- a/src/openvpn/comp-lz4.c</span><br><span>+++ b/src/openvpn/comp-lz4.c<=
/span><br><span>@@ -88,6 +88,11 @@</span><br><span>     compv2_escape_data_=
ifneeded(buf);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> static void</span><br><span> do_lz4_decompr=
ess(size_t zlen_max, struct buffer *work, struct buffer *buf,</span><br><sp=
an>                   struct compress_context *compctx)</span><br><span>@@ =
-113,6 +118,10 @@</span><br><span>     *buf =3D *work;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> static void</span><br><span> lz4_decompres=
s(struct buffer *buf, struct buffer work, struct compress_context *compctx,=
</span><br><span>                const struct frame *frame)</span><br><span=
>diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c=
</span><br><span>index b0228dd..71c0025 100644</span><br><span>--- a/src/op=
envpn/console_builtin.c</span><br><span>+++ b/src/openvpn/console_builtin.c=
</span><br><span>@@ -45,6 +45,11 @@</span><br><span> </span><br><span> #inc=
lude &quot;win32.h&quot;</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> /**</span><br><span>  * Get input from a Windows conso=
le.</span><br><span>  *</span><br><span>@@ -134,6 +139,10 @@</span><br><spa=
n>     return false;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #=
endif /* _WIN32 */</span><br><span> </span><br><span> </span><br><span>@@ -=
264,6 +273,10 @@</span><br><span>     return ret;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span> </span><br><span> /**</span><br><span>  * @copydoc query_user_exec=
()</span><br><span>@@ -296,3 +309,7 @@</span><br><span> </span><br><span>  =
   return ret;</span><br><span> }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/c=
rypto.c b/src/openvpn/crypto.c</span><br><span>index ec7da43..6376c11 10064=
4</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/open=
vpn/crypto.c</span><br><span>@@ -186,6 +186,11 @@</span><br><span>     retu=
rn;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> static void</span><br><span> openvpn_encrypt_v1(struct b=
uffer *buf, struct buffer work, struct crypto_options *opt)</span><br><span=
> {</span><br><span>@@ -1532,6 +1537,10 @@</span><br><span>     gc_free(&am=
p;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><=
span> write_key_file(const int nkeys, const char *filename)</span><br><span=
> {</span><br><span>diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/c=
rypto_epoch.c</span><br><span>index b5cbc8d..7026ff8 100644</span><br><span=
>--- a/src/openvpn/crypto_epoch.c</span><br><span>+++ b/src/openvpn/crypto_=
epoch.c</span><br><span>@@ -72,6 +72,11 @@</span><br><span>     hmac_ctx_fr=
ee(hmac_ctx);</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> bool</span><br><span> ovpn_expand_label(const =
uint8_t *secret, size_t secret_len, const uint8_t *label, size_t label_len,=
</span><br><span>                   const uint8_t *context, size_t context_=
len, uint8_t *out, uint16_t out_len)</span><br><span>@@ -163,6 +168,10 @@</=
span><br><span>     key-&gt;epoch =3D epoch_key-&gt;epoch;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static void</span><br><span> epoch_i=
nit_send_key_ctx(struct crypto_options *co)</span><br><span> {</span><br><s=
pan>diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.=
c</span><br><span>index 2bab312..076d4ee 100644</span><br><span>--- a/src/o=
penvpn/crypto_mbedtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c<=
/span><br><span>@@ -230,6 +230,11 @@</span><br><span>            &quot;avai=
lable\n&quot;);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> bool</span><br><span> crypto_pem_encode(con=
st char *name, struct buffer *dst, const struct buffer *src,</span><br><spa=
n>                   struct gc_arena *gc)</span><br><span>@@ -760,7 +765,6 =
@@</span><br><span>     return 1;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span=
><br><span>  *</span><br><span>  * Generic message digest information funct=
ions</span><br><span>@@ -1119,4 +1123,9 @@</span><br><span>     return true=
;</span><br><span> }</span><br><span> #endif /* HAVE_MBEDTLS_SSL_TLS_PRF &a=
mp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1) */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ENABLE_CRYPTO_MBEDTLS =
*/</span><br><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/=
crypto_openssl.c</span><br><span>index 2d0265a..7688add 100644</span><br><s=
pan>--- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/cr=
ypto_openssl.c</span><br><span>@@ -895,6 +895,10 @@</span><br><span>     re=
turn EVP_CIPHER_CTX_mode(ctx);</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br=
><span> bool</span><br><span> cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)<=
/span><br><span>@@ -999,6 +1003,9 @@</span><br><span>     return cipher_ctx=
_final(ctx, dst, dst_len);</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span> </span><br><span> /*</span><br><span>  *</span><br>=
<span>@@ -1214,12 +1221,21 @@</span><br><span>     HMAC_CTX_reset(ctx);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignore=
d &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> int</span><br><span> hmac_ctx_size(HMAC_CTX *ctx)</span><br><sp=
an> {</span><br><span>     return HMAC_size(ctx);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> void</span><br><span> hmac_ctx_reset(HMAC_CTX *=
ctx)</span><br><span> {</span><br><span>@@ -1398,6 +1414,11 @@</span><br><s=
pan>     CRYPTO_tls1_prf(EVP_md5_sha1(), out1, olen, sec, slen, label, labe=
l_len, NULL, 0, NULL, 0);</span><br><span> }</span><br><span> #elif !define=
d(LIBRESSL_VERSION_NUMBER) &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> ssl_t=
ls1_PRF(const uint8_t *seed, size_t seed_len, const uint8_t *secret, size_t=
 secret_len,</span><br><span>              uint8_t *output, size_t output_l=
en)</span><br><span>@@ -1443,6 +1464,11 @@</span><br><span>     EVP_PKEY_CT=
X_free(pctx);</span><br><span>     return ret;</span><br><span> }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
op</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #else  /* if=
 defined(LIBRESSL_VERSION_NUMBER) */</span><br><span> /* LibreSSL and wolfS=
SL do not expose a TLS 1.0/1.1 PRF via the same APIs as</span><br><span>  *=
 OpenSSL does. As result they will only be able to support</span><br><span>=
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c</span><br><s=
pan>index d91d9a1..bba6ed2 100644</span><br><span>--- a/src/openvpn/cryptoa=
pi.c</span><br><span>+++ b/src/openvpn/cryptoapi.c</span><br><span>@@ -62,7=
 +62,7 @@</span><br><span>     return 0;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* HAVE_XKEY=
_PROVIDER */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /=
* HAVE_XKEY_PROVIDER */</span><br><span> </span><br><span> static XKEY_EXTE=
RNAL_SIGN_fn xkey_cng_sign;</span><br><span> </span><br><span>@@ -342,6 +34=
2,11 @@</span><br><span>     return rv;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /** Sign hash in tbs=
 using EC key in cd and NCryptSignHash */</span><br><span> static int</span=
><br><span> xkey_cng_ec_sign(CAPI_DATA *cd, unsigned char *sig, size_t *sig=
len, const unsigned char *tbs,</span><br><span>@@ -438,6 +443,10 @@</span><=
br><span>     return (*siglen &gt; 0);</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /** Dispatch sign op to xkey_cng_&lt;rsa/ec&gt;_sign */</s=
pan><br><span> static int</span><br><span> xkey_cng_sign(void *handle, unsi=
gned char *sig, size_t *siglen, const unsigned char *tbs,</span><br><span>d=
iff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 881=
459c..2cf90af 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><spa=
n>+++ b/src/openvpn/dco.c</span><br><span>@@ -491,6 +491,11 @@</span><br><s=
pan>     return true;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> int</span><br><span> dco_p2p_add_new=
_peer(struct context *c)</span><br><span> {</span><br><span>@@ -645,6 +650,=
10 @@</span><br><span>     return 0;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> void</span><br><span> dco_install_iroute(struct multi_contex=
t *m, struct multi_instance *mi, struct mroute_addr *addr)</span><br><span>=
 {</span><br><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco=
_freebsd.c</span><br><span>index d5ca277..b9f6bc7 100644</span><br><span>--=
- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd=
.c</span><br><span>@@ -72,6 +72,11 @@</span><br><span>     return (nvl);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignor=
ed &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> static bool</span><br><span> nvlist_to_sockaddr(const nvlist_t=
 *nvl, struct sockaddr_storage *ss)</span><br><span> {</span><br><span>@@ -=
854,6 +859,10 @@</span><br><span>     return 0;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> int</span><br><span> dco_get_peer_stats(struct co=
ntext *c, const bool raise_sigusr1_on_err)</span><br><span> {</span><br><sp=
an>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br=
><span>index d8357ca..395a38f 100644</span><br><span>--- a/src/openvpn/dco_=
linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -6=
2,6 +62,11 @@</span><br><span> </span><br><span> typedef int (*ovpn_nl_cb)(=
struct nl_msg *msg, void *arg);</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /**</span><br><span>  * @brief resolves the net=
link ID for ovpn-dco</span><br><span>  *</span><br><span>@@ -1298,4 +1303,8=
 @@</span><br><span>     return &quot;AES-128-GCM:AES-256-GCM:AES-192-GCM:C=
HACHA20-POLY1305&quot;;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> #endif /* defined(ENABLE_DCO) &amp;&amp; defined(TARGET_LINUX) */</span><=
br><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><=
br><span>index 2d08ed8..9e52859 100644</span><br><span>--- a/src/openvpn/dc=
o_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -525=
,6 +525,11 @@</span><br><span>     return 0;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><=
span> dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_k=
ey_slot_t slot,</span><br><span>             const uint8_t *encrypt_key, co=
nst uint8_t *encrypt_iv, const uint8_t *decrypt_key,</span><br><span>@@ -56=
4,6 +569,11 @@</span><br><span>     }</span><br><span>     return 0;</span>=
<br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> int</span><br><span> dco_del_key(dco_context_t *dco, unsigned int=
 peerid, dco_key_slot_t slot)</span><br><span> {</span><br><span>diff --git=
 a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c</span><br><span>index 7abade5..3=
8e8d40 100644</span><br><span>--- a/src/openvpn/dhcp.c</span><br><span>+++ =
b/src/openvpn/dhcp.c</span><br><span>@@ -72,6 +72,11 @@</span><br><span>   =
  return -1;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> static in_addr_t</span><br><span> do_extract(st=
ruct dhcp *dhcp, int optlen)</span><br><span> {</span><br><span>@@ -185,3 +=
190,7 @@</span><br><span>     }</span><br><span>     return 0;</span><br><s=
pan> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span>diff --git a/src/openvpn/event.c b/src/openvpn/event.=
c</span><br><span>index 581bdbb..2f60b78 100644</span><br><span>--- a/src/o=
penvpn/event.c</span><br><span>+++ b/src/openvpn/event.c</span><br><span>@@=
 -65,6 +65,11 @@</span><br><span> #define SELECT_MAX_FDS 256</span><br><spa=
n> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> static inline int</span><br><span> tv_to_ms_timeout(const struct ti=
meval *tv)</span><br><span> {</span><br><span>@@ -78,6 +83,10 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef _W=
IN32</span><br><span> </span><br><span> struct we_set</span><br><span>diff =
--git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index=
 12dd6a7..f342958 100644</span><br><span>--- a/src/openvpn/forward.c</span>=
<br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -367,6 +367,11 @@<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC=
 diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pr=
agma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> bool</span><br><span> send_control_c=
hannel_string_dowork(struct tls_session *session, const char *str,</span><b=
r><span>                                    msglvl_t msglevel)</span><br><s=
pan>@@ -1966,6 +1971,10 @@</span><br><span>     perf_pop();</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> void</span><br><span> pre_select(str=
uct context *c)</span><br><span> {</span><br><span>diff --git a/src/openvpn=
/gremlin.c b/src/openvpn/gremlin.c</span><br><span>index e6ebbef..0e5e93f 1=
00644</span><br><span>--- a/src/openvpn/gremlin.c</span><br><span>+++ b/src=
/openvpn/gremlin.c</span><br><span>@@ -98,6 +98,11 @@</span><br><span>     =
return (get_random() % n) =3D=3D 0;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
Return uniformly distributed random number between</span><br><span>  * low =
and high.</span><br><span>@@ -229,4 +234,9 @@</span><br><span>         }</s=
pan><br><span>     }</span><br><span> }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> #endif /* ifdef ENABLE_DEBUG */</spa=
n><br><span>diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.=
c</span><br><span>index be20638..f665b17 100644</span><br><span>--- a/src/o=
penvpn/httpdigest.c</span><br><span>+++ b/src/openvpn/httpdigest.c</span><b=
r><span>@@ -61,6 +61,11 @@</span><br><span>     Hex[HASHHEXLEN] =3D &#39;\0=
&#39;;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnos=
tic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> /* calculate H(A1) as per spec */</span><br><span> vo=
id</span><br><span> DigestCalcHA1(IN char *pszAlg, IN char *pszUserName, IN=
 char *pszRealm, IN char *pszPassword,</span><br><span>@@ -145,4 +150,8 @@<=
/span><br><span>     CvtHex(RespHash, Response);</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> #endif /* if PROXY_DIGEST_AUTH */</span><br><spa=
n>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>inde=
x 0d7a2ec..f8a0fee 100644</span><br><span>--- a/src/openvpn/init.c</span><b=
r><span>+++ b/src/openvpn/init.c</span><br><span>@@ -455,6 +455,11 @@</span=
><br><span> }</span><br><span> #endif /* ENABLE_MANAGEMENT */</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><spa=
n>  * Initialize and possibly randomize the connection list.</span><br><spa=
n>  *</span><br><span>@@ -3490,6 +3495,10 @@</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * No enc=
ryption or authentication.</span><br><span>  */</span><br><span>diff --git =
a/src/openvpn/interval.c b/src/openvpn/interval.c</span><br><span>index 2b3=
5314..fbefcd9 100644</span><br><span>--- a/src/openvpn/interval.c</span><br=
><span>+++ b/src/openvpn/interval.c</span><br><span>@@ -38,6 +38,11 @@</spa=
n><br><span>     top-&gt;horizon =3D horizon;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br=
><span> event_timeout_trigger(struct event_timeout *et, struct timeval *tv,=
 const int et_const_retry)</span><br><span> {</span><br><span>@@ -77,3 +82,=
7 @@</span><br><span>     }</span><br><span>     return ret;</span><br><spa=
n> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span>diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c</spa=
n><br><span>index 3a73d5f..8daaec0 100644</span><br><span>--- a/src/openvpn=
/lzo.c</span><br><span>+++ b/src/openvpn/lzo.c</span><br><span>@@ -72,6 +72=
,11 @@</span><br><span>     *header =3D NO_COMPRESS_BYTE;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wco=
nversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
static void</span><br><span> lzo_decompress(struct buffer *buf, struct buff=
er work, struct compress_context *compctx,</span><br><span>                =
const struct frame *frame)</span><br><span>@@ -121,6 +126,10 @@</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const stru=
ct compress_alg lzo_alg =3D { &quot;lzo&quot;, lzo_compress_init, lzo_compr=
ess_uninit, lzo_compress,</span><br><span>                                 =
      lzo_decompress };</span><br><span> #endif /* ENABLE_LZO */</span><br>=
<span>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><s=
pan>index c675e95..5a41a0f 100644</span><br><span>--- a/src/openvpn/manage.=
c</span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -206,6 +206=
,11 @@</span><br><span>     return man-&gt;settings.up.defined &amp;&amp; !=
man-&gt;connection.password_verified;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br>=
<span> man_check_password(struct management *man, const char *line)</span><=
br><span> {</span><br><span>@@ -236,6 +241,10 @@</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><=
span> man_update_io_state(struct management *man)</span><br><span> {</span>=
<br><span>@@ -2305,6 +2314,11 @@</span><br><span> </span><br><span> #endif =
/* ifdef TARGET_ANDROID */</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagno=
stic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> static int</span><br><span> man_read(struct manageme=
nt *man)</span><br><span> {</span><br><span>@@ -2442,6 +2456,10 @@</span><b=
r><span>     return sent;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> static void</span><br><span> man_connection_clear(struct man_connection=
 *mc)</span><br><span> {</span><br><span>diff --git a/src/openvpn/mbuf.c b/=
src/openvpn/mbuf.c</span><br><span>index 0750fec..448124c 100644</span><br>=
<span>--- a/src/openvpn/mbuf.c</span><br><span>+++ b/src/openvpn/mbuf.c</sp=
an><br><span>@@ -34,6 +34,11 @@</span><br><span> </span><br><span> #include=
 &quot;memdbg.h&quot;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> struct mbuf_set *</span><br><span> mbuf_init(unsigned int=
 size)</span><br><span> {</span><br><span>@@ -44,6 +49,10 @@</span><br><spa=
n>     return ret;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC dia=
gnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> voi=
d</span><br><span> mbuf_free(struct mbuf_set *ms)</span><br><span> {</span>=
<br><span>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><br><s=
pan>index d3d316d..caf4725 100644</span><br><span>--- a/src/openvpn/misc.c<=
/span><br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -72,6 +72,11 @@=
</span><br><span> #endif</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br>=
<span> /* Get username/password from the management interface */</span><br>=
<span> static bool</span><br><span>@@ -184,6 +189,10 @@</span><br><span> </=
span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /*</span><br><span>  * Get and store a username/password</span>=
<br><span>  */</span><br><span>diff --git a/src/openvpn/mroute.c b/src/open=
vpn/mroute.c</span><br><span>index ab01874..88ea647 100644</span><br><span>=
--- a/src/openvpn/mroute.c</span><br><span>+++ b/src/openvpn/mroute.c</span=
><br><span>@@ -103,6 +103,11 @@</span><br><span>     return true;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> static inline void</span><br><span> mroute_get_in_addr_t(struct mro=
ute_addr *ma, const in_addr_t src, unsigned int mask)</span><br><span> {</s=
pan><br><span>@@ -547,6 +552,10 @@</span><br><span>     }</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> void</span><br><span> mroute_helper_fre=
e(struct mroute_helper *mh)</span><br><span> {</span><br><span>diff --git a=
/src/openvpn/mss.c b/src/openvpn/mss.c</span><br><span>index 32cd3f8..e7111=
a8 100644</span><br><span>--- a/src/openvpn/mss.c</span><br><span>+++ b/src=
/openvpn/mss.c</span><br><span>@@ -130,6 +130,11 @@</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ign=
ored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> /*</span><br><span>  * change TCP MSS option in SYN/SYN-ACK =
packets, if present</span><br><span>  * this is generic for IPv4 and IPv6, =
as the TCP header is the same</span><br><span>@@ -199,6 +204,10 @@</span><b=
r><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> stati=
c inline size_t</span><br><span> adjust_payload_max_cbc(const struct key_ty=
pe *kt, size_t target)</span><br><span> {</span><br><span>diff --git a/src/=
openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 81310a2..83edec6 =
100644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/o=
penvpn/mtcp.c</span><br><span>@@ -45,6 +45,11 @@</span><br><span>     unsig=
ned int sock;</span><br><span> };</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> struct multi_instance *</span><br><span> mu=
lti_create_instance_tcp(struct multi_context *m, struct link_socket *sock)<=
/span><br><span> {</span><br><span>@@ -120,6 +125,10 @@</span><br><span>   =
  return true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void<=
/span><br><span> multi_tcp_instance_specific_free(struct multi_instance *mi=
)</span><br><span> {</span><br><span>diff --git a/src/openvpn/mtu.c b/src/o=
penvpn/mtu.c</span><br><span>index 9c1a772..66f81a6 100644</span><br><span>=
--- a/src/openvpn/mtu.c</span><br><span>+++ b/src/openvpn/mtu.c</span><br><=
span>@@ -280,6 +280,11 @@</span><br><span>     struct timeval tv;</span><br=
><span> };</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> const char *</span><br><span> format_extended_socket_error(int fd, =
int *mtu, struct gc_arena *gc)</span><br><span> {</span><br><span>@@ -389,6=
 +394,10 @@</span><br><span>     return BSTR(&amp;out);</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> void</span><br><span> set_sock_extended_e=
rror_passing(int sd, sa_family_t proto_af)</span><br><span> {</span><br><sp=
an>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>ind=
ex 31134be..a373a6a 100644</span><br><span>--- a/src/openvpn/mudp.c</span><=
br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -180,6 +180,11 @@</spa=
n><br><span>     return false;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Get a =
client instance based on real address.  If</span><br><span>  * the instance=
 doesn&#39;t exist, create it while</span><br><span>@@ -310,6 +315,10 @@</s=
pan><br><span>     return mi;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> /*</span><br><span>  * Send a packet to UDP socket.</span><br><span=
>  */</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.=
c</span><br><span>index 9256127..777c62e 100644</span><br><span>--- a/src/o=
penvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@=
 -256,6 +256,11 @@</span><br><span> </span><br><span> #endif</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_ASYN=
C_PUSH</span><br><span> static uint32_t</span><br><span> /*</span><br><span=
>@@ -3982,6 +3987,10 @@</span><br><span>     return count;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static void</span><br><span> managem=
ent_delete_event(void *arg, event_t event)</span><br><span> {</span><br><sp=
an>diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sit=
nl.c</span><br><span>index 00d6106..1815faf 100644</span><br><span>--- a/sr=
c/openvpn/networking_sitnl.c</span><br><span>+++ b/src/openvpn/networking_s=
itnl.c</span><br><span>@@ -131,6 +131,11 @@</span><br><span>     inet_addre=
ss_t gw;</span><br><span> };</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
ush</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> /**</span><br><span>  * Helper function used to ea=
sily add attributes to a rtnl message</span><br><span>  */</span><br><span>=
@@ -1469,6 +1474,10 @@</span><br><span>     return sitnl_send(&amp;req.n, 0=
, 0, NULL, NULL);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #end=
if /* !ENABLE_SITNL */</span><br><span> </span><br><span> #endif /* TARGET_=
LINUX */</span><br><span>diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm=
.c</span><br><span>index c2a93e8..521677b 100644</span><br><span>--- a/src/=
openvpn/ntlm.c</span><br><span>+++ b/src/openvpn/ntlm.c</span><br><span>@@ =
-74,6 +74,11 @@</span><br><span>     hmac_ctx_free(hmac_ctx);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-W=
conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> static void</span><br><span> gen_timestamp(uint8_t *timestamp)</span><br>=
<span> {</span><br><span>@@ -383,4 +388,8 @@</span><br><span> </span><br><s=
pan>     return ((const char *)make_base64_string2((unsigned char *)phase3,=
 phase3_bufpos, gc));</span><br><span> }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> #endif /* if NTLM=
 */</span><br><span>diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c</spa=
n><br><span>index 8821a06..78013ae 100644</span><br><span>--- a/src/openvpn=
/occ.c</span><br><span>+++ b/src/openvpn/occ.c</span><br><span>@@ -174,6 +1=
74,11 @@</span><br><span>     }</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> check_=
send_occ_load_test_dowork(struct context *c)</span><br><span> {</span><br><=
span>@@ -347,6 +352,10 @@</span><br><span>     c-&gt;c2.occ_op =3D -1;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> proc=
ess_received_occ_msg(struct context *c)</span><br><span> {</span><br><span>=
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h</s=
pan><br><span>index 6fd7390..e3e7cf8 100644</span><br><span>--- a/src/openv=
pn/openssl_compat.h</span><br><span>+++ b/src/openvpn/openssl_compat.h</spa=
n><br><span>@@ -194,12 +194,21 @@</span><br><span>           LIBRESSL_VERSI=
ON_NUMBER &gt; 0x3050400fL) */</span><br><span> </span><br><span> #if OPENS=
SL_VERSION_NUMBER &lt; 0x30200000L &amp;&amp; OPENSSL_VERSION_NUMBER &gt;=
=3D 0x30000000L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversi=
on&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static=
 inline const char *</span><br><span> SSL_get0_group_name(SSL *s)</span><br=
><span> {</span><br><span>     int nid =3D SSL_get_negotiated_group(s);</sp=
an><br><span>     return SSL_group_to_name(s, nid);</span><br><span> }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span> #endif</span><br><span> </span><br><span> #endif /* OPENSSL_C=
OMPAT_H_ */</span><br><span>diff --git a/src/openvpn/options.c b/src/openvp=
n/options.c</span><br><span>index 151a016..f801743 100644</span><br><span>-=
-- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</spa=
n><br><span>@@ -1158,6 +1158,11 @@</span><br><span>     return get_ipv6_add=
r(ipv6_prefix_spec, &amp;t_addr, &amp;t_bits, M_WARN);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconvers=
ion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> stati=
c char *</span><br><span> string_substitute(const char *src, int from, int =
to, struct gc_arena *gc)</span><br><span> {</span><br><span>@@ -9900,6 +990=
5,10 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> bool</span><br><span> has_udp_in_local_list(const =
struct options *options)</span><br><span> {</span><br><span>diff --git a/sr=
c/openvpn/options_util.c b/src/openvpn/options_util.c</span><br><span>index=
 fdc0c55..8a1c083 100644</span><br><span>--- a/src/openvpn/options_util.c</=
span><br><span>+++ b/src/openvpn/options_util.c</span><br><span>@@ -162,6 +=
162,11 @@</span><br><span>     return (int)i;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br=
><span> atoi_constrained(const char *str, int *value, const char *name, int=
 min, int max, msglvl_t msglevel)</span><br><span> {</span><br><span>@@ -19=
3,6 +198,10 @@</span><br><span>     return true;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> static const char *updatable_options[] =3D { &qu=
ot;block-ipv6&quot;, &quot;block-outside-dns&quot;,</span><br><span>       =
                                     &quot;dhcp-option&quot;, &quot;dns&quo=
t;,</span><br><span>                                            &quot;ifcon=
fig&quot;, &quot;ifconfig-ipv6&quot;,</span><br><span>diff --git a/src/open=
vpn/otime.c b/src/openvpn/otime.c</span><br><span>index 717f749..d9bf157 10=
0644</span><br><span>--- a/src/openvpn/otime.c</span><br><span>+++ b/src/op=
envpn/otime.c</span><br><span>@@ -100,6 +100,11 @@</span><br><span> </span>=
<br><span> /* format a time_t as ascii, or use current time if 0 */</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const char =
*</span><br><span> time_string(time_t t, long usec, bool show_usec, struct =
gc_arena *gc)</span><br><span> {</span><br><span>@@ -130,6 +135,10 @@</span=
><br><span>     return BSTR(&amp;out);</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /*</span><br><span>  * Limit the frequency of an event str=
eam.</span><br><span>  *</span><br><span>diff --git a/src/openvpn/otime.h b=
/src/openvpn/otime.h</span><br><span>index 5c700bb..108d0f2 100644</span><b=
r><span>--- a/src/openvpn/otime.h</span><br><span>+++ b/src/openvpn/otime.h=
</span><br><span>@@ -59,6 +59,11 @@</span><br><span> extern time_t now_usec=
;</span><br><span> void update_now_usec(struct timeval *tv);</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static inline int<=
/span><br><span> openvpn_gettimeofday(struct timeval *tv, void *tz)</span><=
br><span> {</span><br><span>@@ -236,6 +241,10 @@</span><br><span>     dest-=
&gt;tv_usec =3D usec;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
#define TV_WITHIN_SIGMA_MAX_SEC  600</span><br><span> #define TV_WITHIN_SIG=
MA_MAX_USEC (TV_WITHIN_SIGMA_MAX_SEC * 1000000)</span><br><span> </span><br=
><span>diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c</span=
><br><span>index ca318eb..880eee1 100644</span><br><span>--- a/src/openvpn/=
packet_id.c</span><br><span>+++ b/src/openvpn/packet_id.c</span><br><span>@=
@ -71,6 +71,11 @@</span><br><span> #endif</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span>=
<br><span> packet_id_init_recv(struct packet_id_rec *rec, int seq_backtrack=
, int time_backtrack,</span><br><span>                     const char *name=
, int unit)</span><br><span>@@ -663,6 +668,10 @@</span><br><span>     retur=
n epoch;</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><b=
r><span> packet_id_write_epoch(struct packet_id_send *p, uint16_t epoch, st=
ruct buffer *buf)</span><br><span> {</span><br><span>diff --git a/src/openv=
pn/packet_id.h b/src/openvpn/packet_id.h</span><br><span>index a7eb256..e9d=
3647 100644</span><br><span>--- a/src/openvpn/packet_id.h</span><br><span>+=
++ b/src/openvpn/packet_id.h</span><br><span>@@ -280,6 +280,11 @@</span><br=
><span>     return p-&gt;fd &gt;=3D 0;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* transfer packet_id=
 -&gt; packet_id_persist */</span><br><span> static inline void</span><br><=
span> packet_id_persist_save_obj(struct packet_id_persist *p, const struct =
packet_id *pid)</span><br><span>@@ -291,6 +296,10 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span> =
 * Reset the current send packet id to its initial state.</span><br><span> =
 * Use very carefully (e.g. in the standalone reset packet context) to</spa=
n><br><span>diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c</span>=
<br><span>index 8a7a320..16149ca 100644</span><br><span>--- a/src/openvpn/p=
kcs11.c</span><br><span>+++ b/src/openvpn/pkcs11.c</span><br><span>@@ -53,6=
 +53,11 @@</span><br><span> }</span><br><span> #endif</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><=
span> __mysleep(const unsigned long usec)</span><br><span> {</span><br><spa=
n>@@ -558,6 +563,10 @@</span><br><span>     return success;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> int</span><br><span> tls_ctx_use_pkc=
s11(struct tls_root_ctx *const ssl_ctx, bool pkcs11_id_management,</span><b=
r><span>                    const char *const pkcs11_id)</span><br><span>di=
ff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c</spa=
n><br><span>index 23c01ab..f619b95 100644</span><br><span>--- a/src/openvpn=
/pkcs11_openssl.c</span><br><span>+++ b/src/openvpn/pkcs11_openssl.c</span>=
<br><span>@@ -428,6 +428,11 @@</span><br><span>     return dn;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-=
Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> int</span><br><span> pkcs11_certificate_serial(pkcs11h_certificate_t cer=
tificate, char *serial, size_t serial_len)</span><br><span> {</span><br><sp=
an>@@ -468,4 +473,9 @@</span><br><span> </span><br><span>     return ret;</=
span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> #endif /* defined(ENABLE_PKCS11) &amp;&amp; defined(ENABLE_O=
PENSSL) */</span><br><span>diff --git a/src/openvpn/proxy.c b/src/openvpn/p=
roxy.c</span><br><span>index 9d8fe75..02554ba 100644</span><br><span>--- a/=
src/openvpn/proxy.c</span><br><span>+++ b/src/openvpn/proxy.c</span><br><sp=
an>@@ -54,6 +54,11 @@</span><br><span> }</span><br><span> </span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* cached proxy user=
name/password */</span><br><span> static struct user_pass static_proxy_user=
_pass;</span><br><span> </span><br><span>@@ -1063,3 +1068,7 @@</span><br><s=
pan>     gc_free(&amp;gc);</span><br><span>     return ret;</span><br><span=
> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC=
 diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span>diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c</span><=
br><span>index a10df2e..1d14367 100644</span><br><span>--- a/src/openvpn/ps=
.c</span><br><span>+++ b/src/openvpn/ps.c</span><br><span>@@ -475,6 +475,11=
 @@</span><br><span>     return true;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  *=
 This function runs in the context of the background proxy process.</span><=
br><span>  * Receive a control message from the parent (sent by the port_sh=
are_sendmsg</span><br><span>@@ -792,6 +797,10 @@</span><br><span>     msg(M=
_INFO, &quot;PORT SHARE PROXY: proxy exiting&quot;);</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> /*</span><br><span>  * Called from the main =
OpenVPN process to enable the port</span><br><span>  * share proxy.</span><=
br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><sp=
an>index 60ca25f..e7fc50c 100644</span><br><span>--- a/src/openvpn/push.c</=
span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -429,6 +429,10 @=
@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> =
</span><br><span> bool</span><br><span> send_auth_pending_messages(struct t=
ls_multi *tls_multi, struct tls_session *session,</span><br><span>@@ -1086,=
6 +1090,10 @@</span><br><span>     return ret;</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> int</span><br><span> process_incoming_push_msg(str=
uct context *c, const struct buffer *buffer,</span><br><span>              =
             bool honor_received_options, unsigned int permission_mask,</sp=
an><br><span>diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c=
</span><br><span>index f7a4fca..9138bdb 100644</span><br><span>--- a/src/op=
envpn/push_util.c</span><br><span>+++ b/src/openvpn/push_util.c</span><br><=
span>@@ -9,6 +9,11 @@</span><br><span> #include &quot;multi.h&quot;</span><=
br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignor=
ed &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> int</span><br><span> process_incoming_push_update(struct conte=
xt *c, unsigned int permission_mask,</span><br><span>                      =
        unsigned int *option_types_found, struct buffer *buf,</span><br><sp=
an>@@ -306,3 +311,7 @@</span><br><span>     RETURN_UPDATE_STATUS(n_sent);</=
span><br><span> }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span>diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c</=
span><br><span>index b4a747f..0c8b552 100644</span><br><span>--- a/src/open=
vpn/reliable.c</span><br><span>+++ b/src/openvpn/reliable.c</span><br><span=
>@@ -687,6 +687,11 @@</span><br><span>     }</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* in how many =
seconds should we wake up to check for timeout */</span><br><span> /* if we=
 return BIG_TIMEOUT, nothing to wait for */</span><br><span> interval_t</sp=
an><br><span>@@ -719,6 +724,10 @@</span><br><span>     return ret;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Enable=
 an incoming buffer previously returned by a get function as active.</span>=
<br><span>  */</span><br><span>diff --git a/src/openvpn/route.c b/src/openv=
pn/route.c</span><br><span>index aa5ce69..156a99e 100644</span><br><span>--=
- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br=
><span>@@ -1760,6 +1760,10 @@</span><br><span>     return (status !=3D RTA_=
ERROR);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagno=
stic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span> </span><br><span> void</span><br>=
<span> route_ipv6_clear_host_bits(struct route_ipv6 *r6)</span><br><span>@@=
 -2364,6 +2368,10 @@</span><br><span>     net_ctx_reset(ctx);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * The --redire=
ct-gateway option requires OS-specific code below</span><br><span>  * to ge=
t the current default gateway.</span><br><span>@@ -3360,6 +3368,11 @@</span=
><br><span> </span><br><span> #define max(a, b) ((a) &gt; (b) ? (a) : (b))<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconver=
sion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void=
</span><br><span> get_default_gateway(struct route_gateway_info *rgi, in_ad=
dr_t dest, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span>@@ -3=
733,6 +3746,10 @@</span><br><span>     }</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> #undef max</span><br><span> </span><br><span> #elif defi=
ned(TARGET_HAIKU)</span><br><span>diff --git a/src/openvpn/schedule.c b/src=
/openvpn/schedule.c</span><br><span>index c9fef24..1389889 100644</span><br=
><span>--- a/src/openvpn/schedule.c</span><br><span>+++ b/src/openvpn/sched=
ule.c</span><br><span>@@ -65,6 +65,11 @@</span><br><span> }</span><br><span=
> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot=
;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> static inline void</span><br><span> schedule_set_pri(struct schedule_e=
ntry *e)</span><br><span> {</span><br><span>@@ -75,6 +80,10 @@</span><br><s=
pan>     }</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* This is =
the master key comparison routine.  A key is</span><br><span>  * simply a s=
truct timeval containing the absolute time for</span><br><span>  * an event=
.  The unique treap priority (pri) is used to ensure</span><br><span>diff -=
-git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index af=
edf5d..5fcf820 100644</span><br><span>--- a/src/openvpn/socket.c</span><br>=
<span>+++ b/src/openvpn/socket.c</span><br><span>@@ -72,6 +72,11 @@</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> /*</span><br><span>  * Functions related to=
 the translation of DNS names to IP addresses.</span><br><span>  */</span><=
br><span>@@ -2449,6 +2454,10 @@</span><br><span> #endif</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span> </=
span><br><span> ssize_t</span><br><span>diff --git a/src/openvpn/socks.c b/=
src/openvpn/socks.c</span><br><span>index 1102421..85bbde5 100644</span><br=
><span>--- a/src/openvpn/socks.c</span><br><span>+++ b/src/openvpn/socks.c<=
/span><br><span>@@ -80,6 +80,11 @@</span><br><span>     free(sp);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> static bool</span><br><span> socks_proxy_recv_char(char *c, const c=
har *name, socket_descriptor_t sd,</span><br><span>                       s=
truct event_timeout *server_poll_timeout,</span><br><span>@@ -438,6 +443,10=
 @@</span><br><span>     return;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> void</span><br><span> establish_socks_proxy_udpassoc(struct sock=
s_proxy_info *p,</span><br><span>                                socket_des=
criptor_t ctrl_sd, /* already open to proxy */</span><br><span>diff --git a=
/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index ba6919b..34036=
f2 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src=
/openvpn/ssl.c</span><br><span>@@ -180,6 +180,11 @@</span><br><span>     fr=
ame-&gt;tun_mtu =3D max_int(frame-&gt;tun_mtu, TLS_CHANNEL_MTU_MIN);</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &=
quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> /**</span><br><span>  * calculate the maximum overhead that contro=
l channel frames have</span><br><span>  * This includes header, op code and=
 everything apart from the</span><br><span>@@ -222,6 +227,10 @@</span><br><=
span>     return overhead;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> void</span><br><span> init_ssl_lib(void)</span><br><span> {</span><br>=
<span>@@ -1120,6 +1129,11 @@</span><br><span>     }</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span=
><br><span>  * Return true if &quot;lame duck&quot; or retiring key has exp=
ired and can</span><br><span>  * no longer be used.</span><br><span>@@ -397=
9,6 +3993,10 @@</span><br><span>     ASSERT(buf_write_prepend(buf, &amp;op,=
 1));</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><=
span> tls_prepend_opcode_v2(const struct tls_multi *multi, struct buffer *b=
uf)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_mbedtls=
.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index b2d511e..80eb51b 10064=
4</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src=
/openvpn/ssl_mbedtls.c</span><br><span>@@ -585,6 +585,11 @@</span><br><span=
>     return 0;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> /**</span><br><span>  * external_pkcs1_sign=
 implements a mbed TLS rsa_sign_func callback, that uses</span><br><span>  =
* the management interface to request an RSA signature for the supplied has=
h.</span><br><span>@@ -1004,6 +1009,10 @@</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> tls_version=
_max(void)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_=
ncp.c b/src/openvpn/ssl_ncp.c</span><br><span>index 958acea..790e50f 100644=
</span><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/open=
vpn/ssl_ncp.c</span><br><span>@@ -534,6 +534,11 @@</span><br><span>     }</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic igno=
red &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> /**</span><br><span>  * Replaces the string DEFAULT with the =
string \c replace.</span><br><span>  *</span><br><span>@@ -566,6 +571,10 @@=
</span><br><span>     o-&gt;ncp_ciphers =3D (char *)ncp_ciphers;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Checks f=
or availibility of Chacha20-Poly1305 and sets</span><br><span>  * the ncp_c=
ipher to either AES-256-GCM:AES-128-GCM or</span><br><span>diff --git a/src=
/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 8c=
8b1e21..eb7f2ea 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</spa=
n><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -272,6 +272,=
11 @@</span><br><span>     return 0;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><=
span> tls_ctx_set_tls_versions(struct tls_root_ctx *ctx, unsigned int ssl_f=
lags)</span><br><span> {</span><br><span>@@ -424,6 +429,10 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
op</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><=
br><span> tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ci=
phers)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_pkt.=
c b/src/openvpn/ssl_pkt.c</span><br><span>index 6ec05a7..825719c 100644</sp=
an><br><span>--- a/src/openvpn/ssl_pkt.c</span><br><span>+++ b/src/openvpn/=
ssl_pkt.c</span><br><span>@@ -160,6 +160,11 @@</span><br><span>     }</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored =
&quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> void</span><br><span> write_control_auth(struct tls_session *sess=
ion, struct key_state *ks, struct buffer *buf,</span><br><span>            =
        struct link_socket_actual **to_link_addr, int opcode, int max_ack,<=
/span><br><span>@@ -495,6 +500,10 @@</span><br><span>     return result.sid=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span=
> check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,</span>=
<br><span>                               const struct openvpn_sockaddr *fro=
m,</span><br><span>diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_ut=
il.c</span><br><span>index 918a1f1..50e8c03 100644</span><br><span>--- a/sr=
c/openvpn/ssl_util.c</span><br><span>+++ b/src/openvpn/ssl_util.c</span><br=
><span>@@ -290,6 +290,11 @@</span><br><span>     return NULL;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-W=
conversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> int</span><br><span> get_num_elements(const char *string, char delimiter)=
</span><br><span> {</span><br><span>@@ -309,3 +314,7 @@</span><br><span> </=
span><br><span>     return element_count;</span><br><span> }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br=
><span>index 7658f2d..04ef27e 100644</span><br><span>--- a/src/openvpn/ssl_=
verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ =
-874,6 +874,11 @@</span><br><span>     return supported;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconve=
rsion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**=
</span><br><span>  *  Checks if the deferred state should also send auth pe=
nding</span><br><span>  *  request to the client. Also removes the auth_pen=
ding control file</span><br><span>@@ -945,6 +950,9 @@</span><br><span>     =
return ret;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span> </span><br><span> /**</span><br><span>  *  Removes auth_pending an=
d auth_control files from file system</span><br><span>diff --git a/src/open=
vpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c</span><br><span=
>index c92eaf1..472eb49 100644</span><br><span>--- a/src/openvpn/ssl_verify=
_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.c</span><br=
><span>@@ -250,6 +250,11 @@</span><br><span>     return FAILURE;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot=
;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> static struct buffer</span><br><span> x509_get_fingerprint(const mbedt=
ls_md_info_t *md_info, mbedtls_x509_crt *cert, struct gc_arena *gc)</span><=
br><span> {</span><br><span>@@ -260,6 +265,10 @@</span><br><span>     retur=
n fingerprint;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struc=
t buffer</span><br><span> x509_get_sha1_fingerprint(mbedtls_x509_crt *cert,=
 struct gc_arena *gc)</span><br><span> {</span><br><span>diff --git a/src/o=
penvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c</span><br><s=
pan>index f1b8902..40d117b 100644</span><br><span>--- a/src/openvpn/ssl_ver=
ify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_openssl.c</span>=
<br><span>@@ -667,6 +667,11 @@</span><br><span>     return FAILURE;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> result_t</span><br><span> x509_verify_cert_ku(X509 *x509, const uns=
igned *const expected_ku, int expected_len)</span><br><span> {</span><br><s=
pan>@@ -726,6 +731,10 @@</span><br><span>     return fFound;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> result_t</span><br><span> x509_verif=
y_cert_eku(X509 *x509, const char *const expected_oid)</span><br><span> {</=
span><br><span>diff --git a/src/openvpn/status.c b/src/openvpn/status.c</sp=
an><br><span>index cea31f5..1e1e3fb 100644</span><br><span>--- a/src/openvp=
n/status.c</span><br><span>+++ b/src/openvpn/status.c</span><br><span>@@ -2=
07,6 +207,11 @@</span><br><span>     return ret;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #define STA=
TUS_PRINTF_MAXLEN 512</span><br><span> </span><br><span> void</span><br><sp=
an>@@ -303,3 +308,7 @@</span><br><span> </span><br><span>     return ret;</=
span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/tls_crypt.c b/src=
/openvpn/tls_crypt.c</span><br><span>index 737b556..51b4eb3 100644</span><b=
r><span>--- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls=
_crypt.c</span><br><span>@@ -205,6 +205,11 @@</span><br><span>     return f=
alse;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> bool</span><br><span> tls_crypt_unwrap(const struct bu=
ffer *src, struct buffer *dst, struct crypto_options *opt)</span><br><span>=
 {</span><br><span>@@ -413,6 +418,10 @@</span><br><span>     return buf_cop=
y(wkc, &amp;work);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC dia=
gnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> sta=
tic bool</span><br><span> tls_crypt_v2_unwrap_client_key(struct key2 *clien=
t_key, struct buffer *metadata,</span><br><span>                           =
     struct buffer wrapped_client_key, struct key_ctx *server_key)</span><b=
r><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>=
index c213c4b..e35f889 100644</span><br><span>--- a/src/openvpn/tun.c</span=
><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -1720,6 +1720,11 @@</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static int</span><br><span> write_tu=
n_header(struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span=
><br><span>@@ -1773,6 +1778,11 @@</span><br><span>         return read(tt-&=
gt;fd, buf, len);</span><br><span>     }</span><br><span> }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* if defin=
ed (TARGET_OPENBSD) || defined(TARGET_DARWIN) */</span><br><span> </span><b=
r><span> bool</span><br><span>@@ -2244,6 +2254,11 @@</span><br><span>     f=
ree(tt);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pu=
sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> int</span><br><span> write_tun(struct tuntap *tt, u=
int8_t *buf, int len)</span><br><span> {</span><br><span>@@ -2256,6 +2271,1=
0 @@</span><br><span>     return read(tt-&gt;fd, buf, len);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> #elif defined(TARGET_SOLARIS)</span>=
<br><span> </span><br><span> #ifndef TUNNEWPPA</span><br><span>@@ -2935,6 +=
2954,11 @@</span><br><span>     argv_free(&amp;argv);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversi=
on&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</s=
pan><br><span> write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><b=
r><span> {</span><br><span>@@ -2989,6 +3013,10 @@</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #elif defined(TARGET_DR=
AGONFLY)</span><br><span> </span><br><span> static inline int</span><br><sp=
an>@@ -3277,6 +3305,11 @@</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span>=
<br><span> close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><=
span> {</span><br><span>@@ -3326,6 +3359,10 @@</span><br><span>     }</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> #elif defined(TARGET_AIX)</=
span><br><span> </span><br><span> void</span><br><span>@@ -5517,6 +5554,11 =
@@</span><br><span>     return ret;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
Convert DHCP options from the command line / config file</span><br><span>  =
* into a raw DHCP-format options string.</span><br><span>@@ -5656,6 +5698,1=
0 @@</span><br><span>     buf_write(buf, tmp_buf, len);</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static bool</span><br><span> build_dhcp_o=
ptions_string(struct buffer *buf, const struct tuntap_options *o)</span><br=
><span> {</span><br><span>diff --git a/src/openvpn/vlan.c b/src/openvpn/vla=
n.c</span><br><span>index a6a6e93..3da470a 100644</span><br><span>--- a/src=
/openvpn/vlan.c</span><br><span>+++ b/src/openvpn/vlan.c</span><br><span>@@=
 -43,6 +43,11 @@</span><br><span>     return ntohs(hdr-&gt;pcp_cfi_vid &amp=
; OPENVPN_8021Q_MASK_VID);</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Set the VL=
AN Identifier (VID) in an IEEE 802.1Q header.</span><br><span>  *</span><br=
><span>@@ -56,6 +61,10 @@</span><br><span>         (hdr-&gt;pcp_cfi_vid &am=
p; ~OPENVPN_8021Q_MASK_VID) | (htons(vid) &amp; OPENVPN_8021Q_MASK_VID);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
vlan_decapsulate - remove 802.1q header and return VID</span><br><span>  *<=
/span><br><span>diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c</spa=
n><br><span>index 15bcf37..eac2352 100644</span><br><span>--- a/src/openvpn=
/win32.c</span><br><span>+++ b/src/openvpn/win32.c</span><br><span>@@ -1418=
,6 +1418,11 @@</span><br><span>     return (const char *)out.data;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> bool</span><br><span> send_msg_iservice(HANDLE pipe, const void *da=
ta, size_t size, ack_message_t *ack,</span><br><span>                   con=
st char *context)</span><br><span>@@ -1632,4 +1637,8 @@</span><br><span>   =
  return ret;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /=
* ifdef _WIN32 */</span><br><span>diff --git a/src/openvpnserv/interactive.=
c b/src/openvpnserv/interactive.c</span><br><span>index 0983e59..ce0d4dd 10=
0644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>++=
+ b/src/openvpnserv/interactive.c</span><br><span>@@ -1383,6 +1383,11 @@</s=
pan><br><span>     return TRUE;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Prep=
are DNS domain &quot;SearchList&quot; registry value, so additional</span><=
br><span>  * VPN domains can be added and its original state can be restore=
d</span><br><span>@@ -2614,6 +2619,10 @@</span><br><span>     return err;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 Return the registry key where NRPT rules are stored</span><br><span>  *</s=
pan><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/u=
nit_tests/openvpn/test_crypto.c</span><br><span>index 3f327c2..22e6912 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -674,6=
 +674,11 @@</span><br><span>     struct crypto_options co;</span><br><span>=
 };</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wco=
nversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
static int</span><br><span> crypto_test_epoch_setup(void **state)</span><br=
><span> {</span><br><span>@@ -694,6 +699,10 @@</span><br><span>     return =
0;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static int</span><b=
r><span> crypto_test_epoch_teardown(void **state)</span><br><span> {</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tes=
ts/openvpn/test_ssl.c</span><br><span>index bb02fcc..ed40a7d 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/te=
sts/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -133,6 +133,11 @@</spa=
n><br><span>     const char *keyfile;</span><br><span> } global_state;</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wconversion=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static i=
nt</span><br><span> init(void **state)</span><br><span> {</span><br><span>@=
@ -154,6 +159,10 @@</span><br><span>     return 0;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> static int</span><br><span> cleanup(void **sta=
te)</span><br><span> {</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1168?usp=3Demail">change 11=
68</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1168?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iad5b00c35a1f1993b1fa99e8b94=
5ab17b230ef59 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1168 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--m4jK79s8V8c=--

