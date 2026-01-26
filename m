From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 Jan 2026 22:18:14 +0000
References: <gerrit.1763654024000.I880cf01b0db80fc9b40ca4afa30aa51e3fb8ce3b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f3284c78fbc84d3fed03c46fa85d7f9d3bf56589-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9GXOAsPrKmU="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Enable -Wsign-compare
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

--9GXOAsPrKmU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1386?usp=3Demail

to review the following change.


Change subject: Enable -Wsign-compare
......................................................................

Enable -Wsign-compare

As we did before with -Wconversion, ignore existing
issues for now so that we can tackle them one-by-one.

Change-Id: I880cf01b0db80fc9b40ca4afa30aa51e3fb8ce3b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
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
M src/openvpn/ntlm.c
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
39 files changed, 377 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/1386/10

diff --git a/CMakeLists.txt b/CMakeLists.txt
index e25ecae..a232a7c 100644
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
index 841b0d1..997dd22 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1269,7 +1269,7 @@
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
index d078d79..3ae8d92 100644
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
@@ -1299,6 +1304,10 @@
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
index e3d1fa5..49f2b91 100644
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
index 7a2f6ff..f9b7ae6 100644
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
index 2e49197..9576cb2 100644
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
index d1ad092..62954de 100644
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
index 996622a..fd388ce 100644
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
index 70c0b5d..df704c3 100644
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
index 2af49d2..231507e 100644
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
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 8e913dc..615cbad 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -77,6 +77,7 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-compare"
 #endif

 static void
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9708062..334ea64 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4696,6 +4696,11 @@
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
@@ -4725,6 +4730,10 @@
     return ret;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /*
  * parse/print topology coding
  */
@@ -5564,6 +5573,11 @@
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
@@ -9288,6 +9302,10 @@
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
index e4c5794..e98502d 100644
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
index e328d9b..d13b24a 100644
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
index 58ccda9..698e724 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2523,6 +2523,11 @@
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
@@ -2624,6 +2629,10 @@
     return sock->reads.iostate;
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 socket_send_queue(struct link_socket *sock, struct buffer *buf, const stru=
ct link_socket_actual *to)
 {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 69d0e4e..aac31c2 100644
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
index 3e1698f..bb29a14 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -588,6 +588,7 @@
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
index 09f23964..c61e4b2 100644
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

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 status_read(struct status_output *so, struct buffer *buf)
 {
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 730c20d..44aaad9 100644
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
index 3c20e97..ad77117 100644
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
=20
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1386?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I880cf01b0db80fc9b40ca4afa30aa51e3fb8ce3b
Gerrit-Change-Number: 1386
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--9GXOAsPrKmU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1386?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Enable -Wsign-compare<br><br>As we did befo=
re with -Wconversion, ignore existing<br>issues for now so that we can tack=
le them one-by-one.<br><br>Change-Id: I880cf01b0db80fc9b40ca4afa30aa51e3fb8=
ce3b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br=
>M CMakeLists.txt<br>M configure.ac<br>M src/openvpn/argv.c<br>M src/openvp=
n/auth_token.c<br>M src/openvpn/buffer.c<br>M src/openvpn/crypto.c<br>M src=
/openvpn/crypto_epoch.c<br>M src/openvpn/crypto_mbedtls_legacy.c<br>M src/o=
penvpn/crypto_openssl.c<br>M src/openvpn/cryptoapi.c<br>M src/openvpn/dco_f=
reebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<br>M src/o=
penvpn/dns.c<br>M src/openvpn/error.c<br>M src/openvpn/init.c<br>M src/open=
vpn/mudp.c<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openv=
pn/ntlm.c<br>M src/openvpn/options.c<br>M src/openvpn/ps.c<br>M src/openvpn=
/push.c<br>M src/openvpn/route.c<br>M src/openvpn/socket.c<br>M src/openvpn=
/ssl.c<br>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_ncp.c<br>M src/o=
penvpn/ssl_openssl.c<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn=
/ssl_verify_openssl.c<br>M src/openvpn/status.c<br>M src/openvpn/tls_crypt.=
c<br>M src/openvpn/tun.c<br>M src/openvpn/wfp_block.c<br>M src/openvpn/win3=
2-util.c<br>M src/openvpnmsica/dllmain.c<br>M src/openvpnserv/interactive.c=
<br>M src/plugins/auth-pam/auth-pam.c<br>39 files changed, 377 insertions(+=
), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/86/1386/10</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.t=
xt b/CMakeLists.txt</span><br><span>index e25ecae..a232a7c 100644</span><br=
><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br>=
<span>@@ -117,7 +117,7 @@</span><br><span>     check_and_add_compiler_flag(=
-Wstrict-prototypes StrictPrototypes)</span><br><span>     check_and_add_co=
mpiler_flag(-Wold-style-definition OldStyleDefinition)</span><br><span>    =
 add_compile_options(-Wconversion -Wno-sign-conversion)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    add_compile_options(-Wextra -Wno-sign=
-compare -Wno-unused-parameter)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    add_compile_options(-Wextra -Wno-unused-parameter)</span><b=
r><span>     # clang doesn&#39;t have the different levels but also doesn&#=
39;t include it in -Wextra</span><br><span>     check_and_add_compiler_flag=
(-Wimplicit-fallthrough=3D2 GCCImplicitFallthrough)</span><br><span>     if=
 (WIN32)</span><br><span>diff --git a/configure.ac b/configure.ac</span><br=
><span>index 841b0d1..997dd22 100644</span><br><span>--- a/configure.ac</sp=
an><br><span>+++ b/configure.ac</span><br><span>@@ -1269,7 +1269,7 @@</span=
><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])</span><br=
><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sign-conversion])</s=
pan><br><span> ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-s=
ign-compare -Wno-unused-parameter])</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-unused-parameter]=
)</span><br><span> # clang doesn&#39;t have the different levels but also d=
oesn&#39;t include it in -Wextra</span><br><span> ACL_CHECK_ADD_COMPILE_FLA=
GS([-Wimplicit-fallthrough=3D2])</span><br><span> if test &quot;${WIN32}&qu=
ot; =3D &quot;yes&quot;; then</span><br><span>diff --git a/src/openvpn/argv=
.c b/src/openvpn/argv.c</span><br><span>index 8e37115..b5d9603 100644</span=
><br><span>--- a/src/openvpn/argv.c</span><br><span>+++ b/src/openvpn/argv.=
c</span><br><span>@@ -263,6 +263,11 @@</span><br><span>     gc_free(&amp;gc=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic =
ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> /**</span><br><span>  *  Prepares argv format string fo=
r further processing</span><br><span>  *</span><br><span>@@ -418,6 +423,10 =
@@</span><br><span>     return res;</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> /**</span><br><span>  *  printf() variant which populates a s=
truct argv.  It processes the</span><br><span>  *  format string with the p=
rovided arguments.  For each space separator found</span><br><span>diff --g=
it a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c</span><br><span>in=
dex a694e81..eb2b4d5 100644</span><br><span>--- a/src/openvpn/auth_token.c<=
/span><br><span>+++ b/src/openvpn/auth_token.c</span><br><span>@@ -287,6 +2=
87,11 @@</span><br><span>     return memcmp_constant_time(&amp;hmac_output,=
 hmac, 32) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> unsigned int</span><br><span> verify=
_auth_token(struct user_pass *up, struct tls_multi *multi, struct tls_sessi=
on *session)</span><br><span> {</span><br><span>@@ -391,6 +396,10 @@</span>=
<br><span>     return ret;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> void</span><br><span> wipe_auth_token(struct tls_multi *multi)</span><=
br><span> {</span><br><span>diff --git a/src/openvpn/buffer.c b/src/openvpn=
/buffer.c</span><br><span>index d078d79..3ae8d92 100644</span><br><span>---=
 a/src/openvpn/buffer.c</span><br><span>+++ b/src/openvpn/buffer.c</span><b=
r><span>@@ -280,6 +280,11 @@</span><br><span>     return ret;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-W=
sign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> /*</span><br><span>  * write a string to the end of a buffer that was</=
span><br><span>  * truncated by buf_printf</span><br><span>@@ -1299,6 +1304=
,10 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> void</span><br><span> buffer_list_aggregate(struct buffer_list *bl,=
 const size_t max)</span><br><span> {</span><br><span>diff --git a/src/open=
vpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index e3d1fa5..49f2b91 =
100644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src=
/openvpn/crypto.c</span><br><span>@@ -39,6 +39,11 @@</span><br><span> </spa=
n><br><span> #include &quot;memdbg.h&quot;</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Encryption =
and Compression Routines.</span><br><span>  *</span><br><span>@@ -1275,6 +1=
280,10 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> const char *</span><br><span> print_key_filename=
(const char *str, bool is_inline)</span><br><span> {</span><br><span>diff -=
-git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c</span><br><s=
pan>index 3a716f4..f04ba4b4 100644</span><br><span>--- a/src/openvpn/crypto=
_epoch.c</span><br><span>+++ b/src/openvpn/crypto_epoch.c</span><br><span>@=
@ -72,6 +72,11 @@</span><br><span>     hmac_ctx_free(hmac_ctx);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> bool</span><br><span> ovpn_expand_label(const uint8_t *secret, size_t=
 secret_len, const uint8_t *label, size_t label_len,</span><br><span>      =
             const uint8_t *context, size_t context_len, uint8_t *out, int =
out_len)</span><br><span>@@ -114,6 +119,10 @@</span><br><span>     return t=
rue;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><sp=
an>  * Iterates the epoch key to make it E_n+1, ie increase the epoch by on=
e</span><br><span>  * and derive the new key material accordingly</span><br=
><span>diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypt=
o_mbedtls_legacy.c</span><br><span>index 7a2f6ff..f9b7ae6 100644</span><br>=
<span>--- a/src/openvpn/crypto_mbedtls_legacy.c</span><br><span>+++ b/src/o=
penvpn/crypto_mbedtls_legacy.c</span><br><span>@@ -236,6 +236,7 @@</span><b=
r><span> #if defined(__GNUC__) || defined(__clang__)</span><br><span> #prag=
ma GCC diagnostic push</span><br><span> #pragma GCC diagnostic ignored &quo=
t;-Wconversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span>=
 #endif</span><br><span> </span><br><span> bool</span><br><span>diff --git =
a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c</span><br><sp=
an>index 2e49197..9576cb2 100644</span><br><span>--- a/src/openvpn/crypto_o=
penssl.c</span><br><span>+++ b/src/openvpn/crypto_openssl.c</span><br><span=
>@@ -1190,6 +1190,11 @@</span><br><span>     HMAC_CTX_free(ctx);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot=
;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> void</span><br><span> hmac_ctx_init(HMAC_CTX *ctx, const uint8_t *ke=
y, const char *mdname)</span><br><span> {</span><br><span>@@ -1207,6 +1212,=
10 @@</span><br><span>     ASSERT(HMAC_size(ctx) &lt;=3D key_len);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> hmac_ct=
x_cleanup(HMAC_CTX *ctx)</span><br><span> {</span><br><span>diff --git a/sr=
c/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c</span><br><span>index 49f5b=
bb..b74320d 100644</span><br><span>--- a/src/openvpn/cryptoapi.c</span><br>=
<span>+++ b/src/openvpn/cryptoapi.c</span><br><span>@@ -61,7 +61,7 @@</span=
><br><span>     return 0;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#else  /* HAVE_XKEY_PROVIDER */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* HAVE_XKEY_PRO=
VIDER */</span><br><span> </span><br><span> static XKEY_EXTERNAL_SIGN_fn xk=
ey_cng_sign;</span><br><span> </span><br><span>@@ -145,6 +145,11 @@</span><=
br><span>     free(cd);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Parse a he=
x string with optional embedded spaces into</span><br><span>  * a byte arra=
y.</span><br><span>@@ -177,6 +182,10 @@</span><br><span>     return i;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> static void *</span><br><s=
pan> decode_object(struct gc_arena *gc, LPCSTR struct_type, const CRYPT_OBJ=
ID_BLOB *val, DWORD flags,</span><br><span>               DWORD *cb)</span>=
<br><span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.=
c</span><br><span>index d1ad092..62954de 100644</span><br><span>--- a/src/o=
penvpn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span>=
<br><span>@@ -559,6 +559,11 @@</span><br><span>     return ret;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> static void</span><br><span> dco_update_peer_stat(struct multi_contex=
t *m, uint32_t peerid, const nvlist_t *nvl)</span><br><span> {</span><br><s=
pan>@@ -577,6 +582,10 @@</span><br><span>         __func__, peerid, mi-&gt;=
context.c2.dco_read_bytes, mi-&gt;context.c2.dco_write_bytes);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> dco_read_and_=
process(dco_context_t *dco)</span><br><span> {</span><br><span>diff --git a=
/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 3a=
d8b90..b92fa43 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><=
br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -858,6 +858,11 @@=
</span><br><span>     }</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GC=
C diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> static int</span><br><span> ovpn_h=
andle_peer(dco_context_t *dco, struct nlattr *attrs[])</span><br><span> {</=
span><br><span>@@ -913,6 +918,10 @@</span><br><span>     return NL_OK;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><spa=
n> ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[])</span><br><=
span> {</span><br><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dc=
o_win.c</span><br><span>index 695bf41..f46c24d 100644</span><br><span>--- a=
/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><b=
r><span>@@ -739,6 +739,11 @@</span><br><span>     return 0;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsi=
gn-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> int</span><br><span> dco_get_peer_stats_multi(dco_context_t *dco, const b=
ool raise_sigusr1_on_err)</span><br><span> {</span><br><span>@@ -866,6 +871=
,10 @@</span><br><span>     return ret;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> int</span><br><span> dco_get_peer_stats_fallback(struct c=
ontext *c, const bool raise_sigusr1_on_err)</span><br><span> {</span><br><s=
pan>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>inde=
x 996622a..fd388ce 100644</span><br><span>--- a/src/openvpn/dns.c</span><br=
><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -475,7 +475,12 @@</span><=
br><span>     send_msg_iservice(o-&gt;msg_channel, &amp;nrpt, sizeof(nrpt),=
 &amp;ack, &quot;DNS&quot;);</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* ifdef _WIN32 */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* ifdef _WIN32 */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC dia=
gnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> st=
atic void</span><br><span> setenv_dns_option(struct env_set *es, const char=
 *format, int i, int j, const char *value)</span><br><span>@@ -560,6 +565,1=
0 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> static void</span><br><span> updown_env_set(bool up, =
const struct dns_options *o, const struct tuntap *tt, struct env_set *es)</=
span><br><span> {</span><br><span>diff --git a/src/openvpn/error.c b/src/op=
envpn/error.c</span><br><span>index bc8cc98..6fb4f32 100644</span><br><span=
>--- a/src/openvpn/error.c</span><br><span>+++ b/src/openvpn/error.c</span>=
<br><span>@@ -97,6 +97,11 @@</span><br><span>     forked =3D true;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> bool</span><br><span> set_debug_level(const int level, const unsi=
gned int flags)</span><br><span> {</span><br><span>@@ -113,6 +118,10 @@</sp=
an><br><span>     return false;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> bool</span><br><span> set_mute_cutoff(const int cutoff)</span><br=
><span> {</span><br><span>@@ -612,6 +621,11 @@</span><br><span>     x_cs_ve=
rbose_level =3D verbose_level;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Call=
ed after most socket or tun/tap operations, via the inline</span><br><span>=
  * function check_status().</span><br><span>@@ -680,6 +694,10 @@</span><br=
><span>     }</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span=
><br><span>  * In multiclient mode, put a client-specific prefix</span><br>=
<span>  * before each message.</span><br><span>diff --git a/src/openvpn/ini=
t.c b/src/openvpn/init.c</span><br><span>index 70c0b5d..df704c3 100644</spa=
n><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init=
.c</span><br><span>@@ -325,6 +325,11 @@</span><br><span>     return l-&gt;l=
en;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> static bool</span><br><span> management_callback_remot=
e_entry_get(void *arg, unsigned int index, char **remote)</span><br><span> =
{</span><br><span>@@ -359,6 +364,10 @@</span><br><span>     return ret;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><=
span> management_callback_remote_cmd(void *arg, const char **p)</span><br><=
span> {</span><br><span>@@ -457,6 +466,7 @@</span><br><span> #if defined(__=
GNUC__) || defined(__clang__)</span><br><span> #pragma GCC diagnostic push<=
/span><br><span> #pragma GCC diagnostic ignored &quot;-Wconversion&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 ignored &quot;-Wsign-compare&quot;</span><br><span> #endif</span><br><span=
> </span><br><span> /*</span><br><span>diff --git a/src/openvpn/mudp.c b/sr=
c/openvpn/mudp.c</span><br><span>index 8b2332e..b359750 100644</span><br><s=
pan>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span=
><br><span>@@ -180,6 +180,11 @@</span><br><span>     return false;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /*</span><br><span>  * Get a client instance based on real addres=
s.  If</span><br><span>  * the instance doesn&#39;t exist, create it while<=
/span><br><span>@@ -310,6 +315,10 @@</span><br><span>     return mi;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Send =
a packet to UDP socket.</span><br><span>  */</span><br><span>diff --git a/s=
rc/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 2af49d2..231=
507e 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b=
/src/openvpn/multi.c</span><br><span>@@ -704,6 +704,11 @@</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /*</span><br><span>  * Create a client instance obje=
ct for a newly connected client.</span><br><span>  */</span><br><span>@@ -7=
94,6 +799,10 @@</span><br><span>     return NULL;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /*</span><br><span>  * Dump tables -- triggered=
 by SIGUSR2.</span><br><span>  * If status file is defined, write to file.<=
/span><br><span>@@ -4119,6 +4128,11 @@</span><br><span> #endif /* ifdef ENA=
BLE_MANAGEMENT */</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang=
__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> void</span><br><span> multi_assign_peer_=
id(struct multi_context *m, struct multi_instance *mi)</span><br><span> {</=
span><br><span>@@ -4140,6 +4154,10 @@</span><br><span>     ASSERT(mi-&gt;co=
ntext.c2.tls_multi-&gt;peer_id &lt; m-&gt;max_clients);</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /**</span><br><span>  * @brief Determines=
 the earliest wakeup interval based on periodic operations.</span><br><span=
>  *</span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h=
</span><br><span>index 11f68b0..c686e47 100644</span><br><span>--- a/src/op=
envpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ =
-380,6 +380,11 @@</span><br><span> </span><br><span> #endif</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><spa=
n>  * Return true if our output queue is not full</span><br><span>  */</spa=
n><br><span>@@ -396,6 +401,10 @@</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Determine which in=
stance has pending output</span><br><span>  * and prepare the output for se=
nding in</span><br><span>diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm=
.c</span><br><span>index 8e913dc..615cbad 100644</span><br><span>--- a/src/=
openvpn/ntlm.c</span><br><span>+++ b/src/openvpn/ntlm.c</span><br><span>@@ =
-77,6 +77,7 @@</span><br><span> #if defined(__GNUC__) || defined(__clang__)=
</span><br><span> #pragma GCC diagnostic push</span><br><span> #pragma GCC =
diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare=
&quot;</span><br><span> #endif</span><br><span> </span><br><span> static vo=
id</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options=
.c</span><br><span>index 9708062..334ea64 100644</span><br><span>--- a/src/=
openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><sp=
an>@@ -4696,6 +4696,11 @@</span><br><span>     return BSTR(&amp;out);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored =
&quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> char *</span><br><span> options_string_extract_option(const cha=
r *options_string, const char *opt_name, struct gc_arena *gc)</span><br><sp=
an> {</span><br><span>@@ -4725,6 +4730,10 @@</span><br><span>     return re=
t;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>=
  * parse/print topology coding</span><br><span>  */</span><br><span>@@ -55=
64,6 +5573,11 @@</span><br><span>     return ret;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</sp=
an><br><span> add_option(struct options *options, char *p[], bool is_inline=
, const char *file, int line,</span><br><span>            const int level, =
const msglvl_t msglevel, const unsigned int permission_mask,</span><br><spa=
n>@@ -9288,6 +9302,10 @@</span><br><span>     gc_free(&amp;gc);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> has_udp_in_=
local_list(const struct options *options)</span><br><span> {</span><br><spa=
n>diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c</span><br><span>index e4=
c5794..e98502d 100644</span><br><span>--- a/src/openvpn/ps.c</span><br><spa=
n>+++ b/src/openvpn/ps.c</span><br><span>@@ -327,6 +327,11 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic p=
ush</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diag=
nostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> /*</span><br><span>  * Record IP/port of client =
in filesystem, so that server receiving</span><br><span>  * the proxy can d=
etermine true client origin.</span><br><span>@@ -368,6 +373,10 @@</span><br=
><span>     }</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span=
><br><span>  * Cleanup function, on proxy process exit.</span><br><span>  *=
/</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</spa=
n><br><span>index e328d9b..d13b24a 100644</span><br><span>--- a/src/openvpn=
/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -800,6 =
+800,11 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</sp=
an><br><span> send_push_reply(struct context *c, struct push_list *per_clie=
nt_push_list)</span><br><span> {</span><br><span>@@ -939,6 +944,10 @@</span=
><br><span>     return true;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defi=
ned(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> void</span><br><span> push_reset(struct options *o)</span><br><span>=
 {</span><br><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</=
span><br><span>index 9a0dcc4..329f3b0 100644</span><br><span>--- a/src/open=
vpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -5=
70,6 +570,11 @@</span><br><span>     }</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><=
br><span> add_block_local_routes(struct route_list *rl)</span><br><span> {<=
/span><br><span>@@ -602,6 +607,10 @@</span><br><span>            &amp;&amp;=
 (rl-&gt;spec.flags &amp; RTSA_REMOTE_ENDPOINT) &amp;&amp; rl-&gt;spec.remo=
te_host_local !=3D TLA_LOCAL;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> bool</span><br><span> init_route_list(struct route_list *rl, const =
struct route_option_list *opt,</span><br><span>                 const char =
*remote_endpoint, int default_metric, in_addr_t remote_host,</span><br><spa=
n>@@ -1436,6 +1445,11 @@</span><br><span> #define LR_MATCH   1 /* route is =
local */</span><br><span> #define LR_ERROR   2 /* caller should abort addin=
g route */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &q=
uot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> static int</span><br><span> local_route(in_addr_t network, in_add=
r_t netmask, in_addr_t gateway,</span><br><span>             const struct r=
oute_gateway_info *rgi)</span><br><span>@@ -1465,6 +1479,10 @@</span><br><s=
pan>     return LR_NOMATCH;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> /* Return true if the &quot;on-link&quot; form of the route should be=
 used.  This is when the gateway for</span><br><span>  * a route is specifi=
ed as an interface rather than an address. */</span><br><span> #if defined(=
TARGET_LINUX) || defined(_WIN32) || defined(TARGET_DARWIN)</span><br><span>=
@@ -2869,6 +2887,11 @@</span><br><span>     return ret;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-c=
ompare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*=
 Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on e=
rror */</span><br><span> static int</span><br><span> do_route_ipv4_service(=
const bool add, const struct route_ipv4 *r, const struct tuntap *tt)</span>=
<br><span>@@ -3018,6 +3041,10 @@</span><br><span>     return status;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /* Returns RTA_SUCCESS on su=
ccess, RTA_EEXIST if route exists, RTA_ERROR on error */</span><br><span> s=
tatic int</span><br><span> add_route_service(const struct route_ipv4 *r, co=
nst struct tuntap *tt)</span><br><span>diff --git a/src/openvpn/socket.c b/=
src/openvpn/socket.c</span><br><span>index 58ccda9..698e724 100644</span><b=
r><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket=
.c</span><br><span>@@ -2523,6 +2523,11 @@</span><br><span>     return WSAGe=
tLastError();</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC =
diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> int</span><br><span> socket_recv_queue(struc=
t link_socket *sock, int maxsize)</span><br><span> {</span><br><span>@@ -26=
24,6 +2629,10 @@</span><br><span>     return sock-&gt;reads.iostate;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> socket_=
send_queue(struct link_socket *sock, struct buffer *buf, const struct link_=
socket_actual *to)</span><br><span> {</span><br><span>diff --git a/src/open=
vpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 69d0e4e..aac31c2 100644=
</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/=
ssl.c</span><br><span>@@ -2909,6 +2909,11 @@</span><br><span>     return tr=
ue;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic=
 ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> /**</span><br><span>  * Determines if a renegotiation =
should be triggerred based on the various</span><br><span>  * factors that =
can trigger one</span><br><span>@@ -2987,6 +2992,11 @@</span><br><span> </s=
pan><br><span>     return false;</span><br><span> }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
This is the primary routine for processing TLS stuff inside the</span><br><=
span>  * the main event loop.  When this routine exits</span><br><span>diff=
 --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><s=
pan>index 3e1698f..bb29a14 100644</span><br><span>--- a/src/openvpn/ssl_mbe=
dtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -=
588,6 +588,7 @@</span><br><span> #if defined(__GNUC__) || defined(__clang__=
)</span><br><span> #pragma GCC diagnostic push</span><br><span> #pragma GCC=
 diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compar=
e&quot;</span><br><span> #endif</span><br><span> </span><br><span> #if MBED=
TLS_VERSION_NUMBER &lt; 0x04000000</span><br><span>diff --git a/src/openvpn=
/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span><br><span>index 686f823..500e09d 1=
00644</span><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src=
/openvpn/ssl_ncp.c</span><br><span>@@ -92,6 +92,11 @@</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic i=
gnored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> char *</span><br><span> mutate_ncp_cipher_list(const cha=
r *list, struct gc_arena *gc)</span><br><span> {</span><br><span>@@ -202,6 =
+207,10 @@</span><br><span>     o-&gt;ncp_ciphers =3D ncp_ciphers;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> tls_ite=
m_in_cipher_list(const char *item, const char *list)</span><br><span> {</sp=
an><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_opens=
sl.c</span><br><span>index 09f23964..c61e4b2 100644</span><br><span>--- a/s=
rc/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</s=
pan><br><span>@@ -1491,6 +1491,11 @@</span><br><span>     return len;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored =
&quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /* sign arbitrary data */</span><br><span> static int</span><br=
><span> rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to=
, RSA *rsa, int padding)</span><br><span>@@ -1509,6 +1514,10 @@</span><br><=
span>     return (ret =3D=3D len) ? ret : -1;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> static int</span><br><span> tls_ctx_use_external_rs=
a_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)</span><br><span> {</span><b=
r><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_ver=
ify_mbedtls.c</span><br><span>index ad5479c..7495085 100644</span><br><span=
>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/s=
sl_verify_mbedtls.c</span><br><span>@@ -565,6 +565,11 @@</span><br><span>  =
   gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Save X509 fie=
lds to environment, using the naming convention:</span><br><span>  *</span>=
<br><span>@@ -673,6 +678,10 @@</span><br><span>     return fFound;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> result_t</span><br><span> x50=
9_verify_cert_eku(mbedtls_x509_crt *cert, const char *const expected_oid)</=
span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_verify_opens=
sl.c b/src/openvpn/ssl_verify_openssl.c</span><br><span>index 60d5756..58f6=
65c 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br=
><span>+++ b/src/openvpn/ssl_verify_openssl.c</span><br><span>@@ -118,6 +11=
8,11 @@</span><br><span>     return nid =3D=3D NID_subject_alt_name || nid =
=3D=3D NID_issuer_alt_name;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragm=
a GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> e=
xtract_x509_extension(X509 *cert, char *fieldname, char *out, size_t size)<=
/span><br><span> {</span><br><span>@@ -180,6 +185,10 @@</span><br><span>   =
  return retval;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</s=
pan><br><span>  * Extract a field from an X509 subject name.</span><br><spa=
n>  *</span><br><span>diff --git a/src/openvpn/status.c b/src/openvpn/statu=
s.c</span><br><span>index d09f367..4d42863 100644</span><br><span>--- a/src=
/openvpn/status.c</span><br><span>+++ b/src/openvpn/status.c</span><br><spa=
n>@@ -206,6 +206,11 @@</span><br><span>     return ret;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-c=
ompare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #d=
efine STATUS_PRINTF_MAXLEN 512</span><br><span> </span><br><span> void</spa=
n><br><span>@@ -253,6 +258,10 @@</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> bool</span><br><span> status_read(struct =
status_output *so, struct buffer *buf)</span><br><span> {</span><br><span>d=
iff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br><sp=
an>index 730c20d..44aaad9 100644</span><br><span>--- a/src/openvpn/tls_cryp=
t.c</span><br><span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -206,6=
 +206,11 @@</span><br><span>     return false;</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span>=
<br><span> tls_crypt_unwrap(const struct buffer *src, struct buffer *dst, s=
truct crypto_options *opt)</span><br><span> {</span><br><span>@@ -796,3 +80=
1,7 @@</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><=
span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma=
 GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</=
span><br><span>index 3c20e97..ad77117 100644</span><br><span>--- a/src/open=
vpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -112,6=
 +112,11 @@</span><br><span> </span><br><span> static const char *netsh_get=
_id(const char *dev_node, struct gc_arena *gc);</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defi=
ned(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> =
do_address_service(const bool add, const short family, const struct tuntap =
*tt)</span><br><span> {</span><br><span>@@ -363,6 +368,10 @@</span><br><spa=
n>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> static bool</span><br><span> do_set_mtu_service(const struct tuntap *tt,=
 const short family, const int mtu)</span><br><span> {</span><br><span>@@ -=
1706,6 +1715,11 @@</span><br><span> #include &lt;netinet/ip.h&gt;</span><br=
><span> #include &lt;sys/uio.h&gt;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static inline ssize_t</span><br><span> he=
ader_modify_read_write_return(ssize_t len)</span><br><span> {</span><br><sp=
an>@@ -1719,6 +1733,10 @@</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> static ssize_t</span><br><span> write_tun_header=
(struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><sp=
an>@@ -3255,6 +3273,11 @@</span><br><span> </span><br><span> #elif defined(=
_WIN32)</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;=
-Wsign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> int</span><br><span> tun_read_queue(struct tuntap *tt, int maxsize)</=
span><br><span> {</span><br><span>@@ -5595,6 +5618,10 @@</span><br><span>  =
   gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC d=
iagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> s=
tatic void</span><br><span> tuntap_set_connected(const struct tuntap *tt)</=
span><br><span> {</span><br><span>diff --git a/src/openvpn/wfp_block.c b/sr=
c/openvpn/wfp_block.c</span><br><span>index 212a4b2..74d19ce 100644</span><=
br><span>--- a/src/openvpn/wfp_block.c</span><br><span>+++ b/src/openvpn/wf=
p_block.c</span><br><span>@@ -131,6 +131,11 @@</span><br><span>     return =
err;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnosti=
c ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> /*</span><br><span>  * Block outgoing local traffic, =
possibly DNS only, except for</span><br><span>  * (i) adapter with the spec=
ified index (and loopback, if all is blocked)</span><br><span>@@ -340,6 +34=
5,10 @@</span><br><span>     return err;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> DWORD</span><br><span> delete_wfp_block_filters(HANDLE e=
ngine_handle)</span><br><span> {</span><br><span>diff --git a/src/openvpn/w=
in32-util.c b/src/openvpn/win32-util.c</span><br><span>index 9d38cb7..e60cb=
ac 100644</span><br><span>--- a/src/openvpn/win32-util.c</span><br><span>++=
+ b/src/openvpn/win32-util.c</span><br><span>@@ -146,6 +146,11 @@</span><br=
><span>     return true;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> const char *</span><br><span> win=
_get_tempdir(void)</span><br><span> {</span><br><span>@@ -167,4 +172,8 @@</=
span><br><span>     WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, tmpdir, si=
zeof(tmpdir), NULL, NULL);</span><br><span>     return tmpdir;</span><br><s=
pan> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span> #endif /* _WIN32 */</span><br><span>diff --git a/src=
/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c</span><br><span>index =
ac9379d..2bb0e1b 100644</span><br><span>--- a/src/openvpnmsica/dllmain.c</s=
pan><br><span>+++ b/src/openvpnmsica/dllmain.c</span><br><span>@@ -98,6 +98=
,10 @@</span><br><span>     return true;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
> </span><br><span> void</span><br><span> x_msg_va(const unsigned int flags=
, const char *format, va_list arglist)</span><br><span>@@ -190,3 +194,7 @@<=
/span><br><span>                       hRecordProg);</span><br><span>     M=
siCloseHandle(hRecordProg);</span><br><span> }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git =
a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><=
span>index 4fa4889..227431a 100644</span><br><span>--- a/src/openvpnserv/in=
teractive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><=
span>@@ -1247,6 +1247,11 @@</span><br><span>     return err;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Ws=
ign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> /**</span><br><span>  * Check for a valid search list in a certain key o=
f the registry</span><br><span>  *</span><br><span>@@ -3000,6 +3005,10 @@</=
span><br><span>     return err;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#p=
ragma GCC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> static DWORD</span><br><span> HandleEnableDHCPMessage(const enabl=
e_dhcp_message_t *dhcp)</span><br><span> {</span><br><span>diff --git a/src=
/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c</span><br><s=
pan>index c012320..0f3346f 100644</span><br><span>--- a/src/plugins/auth-pa=
m/auth-pam.c</span><br><span>+++ b/src/plugins/auth-pam/auth-pam.c</span><b=
r><span>@@ -184,6 +184,11 @@</span><br><span>     return -1;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Ws=
ign-compare&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> static ssize_t</span><br><span> send_string(int fd, const char *string)<=
/span><br><span> {</span><br><span>@@ -199,6 +204,10 @@</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef DO_DAEMONIZ=
E</span><br><span> </span><br><span> /*</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1386?usp=
=3Demail">change 1386</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1386?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I880cf01b0db80fc9b40ca4afa30=
aa51e3fb8ce3b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1386 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--9GXOAsPrKmU=--

