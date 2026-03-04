From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 16:12:08 +0000
In-Reply-To: <gerrit.1763654024000.I880cf01b0db80fc9b40ca4afa30aa51e3fb8ce3b@...2715...>
References: <gerrit.1763654024000.I880cf01b0db80fc9b40ca4afa30aa51e3fb8ce3b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9006bc670dc6b8d0c86ed1018c3a23e8ad075b24-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LxOKGoJaRdI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Enable -Wsign-compare
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LxOKGoJaRdI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
86?usp=3Demail )

Change subject: Enable -Wsign-compare
......................................................................

Enable -Wsign-compare

As we did before with -Wconversion, ignore existing
issues for now so that we can tackle them one-by-one.

Change-Id: I880cf01b0db80fc9b40ca4afa30aa51e3fb8ce3b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1386
Message-Id: <20260304142720.1311-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
888.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M configure.ac
M src/openvpn/argv.c
M src/openvpn/auth_token.c
M src/openvpn/buffer.c
M src/openvpn/crypto.c
M src/openvpn/crypto_epoch.c
M src/openvpn/crypto_mbedtls_legacy.c
M src/openvpn/crypto_openssl.c
M src/openvpn/cryptoapi.c
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/dns.c
M src/openvpn/error.c
M src/openvpn/init.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/options.c
M src/openvpn/ps.c
M src/openvpn/push.c
M src/openvpn/route.c
M src/openvpn/socket.c
M src/openvpn/ssl.c
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
M src/openvpn/status.c
M src/openvpn/tls_crypt.c
M src/openvpn/tun.c
M src/openvpn/wfp_block.c
M src/openvpn/win32-util.c
M src/openvpnmsica/dllmain.c
M src/openvpnserv/interactive.c
M src/plugins/auth-pam/auth-pam.c
M tests/unit_tests/openvpn/test_auth_token.c
39 files changed, 386 insertions(+), 4 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 566da71..198c98f 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -117,7 +117,7 @@
     check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
     add_compile_options(-Wconversion -Wno-sign-conversion)
-    add_compile_options(-Wextra -Wno-sign-compare -Wno-unused-parameter)
+    add_compile_options(-Wextra -Wno-unused-parameter)
     # clang doesn't have the different levels but also doesn't include it =
in -Wextra
     check_and_add_compiler_flag(-Wimplicit-fallthrough=3D2 GCCImplicitFall=
through)
     if (WIN32)
diff --git a/configure.ac b/configure.ac
index e151816..ecef2b9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1261,7 +1261,7 @@
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sign-conversion])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-unused-paramet=
er])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-unused-parameter])
 # clang doesn't have the different levels but also doesn't include it in -=
Wextra
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wimplicit-fallthrough=3D2])
 if test "${WIN32}" =3D "yes"; then
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 8e37115..b5d9603 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -263,6 +263,11 @@
     gc_free(&gc);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /**
  *  Prepares argv format string for further processing
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
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index a694e81..eb2b4d5 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -287,6 +287,11 @@
     return memcmp_constant_time(&hmac_output, hmac, 32) =3D=3D 0;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 unsigned int
 verify_auth_token(struct user_pass *up, struct tls_multi *multi, struct tl=
s_session *session)
 {
@@ -391,6 +396,10 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 wipe_auth_token(struct tls_multi *multi)
 {
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 745b1c8..75110ed 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -280,6 +280,11 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /*
  * write a string to the end of a buffer that was
  * truncated by buf_printf
@@ -1308,6 +1313,10 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 buffer_list_aggregate(struct buffer_list *bl, const size_t max)
 {
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 7d32ee8..748b5b5 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -39,6 +39,11 @@

 #include "memdbg.h"

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /*
  * Encryption and Compression Routines.
  *
@@ -1275,6 +1280,10 @@
     gc_free(&gc);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 const char *
 print_key_filename(const char *str, bool is_inline)
 {
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 3a716f4..f04ba4b4 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -72,6 +72,11 @@
     hmac_ctx_free(hmac_ctx);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 bool
 ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t =
*label, size_t label_len,
                   const uint8_t *context, size_t context_len, uint8_t *out=
, int out_len)
@@ -114,6 +119,10 @@
     return true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * Iterates the epoch key to make it E_n+1, ie increase the epoch by one
  * and derive the new key material accordingly
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedt=
ls_legacy.c
index 237564c..b234632 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -236,6 +236,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-compare"
 #endif

 bool
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index a8507c2..de3878d 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1190,6 +1190,11 @@
     HMAC_CTX_free(ctx);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 void
 hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *key, const char *mdname)
 {
@@ -1207,6 +1212,10 @@
     ASSERT(HMAC_size(ctx) <=3D key_len);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 hmac_ctx_cleanup(HMAC_CTX *ctx)
 {
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 49f5bbb..b74320d 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -61,7 +61,7 @@
     return 0;
 }

-#else  /* HAVE_XKEY_PROVIDER */
+#else /* HAVE_XKEY_PROVIDER */

 static XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;

@@ -145,6 +145,11 @@
     free(cd);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /**
  * Parse a hex string with optional embedded spaces into
  * a byte array.
@@ -177,6 +182,10 @@
     return i;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void *
 decode_object(struct gc_arena *gc, LPCSTR struct_type, const CRYPT_OBJID_B=
LOB *val, DWORD flags,
               DWORD *cb)
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 718cd8b..a1e373d 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -559,6 +559,11 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 static void
 dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlis=
t_t *nvl)
 {
@@ -577,6 +582,10 @@
         __func__, peerid, mi->context.c2.dco_read_bytes, mi->context.c2.dc=
o_write_bytes);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 dco_read_and_process(dco_context_t *dco)
 {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3ad8b90..b92fa43 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -858,6 +858,11 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 static int
 ovpn_handle_peer(dco_context_t *dco, struct nlattr *attrs[])
 {
@@ -913,6 +918,10 @@
     return NL_OK;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static bool
 ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[])
 {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 695bf41..f46c24d 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -739,6 +739,11 @@
     return 0;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 int
 dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_e=
rr)
 {
@@ -866,6 +871,10 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 dco_get_peer_stats_fallback(struct context *c, const bool raise_sigusr1_on=
_err)
 {
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 3a294ec..4a4bb0c 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -475,7 +475,12 @@
     send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }

-#else  /* ifdef _WIN32 */
+#else /* ifdef _WIN32 */
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif

 static void
 setenv_dns_option(struct env_set *es, const char *format, int i, int j, co=
nst char *value)
@@ -560,6 +565,10 @@
     gc_free(&gc);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 updown_env_set(bool up, const struct dns_options *o, const struct tuntap *=
tt, struct env_set *es)
 {
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index bc8cc98..6fb4f32 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -97,6 +97,11 @@
     forked =3D true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 bool
 set_debug_level(const int level, const unsigned int flags)
 {
@@ -113,6 +118,10 @@
     return false;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 set_mute_cutoff(const int cutoff)
 {
@@ -612,6 +621,11 @@
     x_cs_verbose_level =3D verbose_level;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /*
  * Called after most socket or tun/tap operations, via the inline
  * function check_status().
@@ -680,6 +694,10 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * In multiclient mode, put a client-specific prefix
  * before each message.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1391aa85..34ed4eb 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -325,6 +325,11 @@
     return l->len;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 static bool
 management_callback_remote_entry_get(void *arg, unsigned int index, char *=
*remote)
 {
@@ -359,6 +364,10 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static bool
 management_callback_remote_cmd(void *arg, const char **p)
 {
@@ -457,6 +466,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-compare"
 #endif

 /*
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 8b2332e..b359750 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -180,6 +180,11 @@
     return false;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
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
index d983793..1625fd0 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -704,6 +704,11 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /*
  * Create a client instance object for a newly connected client.
  */
@@ -794,6 +799,10 @@
     return NULL;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Dump tables -- triggered by SIGUSR2.
  * If status file is defined, write to file.
@@ -4119,6 +4128,11 @@
 #endif /* ifdef ENABLE_MANAGEMENT */
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 void
 multi_assign_peer_id(struct multi_context *m, struct multi_instance *mi)
 {
@@ -4140,6 +4154,10 @@
     ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /**
  * @brief Determines the earliest wakeup interval based on periodic operat=
ions.
  *
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 11f68b0..c686e47 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -380,6 +380,11 @@

 #endif

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /*
  * Return true if our output queue is not full
  */
@@ -396,6 +401,10 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Determine which instance has pending output
  * and prepare the output for sending in
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fdbc678..8daec42 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4673,6 +4673,11 @@
     return BSTR(&out);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 char *
 options_string_extract_option(const char *options_string, const char *opt_=
name, struct gc_arena *gc)
 {
@@ -4702,6 +4707,10 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * parse/print topology coding
  */
@@ -5541,6 +5550,11 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 void
 add_option(struct options *options, char *p[], bool is_inline, const char =
*file, int line,
            const int level, const msglvl_t msglevel, const unsigned int pe=
rmission_mask,
@@ -9258,6 +9272,10 @@
     gc_free(&gc);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 has_udp_in_local_list(const struct options *options)
 {
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 3b8fd84..c589248 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -327,6 +327,11 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /*
  * Record IP/port of client in filesystem, so that server receiving
  * the proxy can determine true client origin.
@@ -368,6 +373,10 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Cleanup function, on proxy process exit.
  */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 5ee43a8..8541467 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -800,6 +800,11 @@
     gc_free(&gc);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 bool
 send_push_reply(struct context *c, struct push_list *per_client_push_list)
 {
@@ -939,6 +944,10 @@
     return true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 push_reset(struct options *o)
 {
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 9a0dcc4..329f3b0 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -570,6 +570,11 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 static void
 add_block_local_routes(struct route_list *rl)
 {
@@ -602,6 +607,10 @@
            && (rl->spec.flags & RTSA_REMOTE_ENDPOINT) && rl->spec.remote_h=
ost_local !=3D TLA_LOCAL;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 init_route_list(struct route_list *rl, const struct route_option_list *opt,
                 const char *remote_endpoint, int default_metric, in_addr_t=
 remote_host,
@@ -1436,6 +1445,11 @@
 #define LR_MATCH   1 /* route is local */
 #define LR_ERROR   2 /* caller should abort adding route */

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 static int
 local_route(in_addr_t network, in_addr_t netmask, in_addr_t gateway,
             const struct route_gateway_info *rgi)
@@ -1465,6 +1479,10 @@
     return LR_NOMATCH;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* Return true if the "on-link" form of the route should be used.  This is=
 when the gateway for
  * a route is specified as an interface rather than an address. */
 #if defined(TARGET_LINUX) || defined(_WIN32) || defined(TARGET_DARWIN)
@@ -2869,6 +2887,11 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR o=
n error */
 static int
 do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const st=
ruct tuntap *tt)
@@ -3018,6 +3041,10 @@
     return status;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR o=
n error */
 static int
 add_route_service(const struct route_ipv4 *r, const struct tuntap *tt)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 2d5fc50..8d2d110 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2550,6 +2550,11 @@
     return WSAGetLastError();
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 int
 socket_recv_queue(struct link_socket *sock, int maxsize)
 {
@@ -2651,6 +2656,10 @@
     return sock->reads.iostate;
 }
=20
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 socket_send_queue(struct link_socket *sock, struct buffer *buf, const stru=
ct link_socket_actual *to)
 {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9ed1d85..c1052fd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2909,6 +2909,11 @@
     return true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /**
  * Determines if a renegotiation should be triggerred based on the various
  * factors that can trigger one
@@ -2987,6 +2992,11 @@

     return false;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * This is the primary routine for processing TLS stuff inside the
  * the main event loop.  When this routine exits
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 5227eb8..a9506ef 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -627,6 +627,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-compare"
 #endif

 #if MBEDTLS_VERSION_NUMBER < 0x04000000
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 686f823..500e09d 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -92,6 +92,11 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 char *
 mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
 {
@@ -202,6 +207,10 @@
     o->ncp_ciphers =3D ncp_ciphers;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 tls_item_in_cipher_list(const char *item, const char *list)
 {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 16f55ba..095f893 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1491,6 +1491,11 @@
     return len;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /* sign arbitrary data */
 static int
 rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *=
rsa, int padding)
@@ -1509,6 +1514,10 @@
     return (ret =3D=3D len) ? ret : -1;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 tls_ctx_use_external_rsa_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)
 {
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index ad5479c..7495085 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -565,6 +565,11 @@
     gc_free(&gc);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /*
  * Save X509 fields to environment, using the naming convention:
  *
@@ -673,6 +678,10 @@
     return fFound;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 result_t
 x509_verify_cert_eku(mbedtls_x509_crt *cert, const char *const expected_oi=
d)
 {
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 60d5756..58f665c 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -118,6 +118,11 @@
     return nid =3D=3D NID_subject_alt_name || nid =3D=3D NID_issuer_alt_na=
me;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 static bool
 extract_x509_extension(X509 *cert, char *fieldname, char *out, size_t size)
 {
@@ -180,6 +185,10 @@
     return retval;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * Extract a field from an X509 subject name.
  *
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index d09f367..4d42863 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -206,6 +206,11 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 #define STATUS_PRINTF_MAXLEN 512

 void
@@ -253,6 +258,10 @@
     }
 }
=20
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 status_read(struct status_output *so, struct buffer *buf)
 {
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index bfe665e..c2b6268 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -206,6 +206,11 @@
     return false;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 bool
 tls_crypt_unwrap(const struct buffer *src, struct buffer *dst, struct cryp=
to_options *opt)
 {
@@ -796,3 +801,7 @@

     gc_free(&gc);
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index ecebff7..7f96602 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -112,6 +112,11 @@

 static const char *netsh_get_id(const char *dev_node, struct gc_arena *gc);

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 static bool
 do_address_service(const bool add, const short family, const struct tuntap=
 *tt)
 {
@@ -363,6 +368,10 @@
     gc_free(&gc);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static bool
 do_set_mtu_service(const struct tuntap *tt, const short family, const int =
mtu)
 {
@@ -1706,6 +1715,11 @@
 #include <netinet/ip.h>
 #include <sys/uio.h>

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 static inline ssize_t
 header_modify_read_write_return(ssize_t len)
 {
@@ -1719,6 +1733,10 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static ssize_t
 write_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 {
@@ -3255,6 +3273,11 @@

 #elif defined(_WIN32)

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 int
 tun_read_queue(struct tuntap *tt, int maxsize)
 {
@@ -5595,6 +5618,10 @@
     gc_free(&gc);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 tuntap_set_connected(const struct tuntap *tt)
 {
diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c
index 212a4b2..74d19ce 100644
--- a/src/openvpn/wfp_block.c
+++ b/src/openvpn/wfp_block.c
@@ -131,6 +131,11 @@
     return err;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
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
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index 9d38cb7..e60cbac 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -146,6 +146,11 @@
     return true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 const char *
 win_get_tempdir(void)
 {
@@ -167,4 +172,8 @@
     WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof(tmpdir), N=
ULL, NULL);
     return tmpdir;
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
 #endif /* _WIN32 */
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index ac9379d..2bb0e1b 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -98,6 +98,10 @@
     return true;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif

 void
 x_msg_va(const unsigned int flags, const char *format, va_list arglist)
@@ -190,3 +194,7 @@
                       hRecordProg);
     MsiCloseHandle(hRecordProg);
 }
+
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 4fa4889..227431a 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1247,6 +1247,11 @@
     return err;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 /**
  * Check for a valid search list in a certain key of the registry
  *
@@ -3000,6 +3005,10 @@
     return err;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static DWORD
 HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
 {
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pa=
m.c
index c012320..0f3346f 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -184,6 +184,11 @@
     return -1;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 static ssize_t
 send_string(int fd, const char *string)
 {
@@ -199,6 +204,10 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 #ifdef DO_DAEMONIZE

 /*
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/=
openvpn/test_auth_token.c
index e1fcc69..82c20c1 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -166,6 +166,12 @@
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
), AUTH_TOKEN_HMAC_OK);
 }

+/* Note: only on 32bit Windows builds */
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 static void
 auth_token_test_timeout(void **state)
 {
@@ -228,6 +234,10 @@
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session=
), AUTH_TOKEN_HMAC_OK);
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 zerohmac(char *token)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1386?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I880cf01b0db80fc9b40ca4afa30aa51e3fb8ce3b
Gerrit-Change-Number: 1386
Gerrit-PatchSet: 16
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LxOKGoJaRdI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1386?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Enable -Wsign-compare<br><br>As we did before wi=
th -Wconversion, ignore existing<br>issues for now so that we can tackle th=
em one-by-one.<br><br>Change-Id: I880cf01b0db80fc9b40ca4afa30aa51e3fb8ce3b<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: G=
ert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.n=
et/c/openvpn/+/1386<br>Message-Id: &lt;20260304142720.1311-1-gert@...2132...=
.&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...290...=
net/msg35888.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>M CMakeLists.txt<br>M configure.ac<br>M src/openvpn/argv.c<br>M src=
/openvpn/auth_token.c<br>M src/openvpn/buffer.c<br>M src/openvpn/crypto.c<b=
r>M src/openvpn/crypto_epoch.c<br>M src/openvpn/crypto_mbedtls_legacy.c<br>=
M src/openvpn/crypto_openssl.c<br>M src/openvpn/cryptoapi.c<br>M src/openvp=
n/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<br>=
M src/openvpn/dns.c<br>M src/openvpn/error.c<br>M src/openvpn/init.c<br>M s=
rc/openvpn/mudp.c<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M sr=
c/openvpn/options.c<br>M src/openvpn/ps.c<br>M src/openvpn/push.c<br>M src/=
openvpn/route.c<br>M src/openvpn/socket.c<br>M src/openvpn/ssl.c<br>M src/o=
penvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_ncp.c<br>M src/openvpn/ssl_openss=
l.c<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn/ssl_verify_opens=
sl.c<br>M src/openvpn/status.c<br>M src/openvpn/tls_crypt.c<br>M src/openvp=
n/tun.c<br>M src/openvpn/wfp_block.c<br>M src/openvpn/win32-util.c<br>M src=
/openvpnmsica/dllmain.c<br>M src/openvpnserv/interactive.c<br>M src/plugins=
/auth-pam/auth-pam.c<br>M tests/unit_tests/openvpn/test_auth_token.c<br>39 =
files changed, 386 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 566da=
71..198c98f 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -117,7 +117,7 @@</span><br><span>     =
check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)</span><br=
><span>     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefi=
nition)</span><br><span>     add_compile_options(-Wconversion -Wno-sign-con=
version)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    add_compi=
le_options(-Wextra -Wno-sign-compare -Wno-unused-parameter)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    add_compile_options(-Wextra -Wn=
o-unused-parameter)</span><br><span>     # clang doesn&#39;t have the diffe=
rent levels but also doesn&#39;t include it in -Wextra</span><br><span>    =
 check_and_add_compiler_flag(-Wimplicit-fallthrough=3D2 GCCImplicitFallthro=
ugh)</span><br><span>     if (WIN32)</span><br><span>diff --git a/configure=
.ac b/configure.ac</span><br><span>index e151816..ecef2b9 100644</span><br>=
<span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span=
>@@ -1261,7 +1261,7 @@</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-=
style-definition])</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversi=
on -Wno-sign-conversion])</span><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wa=
ll])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ACL_CHECK_ADD_COM=
PILE_FLAGS([-Wextra -Wno-sign-compare -Wno-unused-parameter])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ACL_CHECK_ADD_COMPILE_FLAGS([-Wex=
tra -Wno-unused-parameter])</span><br><span> # clang doesn&#39;t have the d=
ifferent levels but also doesn&#39;t include it in -Wextra</span><br><span>=
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wimplicit-fallthrough=3D2])</span><br><span>=
 if test &quot;${WIN32}&quot; =3D &quot;yes&quot;; then</span><br><span>dif=
f --git a/src/openvpn/argv.c b/src/openvpn/argv.c</span><br><span>index 8e3=
7115..b5d9603 100644</span><br><span>--- a/src/openvpn/argv.c</span><br><sp=
an>+++ b/src/openvpn/argv.c</span><br><span>@@ -263,6 +263,11 @@</span><br>=
<span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defi=
ned(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *  Prep=
ares argv format string for further processing</span><br><span>  *</span><b=
r><span>@@ -418,6 +423,10 @@</span><br><span>     return res;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *  printf() v=
ariant which populates a struct argv.  It processes the</span><br><span>  *=
  format string with the provided arguments.  For each space separator foun=
d</span><br><span>diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_=
token.c</span><br><span>index a694e81..eb2b4d5 100644</span><br><span>--- a=
/src/openvpn/auth_token.c</span><br><span>+++ b/src/openvpn/auth_token.c</s=
pan><br><span>@@ -287,6 +287,11 @@</span><br><span>     return memcmp_const=
ant_time(&amp;hmac_output, hmac, 32) =3D=3D 0;</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> unsigned in=
t</span><br><span> verify_auth_token(struct user_pass *up, struct tls_multi=
 *multi, struct tls_session *session)</span><br><span> {</span><br><span>@@=
 -391,6 +396,10 @@</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> void</span><br><span> wipe_auth_token(struct =
tls_multi *multi)</span><br><span> {</span><br><span>diff --git a/src/openv=
pn/buffer.c b/src/openvpn/buffer.c</span><br><span>index 745b1c8..75110ed 1=
00644</span><br><span>--- a/src/openvpn/buffer.c</span><br><span>+++ b/src/=
openvpn/buffer.c</span><br><span>@@ -280,6 +280,11 @@</span><br><span>     =
return ret;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> /*</span><br><span>  * write a string to the e=
nd of a buffer that was</span><br><span>  * truncated by buf_printf</span><=
br><span>@@ -1308,6 +1313,10 @@</span><br><span>     }</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> void</span><br><span> buffer_list_aggregat=
e(struct buffer_list *bl, const size_t max)</span><br><span> {</span><br><s=
pan>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><spa=
n>index 7d32ee8..748b5b5 100644</span><br><span>--- a/src/openvpn/crypto.c<=
/span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -39,6 +39,11 =
@@</span><br><span> </span><br><span> #include &quot;memdbg.h&quot;</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span>=
<br><span>  * Encryption and Compression Routines.</span><br><span>  *</spa=
n><br><span>@@ -1275,6 +1280,10 @@</span><br><span>     gc_free(&amp;gc);</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const char *</span><br>=
<span> print_key_filename(const char *str, bool is_inline)</span><br><span>=
 {</span><br><span>diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/cr=
ypto_epoch.c</span><br><span>index 3a716f4..f04ba4b4 100644</span><br><span=
>--- a/src/openvpn/crypto_epoch.c</span><br><span>+++ b/src/openvpn/crypto_=
epoch.c</span><br><span>@@ -72,6 +72,11 @@</span><br><span>     hmac_ctx_fr=
ee(hmac_ctx);</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> bool</span><br><span> ovpn_expand_label(cons=
t uint8_t *secret, size_t secret_len, const uint8_t *label, size_t label_le=
n,</span><br><span>                   const uint8_t *context, size_t contex=
t_len, uint8_t *out, int out_len)</span><br><span>@@ -114,6 +119,10 @@</spa=
n><br><span>     return true;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> /**</span><br><span>  * Iterates the epoch key to make it E_n+1, ie=
 increase the epoch by one</span><br><span>  * and derive the new key mater=
ial accordingly</span><br><span>diff --git a/src/openvpn/crypto_mbedtls_leg=
acy.c b/src/openvpn/crypto_mbedtls_legacy.c</span><br><span>index 237564c..=
b234632 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls_legacy.c</s=
pan><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy.c</span><br><span>@@ =
-236,6 +236,7 @@</span><br><span> #if defined(__GNUC__) || defined(__clang_=
_)</span><br><span> #pragma GCC diagnostic push</span><br><span> #pragma GC=
C diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compa=
re&quot;</span><br><span> #endif</span><br><span> </span><br><span> bool</s=
pan><br><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypt=
o_openssl.c</span><br><span>index a8507c2..de3878d 100644</span><br><span>-=
-- a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_=
openssl.c</span><br><span>@@ -1190,6 +1190,11 @@</span><br><span>     HMAC_=
CTX_free(ctx);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> void</span><br><span> hmac_ctx_init(HMAC_=
CTX *ctx, const uint8_t *key, const char *mdname)</span><br><span> {</span>=
<br><span>@@ -1207,6 +1212,10 @@</span><br><span>     ASSERT(HMAC_size(ctx)=
 &lt;=3D key_len);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC dia=
gnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> voi=
d</span><br><span> hmac_ctx_cleanup(HMAC_CTX *ctx)</span><br><span> {</span=
><br><span>diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c</=
span><br><span>index 49f5bbb..b74320d 100644</span><br><span>--- a/src/open=
vpn/cryptoapi.c</span><br><span>+++ b/src/openvpn/cryptoapi.c</span><br><sp=
an>@@ -61,7 +61,7 @@</span><br><span>     return 0;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /=
* HAVE_XKEY_PROVIDER */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#else /* HAVE_XKEY_PROVIDER */</span><br><span> </span><br><span> stati=
c XKEY_EXTERNAL_SIGN_fn xkey_cng_sign;</span><br><span> </span><br><span>@@=
 -145,6 +145,11 @@</span><br><span>     free(cd);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</spa=
n><br><span>  * Parse a hex string with optional embedded spaces into</span=
><br><span>  * a byte array.</span><br><span>@@ -177,6 +182,10 @@</span><br=
><span>     return i;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
static void *</span><br><span> decode_object(struct gc_arena *gc, LPCSTR st=
ruct_type, const CRYPT_OBJID_BLOB *val, DWORD flags,</span><br><span>      =
         DWORD *cb)</span><br><span>diff --git a/src/openvpn/dco_freebsd.c =
b/src/openvpn/dco_freebsd.c</span><br><span>index 718cd8b..a1e373d 100644</=
span><br><span>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b/src/op=
envpn/dco_freebsd.c</span><br><span>@@ -559,6 +559,11 @@</span><br><span>  =
   return ret;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static void</span><br><span> dco_update_p=
eer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nvl)</sp=
an><br><span> {</span><br><span>@@ -577,6 +582,10 @@</span><br><span>      =
   __func__, peerid, mi-&gt;context.c2.dco_read_bytes, mi-&gt;context.c2.dc=
o_write_bytes);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</=
span><br><span> dco_read_and_process(dco_context_t *dco)</span><br><span> {=
</span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_lin=
ux.c</span><br><span>index 3ad8b90..b92fa43 100644</span><br><span>--- a/sr=
c/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><=
br><span>@@ -858,6 +858,11 @@</span><br><span>     }</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-comp=
are&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> stati=
c int</span><br><span> ovpn_handle_peer(dco_context_t *dco, struct nlattr *=
attrs[])</span><br><span> {</span><br><span>@@ -913,6 +918,10 @@</span><br>=
<span>     return NL_OK;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> static bool</span><br><span> ovpn_iface_check(dco_context_t *dco, struct=
 nlattr *attrs[])</span><br><span> {</span><br><span>diff --git a/src/openv=
pn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>index 695bf41..f46c24d=
 100644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/s=
rc/openvpn/dco_win.c</span><br><span>@@ -739,6 +739,11 @@</span><br><span> =
    return 0;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> int</span><br><span> dco_get_peer_stats_mult=
i(dco_context_t *dco, const bool raise_sigusr1_on_err)</span><br><span> {</=
span><br><span>@@ -866,6 +871,10 @@</span><br><span>     return ret;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> dco_get=
_peer_stats_fallback(struct context *c, const bool raise_sigusr1_on_err)</s=
pan><br><span> {</span><br><span>diff --git a/src/openvpn/dns.c b/src/openv=
pn/dns.c</span><br><span>index 3a294ec..4a4bb0c 100644</span><br><span>--- =
a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span=
>@@ -475,7 +475,12 @@</span><br><span>     send_msg_iservice(o-&gt;msg_chan=
nel, &amp;nrpt, sizeof(nrpt), &amp;ack, &quot;DNS&quot;);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
lse  /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#else /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span> </span><br><span> static void</span><br><span> setenv_dns_option(s=
truct env_set *es, const char *format, int i, int j, const char *value)</sp=
an><br><span>@@ -560,6 +565,10 @@</span><br><span>     gc_free(&amp;gc);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><=
span> updown_env_set(bool up, const struct dns_options *o, const struct tun=
tap *tt, struct env_set *es)</span><br><span> {</span><br><span>diff --git =
a/src/openvpn/error.c b/src/openvpn/error.c</span><br><span>index bc8cc98..=
6fb4f32 100644</span><br><span>--- a/src/openvpn/error.c</span><br><span>++=
+ b/src/openvpn/error.c</span><br><span>@@ -97,6 +97,11 @@</span><br><span>=
     forked =3D true;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> bool</span><br><span> set_debug_leve=
l(const int level, const unsigned int flags)</span><br><span> {</span><br><=
span>@@ -113,6 +118,10 @@</span><br><span>     return false;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> bool</span><br><span> set_mute_cutof=
f(const int cutoff)</span><br><span> {</span><br><span>@@ -612,6 +621,11 @@=
</span><br><span>     x_cs_verbose_level =3D verbose_level;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsi=
gn-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> /*</span><br><span>  * Called after most socket or tun/tap operations, vi=
a the inline</span><br><span>  * function check_status().</span><br><span>@=
@ -680,6 +694,10 @@</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__G=
NUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> /*</span><br><span>  * In multiclient mode, put a clie=
nt-specific prefix</span><br><span>  * before each message.</span><br><span=
>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index=
 1391aa85..34ed4eb 100644</span><br><span>--- a/src/openvpn/init.c</span><b=
r><span>+++ b/src/openvpn/init.c</span><br><span>@@ -325,6 +325,11 @@</span=
><br><span>     return l-&gt;len;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><=
span> management_callback_remote_entry_get(void *arg, unsigned int index, c=
har **remote)</span><br><span> {</span><br><span>@@ -359,6 +364,10 @@</span=
><br><span>     return ret;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> static bool</span><br><span> management_callback_remote_cmd(void *arg=
, const char **p)</span><br><span> {</span><br><span>@@ -457,6 +466,7 @@</s=
pan><br><span> #if defined(__GNUC__) || defined(__clang__)</span><br><span>=
 #pragma GCC diagnostic push</span><br><span> #pragma GCC diagnostic ignore=
d &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br>=
<span> #endif</span><br><span> </span><br><span> /*</span><br><span>diff --=
git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 8b2332e=
..b359750 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+=
++ b/src/openvpn/mudp.c</span><br><span>@@ -180,6 +180,11 @@</span><br><spa=
n>     return false;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Get a client =
instance based on real address.  If</span><br><span>  * the instance doesn&=
#39;t exist, create it while</span><br><span>@@ -310,6 +315,10 @@</span><br=
><span>     return mi;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC=
 diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /*</span><br><span>  * Send a packet to UDP socket.</span><br><span>  */</=
span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span=
><br><span>index d983793..1625fd0 100644</span><br><span>--- a/src/openvpn/=
multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -704,6=
 +704,11 @@</span><br><span>     }</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
Create a client instance object for a newly connected client.</span><br><sp=
an>  */</span><br><span>@@ -794,6 +799,10 @@</span><br><span>     return NU=
LL;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span=
>  * Dump tables -- triggered by SIGUSR2.</span><br><span>  * If status fil=
e is defined, write to file.</span><br><span>@@ -4119,6 +4128,11 @@</span><=
br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span>=
<br><span> multi_assign_peer_id(struct multi_context *m, struct multi_insta=
nce *mi)</span><br><span> {</span><br><span>@@ -4140,6 +4154,10 @@</span><b=
r><span>     ASSERT(mi-&gt;context.c2.tls_multi-&gt;peer_id &lt; m-&gt;max_=
clients);</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
op</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><b=
r><span>  * @brief Determines the earliest wakeup interval based on periodi=
c operations.</span><br><span>  *</span><br><span>diff --git a/src/openvpn/=
multi.h b/src/openvpn/multi.h</span><br><span>index 11f68b0..c686e47 100644=
</span><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvp=
n/multi.h</span><br><span>@@ -380,6 +380,11 @@</span><br><span> </span><br>=
<span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored =
&quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /*</span><br><span>  * Return true if our output queue is not f=
ull</span><br><span>  */</span><br><span>@@ -396,6 +401,10 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
op</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br=
><span>  * Determine which instance has pending output</span><br><span>  * =
and prepare the output for sending in</span><br><span>diff --git a/src/open=
vpn/options.c b/src/openvpn/options.c</span><br><span>index fdbc678..8daec4=
2 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/=
src/openvpn/options.c</span><br><span>@@ -4673,6 +4673,11 @@</span><br><spa=
n>     return BSTR(&amp;out);</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> char *</span><br><span> opti=
ons_string_extract_option(const char *options_string, const char *opt_name,=
 struct gc_arena *gc)</span><br><span> {</span><br><span>@@ -4702,6 +4707,1=
0 @@</span><br><span>     return ret;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> /*</span><br><span>  * parse/print topology coding</span><b=
r><span>  */</span><br><span>@@ -5541,6 +5550,11 @@</span><br><span>     re=
turn ret;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
ush</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> void</span><br><span> add_option(struct options =
*options, char *p[], bool is_inline, const char *file, int line,</span><br>=
<span>            const int level, const msglvl_t msglevel, const unsigned =
int permission_mask,</span><br><span>@@ -9258,6 +9272,10 @@</span><br><span=
>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> bool</span><br><span> has_udp_in_local_list(const struct options *options=
)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ps.c b/src/op=
envpn/ps.c</span><br><span>index 3b8fd84..c589248 100644</span><br><span>--=
- a/src/openvpn/ps.c</span><br><span>+++ b/src/openvpn/ps.c</span><br><span=
>@@ -327,6 +327,11 @@</span><br><span>     }</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br>=
<span>  * Record IP/port of client in filesystem, so that server receiving<=
/span><br><span>  * the proxy can determine true client origin.</span><br><=
span>@@ -368,6 +373,10 @@</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> /*</span><br><span>  * Cleanup function, on prox=
y process exit.</span><br><span>  */</span><br><span>diff --git a/src/openv=
pn/push.c b/src/openvpn/push.c</span><br><span>index 5ee43a8..8541467 10064=
4</span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvp=
n/push.c</span><br><span>@@ -800,6 +800,11 @@</span><br><span>     gc_free(=
&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
ush</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> bool</span><br><span> send_push_reply(struct con=
text *c, struct push_list *per_client_push_list)</span><br><span> {</span><=
br><span>@@ -939,6 +944,10 @@</span><br><span>     return true;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> push_reset(=
struct options *o)</span><br><span> {</span><br><span>diff --git a/src/open=
vpn/route.c b/src/openvpn/route.c</span><br><span>index 9a0dcc4..329f3b0 10=
0644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/op=
envpn/route.c</span><br><span>@@ -570,6 +570,11 @@</span><br><span>     }</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic igno=
red &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> static void</span><br><span> add_block_local_routes(struct =
route_list *rl)</span><br><span> {</span><br><span>@@ -602,6 +607,10 @@</sp=
an><br><span>            &amp;&amp; (rl-&gt;spec.flags &amp; RTSA_REMOTE_EN=
DPOINT) &amp;&amp; rl-&gt;spec.remote_host_local !=3D TLA_LOCAL;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> init_route=
_list(struct route_list *rl, const struct route_option_list *opt,</span><br=
><span>                 const char *remote_endpoint, int default_metric, in=
_addr_t remote_host,</span><br><span>@@ -1436,6 +1445,11 @@</span><br><span=
> #define LR_MATCH   1 /* route is local */</span><br><span> #define LR_ERR=
OR   2 /* caller should abort adding route */</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> static int</span><br><span> loc=
al_route(in_addr_t network, in_addr_t netmask, in_addr_t gateway,</span><br=
><span>             const struct route_gateway_info *rgi)</span><br><span>@=
@ -1465,6 +1479,10 @@</span><br><span>     return LR_NOMATCH;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /* Return true if the &quot;on-link=
&quot; form of the route should be used.  This is when the gateway for</spa=
n><br><span>  * a route is specified as an interface rather than an address=
. */</span><br><span> #if defined(TARGET_LINUX) || defined(_WIN32) || defin=
ed(TARGET_DARWIN)</span><br><span>@@ -2869,6 +2887,11 @@</span><br><span>  =
   return ret;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /* Returns RTA_SUCCESS on success, RTA_EE=
XIST if route exists, RTA_ERROR on error */</span><br><span> static int</sp=
an><br><span> do_route_ipv4_service(const bool add, const struct route_ipv4=
 *r, const struct tuntap *tt)</span><br><span>@@ -3018,6 +3041,10 @@</span>=
<br><span>     return status;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> /* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_=
ERROR on error */</span><br><span> static int</span><br><span> add_route_se=
rvice(const struct route_ipv4 *r, const struct tuntap *tt)</span><br><span>=
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>in=
dex 2d5fc50..8d2d110 100644</span><br><span>--- a/src/openvpn/socket.c</spa=
n><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -2550,6 +2550,11 =
@@</span><br><span>     return WSAGetLastError();</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</spa=
n><br><span> socket_recv_queue(struct link_socket *sock, int maxsize)</span=
><br><span> {</span><br><span>@@ -2651,6 +2656,10 @@</span><br><span>     r=
eturn sock-&gt;reads.iostate;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> int</span><br><span> socket_send_queue(struct link_socket *sock, st=
ruct buffer *buf, const struct link_socket_actual *to)</span><br><span> {</=
span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br=
><span>index 9ed1d85..c1052fd 100644</span><br><span>--- a/src/openvpn/ssl.=
c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2909,6 +2909,=
11 @@</span><br><span>     return true;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><spa=
n>  * Determines if a renegotiation should be triggerred based on the vario=
us</span><br><span>  * factors that can trigger one</span><br><span>@@ -298=
7,6 +2992,11 @@</span><br><span> </span><br><span>     return false;</span>=
<br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /*</span><br><span>  * This is the primary routine for processing=
 TLS stuff inside the</span><br><span>  * the main event loop.  When this r=
outine exits</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/o=
penvpn/ssl_mbedtls.c</span><br><span>index 5227eb8..a9506ef 100644</span><b=
r><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/s=
sl_mbedtls.c</span><br><span>@@ -627,6 +627,7 @@</span><br><span> #if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span> #pragma GCC diagnostic =
push</span><br><span> #pragma GCC diagnostic ignored &quot;-Wconversion&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic ignored &quot;-Wsign-compare&quot;</span><br><span> #endif</span><br>=
<span> </span><br><span> #if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><=
br><span>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span><=
br><span>index 686f823..500e09d 100644</span><br><span>--- a/src/openvpn/ss=
l_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -92,=
6 +92,11 @@</span><br><span>     }</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> char *</span><br><span>=
 mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)</span><br><s=
pan> {</span><br><span>@@ -202,6 +207,10 @@</span><br><span>     o-&gt;ncp_=
ciphers =3D ncp_ciphers;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> bool</span><br><span> tls_item_in_cipher_list(const char *item, const ch=
ar *list)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_o=
penssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 16f55ba..095f893=
 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++=
 b/src/openvpn/ssl_openssl.c</span><br><span>@@ -1491,6 +1491,11 @@</span><=
br><span>     return len;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> /* sign arbitrary data */</span>=
<br><span> static int</span><br><span> rsa_priv_enc(int flen, const unsigne=
d char *from, unsigned char *to, RSA *rsa, int padding)</span><br><span>@@ =
-1509,6 +1514,10 @@</span><br><span>     return (ret =3D=3D len) ? ret : -1=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static int</span><br=
><span> tls_ctx_use_external_rsa_key(struct tls_root_ctx *ctx, EVP_PKEY *pk=
ey)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_verify_=
mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>index ad5479c.=
.7495085 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</spa=
n><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -565,=
6 +565,11 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compa=
re&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</sp=
an><br><span>  * Save X509 fields to environment, using the naming conventi=
on:</span><br><span>  *</span><br><span>@@ -673,6 +678,10 @@</span><br><spa=
n>     return fFound;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
result_t</span><br><span> x509_verify_cert_eku(mbedtls_x509_crt *cert, cons=
t char *const expected_oid)</span><br><span> {</span><br><span>diff --git a=
/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c</span>=
<br><span>index 60d5756..58f665c 100644</span><br><span>--- a/src/openvpn/s=
sl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_openssl.c<=
/span><br><span>@@ -118,6 +118,11 @@</span><br><span>     return nid =3D=3D=
 NID_subject_alt_name || nid =3D=3D NID_issuer_alt_name;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-=
compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> s=
tatic bool</span><br><span> extract_x509_extension(X509 *cert, char *fieldn=
ame, char *out, size_t size)</span><br><span> {</span><br><span>@@ -180,6 +=
185,10 @@</span><br><span>     return retval;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /*</span><br><span>  * Extract a field from an X509=
 subject name.</span><br><span>  *</span><br><span>diff --git a/src/openvpn=
/status.c b/src/openvpn/status.c</span><br><span>index d09f367..4d42863 100=
644</span><br><span>--- a/src/openvpn/status.c</span><br><span>+++ b/src/op=
envpn/status.c</span><br><span>@@ -206,6 +206,11 @@</span><br><span>     re=
turn ret;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
ush</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> #define STATUS_PRINTF_MAXLEN 512</span><br><span=
> </span><br><span> void</span><br><span>@@ -253,6 +258,10 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
op</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><=
br><span> status_read(struct status_output *so, struct buffer *buf)</span><=
br><span> {</span><br><span>diff --git a/src/openvpn/tls_crypt.c b/src/open=
vpn/tls_crypt.c</span><br><span>index bfe665e..c2b6268 100644</span><br><sp=
an>--- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_cryp=
t.c</span><br><span>@@ -206,6 +206,11 @@</span><br><span>     return false;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ig=
nored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> bool</span><br><span> tls_crypt_unwrap(const struct buffe=
r *src, struct buffer *dst, struct crypto_options *opt)</span><br><span> {<=
/span><br><span>@@ -796,3 +801,7 @@</span><br><span> </span><br><span>     =
gc_free(&amp;gc);</span><br><span> }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvp=
n/tun.c b/src/openvpn/tun.c</span><br><span>index ecebff7..7f96602 100644</=
span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tu=
n.c</span><br><span>@@ -112,6 +112,11 @@</span><br><span> </span><br><span>=
 static const char *netsh_get_id(const char *dev_node, struct gc_arena *gc)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsi=
gn-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> static bool</span><br><span> do_address_service(const bool add, const sho=
rt family, const struct tuntap *tt)</span><br><span> {</span><br><span>@@ -=
363,6 +368,10 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static bool</span><br><span> do_set_mtu_s=
ervice(const struct tuntap *tt, const short family, const int mtu)</span><b=
r><span> {</span><br><span>@@ -1706,6 +1715,11 @@</span><br><span> #include=
 &lt;netinet/ip.h&gt;</span><br><span> #include &lt;sys/uio.h&gt;</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static inli=
ne ssize_t</span><br><span> header_modify_read_write_return(ssize_t len)</s=
pan><br><span> {</span><br><span>@@ -1719,6 +1733,10 @@</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static ssize_t</sp=
an><br><span> write_tun_header(struct tuntap *tt, uint8_t *buf, int len)</s=
pan><br><span> {</span><br><span>@@ -3255,6 +3273,11 @@</span><br><span> </=
span><br><span> #elif defined(_WIN32)</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC dia=
gnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> int</span><br><span> tun_read_queue(str=
uct tuntap *tt, int maxsize)</span><br><span> {</span><br><span>@@ -5595,6 =
+5618,10 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> static void</span><br><span> tuntap_set_connec=
ted(const struct tuntap *tt)</span><br><span> {</span><br><span>diff --git =
a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c</span><br><span>index 2=
12a4b2..74d19ce 100644</span><br><span>--- a/src/openvpn/wfp_block.c</span>=
<br><span>+++ b/src/openvpn/wfp_block.c</span><br><span>@@ -131,6 +131,11 @=
@</span><br><span>     return err;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
Block outgoing local traffic, possibly DNS only, except for</span><br><span=
>  * (i) adapter with the specified index (and loopback, if all is blocked)=
</span><br><span>@@ -340,6 +345,10 @@</span><br><span>     return err;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> DWORD</span><br><span> del=
ete_wfp_block_filters(HANDLE engine_handle)</span><br><span> {</span><br><s=
pan>diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c</span>=
<br><span>index 9d38cb7..e60cbac 100644</span><br><span>--- a/src/openvpn/w=
in32-util.c</span><br><span>+++ b/src/openvpn/win32-util.c</span><br><span>=
@@ -146,6 +146,11 @@</span><br><span>     return true;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-co=
mpare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> con=
st char *</span><br><span> win_get_tempdir(void)</span><br><span> {</span><=
br><span>@@ -167,4 +172,8 @@</span><br><span>     WideCharToMultiByte(CP_UT=
F8, 0, wtmpdir, -1, tmpdir, sizeof(tmpdir), NULL, NULL);</span><br><span>  =
   return tmpdir;</span><br><span> }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span> #endif /* _WIN32 */</s=
pan><br><span>diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dl=
lmain.c</span><br><span>index ac9379d..2bb0e1b 100644</span><br><span>--- a=
/src/openvpnmsica/dllmain.c</span><br><span>+++ b/src/openvpnmsica/dllmain.=
c</span><br><span>@@ -98,6 +98,10 @@</span><br><span>     return true;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored=
 &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span> </span><br><span> void</span><br><span> x_m=
sg_va(const unsigned int flags, const char *format, va_list arglist)</span>=
<br><span>@@ -190,3 +194,7 @@</span><br><span>                       hRecor=
dProg);</span><br><span>     MsiCloseHandle(hRecordProg);</span><br><span> =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpnse=
rv/interactive.c</span><br><span>index 4fa4889..227431a 100644</span><br><s=
pan>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnse=
rv/interactive.c</span><br><span>@@ -1247,6 +1247,11 @@</span><br><span>   =
  return err;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> /**</span><br><span>  * Check for a valid se=
arch list in a certain key of the registry</span><br><span>  *</span><br><s=
pan>@@ -3000,6 +3005,10 @@</span><br><span>     return err;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static DWORD</span><br><span> Handle=
EnableDHCPMessage(const enable_dhcp_message_t *dhcp)</span><br><span> {</sp=
an><br><span>diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/aut=
h-pam/auth-pam.c</span><br><span>index c012320..0f3346f 100644</span><br><s=
pan>--- a/src/plugins/auth-pam/auth-pam.c</span><br><span>+++ b/src/plugins=
/auth-pam/auth-pam.c</span><br><span>@@ -184,6 +184,11 @@</span><br><span> =
    return -1;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static ssize_t</span><br><span> send_stri=
ng(int fd, const char *string)</span><br><span> {</span><br><span>@@ -199,6=
 +204,10 @@</span><br><span>     }</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> #ifdef DO_DAEMONIZE</span><br><span> </span><br><span> /*</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests=
/unit_tests/openvpn/test_auth_token.c</span><br><span>index e1fcc69..82c20c=
1 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_auth_token.c</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_auth_token.c</span><br><=
span>@@ -166,6 +166,12 @@</span><br><span>     assert_int_equal(verify_auth=
_token(&amp;ctx-&gt;up, &amp;ctx-&gt;multi, ctx-&gt;session), AUTH_TOKEN_HM=
AC_OK);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Note: only on 32bit Windows builds */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defi=
ned(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> =
auth_token_test_timeout(void **state)</span><br><span> {</span><br><span>@@=
 -228,6 +234,10 @@</span><br><span>     assert_int_equal(verify_auth_token(=
&amp;ctx-&gt;up, &amp;ctx-&gt;multi, ctx-&gt;session), AUTH_TOKEN_HMAC_OK);=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br=
><span> zerohmac(char *token)</span><br><span> {</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
386?usp=3Demail">change 1386</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1386=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I880cf01b0db80fc9b40ca4afa30=
aa51e3fb8ce3b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1386 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--LxOKGoJaRdI=--

