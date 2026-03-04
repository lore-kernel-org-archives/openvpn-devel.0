From: Gert Doering <gert@...1296...>
Date: Wed,  4 Mar 2026 15:27:12 +0100
Message-ID: <20260304142720.1311-1-gert@...1296...>
In-Reply-To: <gerrit.1763654024000.I880cf01b0db80fc9b40ca4afa30aa51e3fb8ce3b@...2715...>
References: <gerrit.1763654024000.I880cf01b0db80fc9b40ca4afa30aa51e3fb8ce3b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v15] Enable -Wsign-compare
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

As we did before with -Wconversion, ignore existing
issues for now so that we can tackle them one-by-one.

Change-Id: I880cf01b0db80fc9b40ca4afa30aa51e3fb8ce3b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1386
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1386
This mail reflects revision 15 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
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
     # clang doesn't have the different levels but also doesn't include it in -Wextra
     check_and_add_compiler_flag(-Wimplicit-fallthrough=2 GCCImplicitFallthrough)
     if (WIN32)
diff --git a/configure.ac b/configure.ac
index e151816..ecef2b9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1261,7 +1261,7 @@
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sign-conversion])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-unused-parameter])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-unused-parameter])
 # clang doesn't have the different levels but also doesn't include it in -Wextra
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wimplicit-fallthrough=2])
 if test "${WIN32}" = "yes"; then
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
  *  format string with the provided arguments.  For each space separator found
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index a694e81..eb2b4d5 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -287,6 +287,11 @@
     return memcmp_constant_time(&hmac_output, hmac, 32) == 0;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wsign-compare"
+#endif
+
 unsigned int
 verify_auth_token(struct user_pass *up, struct tls_multi *multi, struct tls_session *session)
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
 ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t *label, size_t label_len,
                   const uint8_t *context, size_t context_len, uint8_t *out, int out_len)
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
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c
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
     ASSERT(HMAC_size(ctx) <= key_len);
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
 decode_object(struct gc_arena *gc, LPCSTR struct_type, const CRYPT_OBJID_BLOB *val, DWORD flags,
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
 dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nvl)
 {
@@ -577,6 +582,10 @@
         __func__, peerid, mi->context.c2.dco_read_bytes, mi->context.c2.dco_write_bytes);
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
 dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_err)
 {
@@ -866,6 +871,10 @@
     return ret;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 int
 dco_get_peer_stats_fallback(struct context *c, const bool raise_sigusr1_on_err)
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
 setenv_dns_option(struct env_set *es, const char *format, int i, int j, const char *value)
@@ -560,6 +565,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 updown_env_set(bool up, const struct dns_options *o, const struct tuntap *tt, struct env_set *es)
 {
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index bc8cc98..6fb4f32 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -97,6 +97,11 @@
     forked = true;
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
     x_cs_verbose_level = verbose_level;
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
 management_callback_remote_entry_get(void *arg, unsigned int index, char **remote)
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
  * @brief Determines the earliest wakeup interval based on periodic operations.
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
 options_string_extract_option(const char *options_string, const char *opt_name, struct gc_arena *gc)
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
 add_option(struct options *options, char *p[], bool is_inline, const char *file, int line,
            const int level, const msglvl_t msglevel, const unsigned int permission_mask,
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
            && (rl->spec.flags & RTSA_REMOTE_ENDPOINT) && rl->spec.remote_host_local != TLA_LOCAL;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 bool
 init_route_list(struct route_list *rl, const struct route_option_list *opt,
                 const char *remote_endpoint, int default_metric, in_addr_t remote_host,
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
 /* Return true if the "on-link" form of the route should be used.  This is when the gateway for
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
 /* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error */
 static int
 do_route_ipv4_service(const bool add, const struct route_ipv4 *r, const struct tuntap *tt)
@@ -3018,6 +3041,10 @@
     return status;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 /* Returns RTA_SUCCESS on success, RTA_EEXIST if route exists, RTA_ERROR on error */
 static int
 add_route_service(const struct route_ipv4 *r, const struct tuntap *tt)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index d92b551..4e85239 100644
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
 socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct link_socket_actual *to)
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
     o->ncp_ciphers = ncp_ciphers;
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
 rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
@@ -1509,6 +1514,10 @@
     return (ret == len) ? ret : -1;
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static int
 tls_ctx_use_external_rsa_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)
 {
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
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
 x509_verify_cert_eku(mbedtls_x509_crt *cert, const char *const expected_oid)
 {
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 60d5756..58f665c 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -118,6 +118,11 @@
     return nid == NID_subject_alt_name || nid == NID_issuer_alt_name;
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
 tls_crypt_unwrap(const struct buffer *src, struct buffer *dst, struct crypto_options *opt)
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
 do_address_service(const bool add, const short family, const struct tuntap *tt)
 {
@@ -363,6 +368,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static bool
 do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
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
     WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof(tmpdir), NULL, NULL);
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
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
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
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index e1fcc69..82c20c1 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -166,6 +166,12 @@
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session), AUTH_TOKEN_HMAC_OK);
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
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session), AUTH_TOKEN_HMAC_OK);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static void
 zerohmac(char *token)
 {

