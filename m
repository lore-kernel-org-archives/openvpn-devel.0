From: Gert Doering <gert@...1296...>
Date: Tue, 27 May 2025 18:03:50 +0200
Message-ID: <20250527160356.10871-1-gert@...1296...>
In-Reply-To: <gerrit.1747937881000.Icbfffae877f8eca8d94721a4d54e140c50d4a550@...2715...>
References: <gerrit.1747937881000.Icbfffae877f8eca8d94721a4d54e140c50d4a550@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Remove HAVE_EXPORT_KEYING_MATERIAL macro
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

From: Max Fillinger <maximilian.fillinger@...2507...>

This was always defined in all supported versions of OpenSSL and
WolfSSL. EKM is available in mbedtls versions from 2.18.0 onwards.

This commit breaks builds on Debian 11 with the stock mbed TLS package.

Change-Id: Icbfffae877f8eca8d94721a4d54e140c50d4a550
Signed-off-by: MaxF <max@...2606...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1043
This mail reflects revision 3 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 5164ce3..5df0ac8 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -120,9 +120,6 @@
 /* Define to 1 if you have the <err.h> header file. */
 #cmakedefine HAVE_ERR_H
 
-/* Crypto library supports keying material exporter */
-#define HAVE_EXPORT_KEYING_MATERIAL 1
-
 /* Define to 1 if you have the <fcntl.h> header file. */
 #cmakedefine HAVE_FCNTL_H
 
diff --git a/configure.ac b/configure.ac
index 75367e8..1b908e6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -988,10 +988,6 @@
 		[AC_MSG_ERROR([OpenSSL check for AES-256-GCM support failed])]
 	)
 
-	# All supported OpenSSL versions (>= 1.1.0)
-	# have this feature
-	have_export_keying_material="yes"
-
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
 
@@ -1064,7 +1060,6 @@
 		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [0], [no])]
 	)
 
-	have_export_keying_material="yes"
 	AC_CHECK_FUNC(
 		[mbedtls_ssl_conf_export_keys_ext_cb],
 		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],
@@ -1077,7 +1072,7 @@
 			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]
 		)
 		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" != xyes; then
-			have_export_keying_material="no"
+			AC_MSG_ERROR(This version of mbed TLS has no support for exporting key material.)
 		fi
 	fi
 
@@ -1132,17 +1127,12 @@
 	)
 	AC_CHECK_HEADER([wolfssl/options.h],,[AC_MSG_ERROR([wolfSSL header wolfssl/options.h not found!])])
 
-	# wolfSSL signal EKM support
-	have_export_keying_material="yes"
-
 	if test "${enable_wolfssl_options_h}" = "yes"; then
 		AC_DEFINE([EXTERNAL_OPTS_OPENVPN], [1], [Include options.h from wolfSSL library])
 	else
 		AC_DEFINE([WOLFSSL_USER_SETTINGS], [1], [Use custom user_settings.h file for wolfSSL library])
 	fi
 
-	have_export_keying_material="yes"
-
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
 
@@ -1346,12 +1336,6 @@
 test "${enable_dns_updown_by_default}" = "yes" && AC_DEFINE([ENABLE_DNS_UPDOWN_BY_DEFAULT], [1], [Enable dns-updown hook by default])
 test "${enable_ntlm}" = "yes" && AC_DEFINE([ENABLE_NTLM], [1], [Enable NTLMv2 proxy support])
 test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
-if test "${have_export_keying_material}" = "yes"; then
-	AC_DEFINE(
-		[HAVE_EXPORT_KEYING_MATERIAL], [1],
-		[Crypto library supports keying material exporter]
-	)
-fi
 OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}"
 OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}"
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e0ba255..15eacab 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3483,7 +3483,6 @@
     to.comp_options = options->comp;
 #endif
 
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
     if (options->keying_material_exporter_label)
     {
         to.ekm_size = options->keying_material_exporter_length;
@@ -3499,7 +3498,6 @@
     {
         to.ekm_size = 0;
     }
-#endif /* HAVE_EXPORT_KEYING_MATERIAL */
 
     /* TLS handshake authentication (--tls-auth) */
     if (options->ce.tls_auth_file)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 80dd0c0..a5eee01 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1837,7 +1837,6 @@
         c->c2.push_request_received = true;
     }
 
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
     if (proto & IV_PROTO_TLS_KEY_EXPORT)
     {
         o->imported_protocol_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
@@ -1856,7 +1855,6 @@
     {
         o->imported_protocol_flags |= CO_USE_DYNAMIC_TLS_CRYPT;
     }
-#endif
 
     if (proto & IV_PROTO_CC_EXIT_NOTIFY)
     {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6672b5c..6acec78 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -664,10 +664,8 @@
 #endif
     "--x509-track x  : Save peer X509 attribute x in environment for use by\n"
     "                  plugins and management interface.\n"
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
     "--keying-material-exporter label len : Save Exported Keying Material (RFC5705)\n"
     "                  of len bytes (min. 16 bytes) using label in environment for use by plugins.\n"
-#endif
     "--remote-cert-ku v ... : Require that the peer certificate was signed with\n"
     "                  explicit key usage, you can specify more than one value.\n"
     "                  value should be given in hex format.\n"
@@ -3594,10 +3592,6 @@
             "calculation anymore or your security policy (e.g. FIPS 140-2) "
             "forbids it. Connections will only work with peers running "
             "OpenVPN 2.6.0 or higher)");
-#ifndef HAVE_EXPORT_KEYING_MATERIAL
-        msg(M_FATAL, "Keying Material Exporters (RFC 5705) not available either. "
-            "No way to generate data channel keys left.");
-#endif
         if (o->mode == MODE_SERVER)
         {
             msg(M_WARN, "Automatically enabling option "
@@ -8663,13 +8657,11 @@
         /* NCP only option that is pushed by the server to enable EKM,
          * should not be used by normal users in config files*/
         VERIFY_PERMISSION(OPT_P_NCP)
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
         if (streq(p[1], "tls-ekm"))
         {
             options->imported_protocol_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
         }
         else
-#endif
         {
             msg(msglevel, "Unknown key-derivation method %s", p[1]);
         }
@@ -8686,7 +8678,6 @@
             {
                 options->imported_protocol_flags |= CO_USE_CC_EXIT_NOTIFY;
             }
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
             else if (streq(p[j], "tls-ekm"))
             {
                 options->imported_protocol_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
@@ -8695,7 +8686,6 @@
             {
                 options->imported_protocol_flags |= CO_USE_DYNAMIC_TLS_CRYPT;
             }
-#endif
             else if (streq(p[j], "aead-epoch"))
             {
                 options->imported_protocol_flags |= CO_EPOCH_DATA_KEY_FORMAT;
@@ -9452,7 +9442,6 @@
         options->use_peer_id = true;
         options->peer_id = atoi_warn(p[1], msglevel);
     }
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
     else if (streq(p[0], "keying-material-exporter") && p[1] && p[2])
     {
         int ekm_length = positive_atoi(p[2], msglevel);
@@ -9479,7 +9468,6 @@
         options->keying_material_exporter_label = p[1];
         options->keying_material_exporter_length = ekm_length;
     }
-#endif /* HAVE_EXPORT_KEYING_MATERIAL */
     else if (streq(p[0], "allow-recursive-routing") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 8d1ef6c..b0b8d96 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -701,11 +701,9 @@
     bool use_peer_id;
     uint32_t peer_id;
 
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
     /* Keying Material Exporters [RFC 5705] */
     const char *keying_material_exporter_label;
     int keying_material_exporter_length;
-#endif
     /* force using TLS key material export for data channel key generation */
     bool force_key_material_export;
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index fd299ef..5ecf42b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2034,10 +2034,8 @@
 
         buf_printf(&out, "IV_CIPHERS=%s\n", session->opt->config_ncp_ciphers);
 
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
         iv_proto |= IV_PROTO_TLS_KEY_EXPORT;
         iv_proto |= IV_PROTO_DYN_TLS_CRYPT;
-#endif
 
         buf_printf(&out, "IV_PROTO=%d\n", iv_proto);
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index ec3135a..6474f80 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -174,8 +174,6 @@
     return ctx->initialised;
 }
 
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
-
 #if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
 /*
  * Key export callback for older versions of mbed TLS, to be used with
@@ -254,7 +252,7 @@
     cache->tls_prf_type = tls_prf_type;
 }
 #else  /* if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
-#error either HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB or HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB must be defined when HAVE_EXPORT_KEYING_MATERIAL is defined
+#error either mbedtls_ssl_conf_export_keys_ext_cb or mbedtls_ssl_set_export_keys_cb must be available in mbed TLS
 #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
 
 bool
@@ -289,16 +287,6 @@
         return false;
     }
 }
-#else  /* ifdef HAVE_EXPORT_KEYING_MATERIAL */
-bool
-key_state_export_keying_material(struct tls_session *session,
-                                 const char *label, size_t label_size,
-                                 void *ekm, size_t ekm_size)
-{
-    /* Dummy function to avoid ifdefs in the common code */
-    return false;
-}
-#endif /* HAVE_EXPORT_KEYING_MATERIAL */
 
 bool
 tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index ec30bb5..9ebb2ce 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -85,7 +85,6 @@
     void *sign_ctx;
 };
 
-#ifdef HAVE_EXPORT_KEYING_MATERIAL
 /** struct to cache TLS secrets for keying material exporter (RFC 5705).
  * The constants (64 and 48) are inherent to TLS version and
  * the whole keying material export will likely change when they change */
@@ -94,9 +93,6 @@
     mbedtls_tls_prf_types tls_prf_type;
     unsigned char master_secret[48];
 };
-#else  /* ifdef HAVE_EXPORT_KEYING_MATERIAL */
-struct tls_key_cache { };
-#endif
 
 /**
  * Structure that wraps the TLS context. Contents differ depending on the
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index ead91da..a9cd470 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -446,7 +446,6 @@
         session->opt->crypto_flags &= ~CO_EPOCH_DATA_KEY_FORMAT;
     }
 
-#if defined(HAVE_EXPORT_KEYING_MATERIAL)
     if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
         session->opt->crypto_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
@@ -479,7 +478,6 @@
     {
         session->opt->crypto_flags |= CO_USE_DYNAMIC_TLS_CRYPT;
     }
-#endif /* if defined(HAVE_EXPORT_KEYING_MATERIAL) */
 }
 
 void

