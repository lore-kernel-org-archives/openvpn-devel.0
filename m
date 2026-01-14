From: Gert Doering <gert@...1296...>
Date: Wed, 14 Jan 2026 12:04:47 +0100
Message-ID: <20260114110452.4976-1-gert@...1296...>
In-Reply-To: <gerrit.1765800034000.I3f661cf305c52652e430b8d219df5186dd8ea4f7@...2715...>
References: <gerrit.1765800034000.I3f661cf305c52652e430b8d219df5186dd8ea4f7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] remove ENABLE_X509ALTUSERNAME conditional
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

This is one of the #ifdef producing compile-time variants that make the
code harder to read and harder to test.  The extra code size due to
turning it on is marginal.

The mbedTLS backend does not (yet) support it.  To cope with that,
add a minimum function x509_username_field_ext_supported() that always
returns "false", and omit the --x509-username-field from the help
text if ENABLE_CRYPTO_MBEDTLS.  Implement this on another day.

Github: closes OpenVPN/openvpn#917

Change-Id: I3f661cf305c52652e430b8d219df5186dd8ea4f7
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1442
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1442
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index bdb1904..181c112 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -325,8 +325,6 @@
         target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})
         target_include_directories(${target} PRIVATE ${wolfssl_INCLUDE_DIRS}/wolfssl)
     else ()
-        set(ENABLE_X509ALTUSERNAME YES)
-
         find_package(OpenSSL REQUIRED)
         target_link_libraries(${target} PUBLIC OpenSSL::SSL OpenSSL::Crypto)
         if (WIN32)
@@ -365,10 +363,8 @@
 elseif (${WOLFSSL})
     set(ENABLE_CRYPTO_OPENSSL YES)
     set(ENABLE_CRYPTO_WOLFSSL YES)
-    set(ENABLE_X509ALTUSERNAME YES)
 else ()
     set(ENABLE_CRYPTO_OPENSSL YES)
-    set(ENABLE_X509ALTUSERNAME YES)
 endif ()
 
 include_directories(${CMAKE_CURRENT_SOURCE_DIR} src/compat include)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 53c3598..ee5936a 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -62,9 +62,6 @@
 /* Enable systemd integration */
 /* #undef ENABLE_SYSTEMD */
 
-/* Enable --x509-username-field feature */
-#cmakedefine ENABLE_X509ALTUSERNAME
-
 /* Define to 1 if you have the <arpa/inet.h> header file. */
 #cmakedefine HAVE_ARPA_INET_H 1
 
diff --git a/configure.ac b/configure.ac
index d5a0c70..9beae5a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -88,13 +88,6 @@
 )
 
 AC_ARG_ENABLE(
-	[x509-alt-username],
-	[AS_HELP_STRING([--enable-x509-alt-username], [enable the --x509-username-field feature @<:@default=no@:>@])],
-	,
-	[enable_x509_alt_username="no"]
-)
-
-AC_ARG_ENABLE(
 	[dns-updown-by-default],
 	[AS_HELP_STRING([--disable-dns-updown-by-default], [disable running --dns-updown by default @<:@default=yes@:>@])],
 	,
@@ -1186,15 +1179,6 @@
 fi
 AC_MSG_RESULT([${GIT_CHECKOUT}])
 
-dnl enable --x509-username-field feature if requested
-if test "${enable_x509_alt_username}" = "yes"; then
-	if test "${with_crypto_library}" = "mbedtls" ; then
-		AC_MSG_ERROR([mbed TLS does not support the --x509-username-field feature])
-	fi
-
-	AC_DEFINE([ENABLE_X509ALTUSERNAME], [1], [Enable --x509-username-field feature])
-fi
-
 test "${enable_management}" = "yes" && AC_DEFINE([ENABLE_MANAGEMENT], [1], [Enable management server capability])
 test "${enable_debug}" = "yes" && AC_DEFINE([ENABLE_DEBUG], [1], [Enable debugging support])
 test "${enable_small}" = "yes" && AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller executable size])
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cd01520..52e7592 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3328,11 +3328,7 @@
     to.verify_hash_algo = options->verify_hash_algo;
     to.verify_hash_depth = options->verify_hash_depth;
     to.verify_hash_no_ca = options->verify_hash_no_ca;
-#ifdef ENABLE_X509ALTUSERNAME
     memcpy(to.x509_username_field, options->x509_username_field, sizeof(to.x509_username_field));
-#else
-    to.x509_username_field[0] = X509_USERNAME_FIELD_DEFAULT;
-#endif
     to.es = c->c2.es;
     to.net_ctx = &c->net_ctx;
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 34af0d3..ead6c73 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -595,8 +595,6 @@
 #ifndef ENABLE_CRYPTO_MBEDTLS
     "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
     "                  and optionally the root CA certificate.\n"
-#endif
-#ifdef ENABLE_X509ALTUSERNAME
     "--x509-username-field : Field in x509 certificate containing the username.\n"
     "                        Default is CN in the Subject field.\n"
 #endif
@@ -885,9 +883,7 @@
     o->transition_window = 3600;
     o->tls_cert_profile = NULL;
     o->ecdh_curve = NULL;
-#ifdef ENABLE_X509ALTUSERNAME
     o->x509_username_field[0] = X509_USERNAME_FIELD_DEFAULT;
-#endif
 #ifdef ENABLE_PKCS11
     o->pkcs11_pin_cache_period = -1;
 #endif /* ENABLE_PKCS11 */
@@ -9073,7 +9069,6 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         x509_track_add(&options->x509_track, p[1], msglevel, &options->gc);
     }
-#ifdef ENABLE_X509ALTUSERNAME
     else if (streq(p[0], "x509-username-field") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
@@ -9088,7 +9083,6 @@
             options->x509_username_field[j - 1] = p[j];
         }
     }
-#endif /* ENABLE_X509ALTUSERNAME */
 #ifdef ENABLE_PKCS11
     else if (streq(p[0], "show-pkcs11-ids") && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 0561c25..8fab922 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -651,10 +651,8 @@
      * within n seconds of handshake initiation. */
     int handshake_window;
 
-#ifdef ENABLE_X509ALTUSERNAME
     /* Field list used to be the username in X509 cert. */
     char *x509_username_field[MAX_PARMS];
-#endif
 
     /* Old key allowed to live n seconds after new key goes active */
     int transition_window;
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 3129299..3e2a4e8 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -360,11 +360,7 @@
     int verify_hash_depth;
     bool verify_hash_no_ca;
     hash_algo_type verify_hash_algo;
-#ifdef ENABLE_X509ALTUSERNAME
     char *x509_username_field[MAX_PARMS];
-#else
-    char *x509_username_field[2];
-#endif
 
     /* struct crypto_option flags */
     unsigned int crypto_flags;
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 1d56533..09fcadf 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -113,7 +113,7 @@
 /*
  * Retrieve the certificate's username from the specified field.
  *
- * If the field is prepended with ext: and ENABLE_X509ALTUSERNAME is enabled,
+ * If the field is prepended with ext: is enabled,
  * it will be loaded from an X.509 extension
  *
  * @param cn                    Buffer to return the common name in.
@@ -126,15 +126,12 @@
 result_t backend_x509_get_username(char *common_name, size_t cn_len, char *x509_username_field,
                                    openvpn_x509_cert_t *peer_cert);
 
-#ifdef ENABLE_X509ALTUSERNAME
 /**
  * Return true iff the supplied extension field is supported by the
  * --x509-username-field option.
  */
 bool x509_username_field_ext_supported(const char *extname);
 
-#endif
-
 /*
  * Return the certificate's serial number in decimal string representation.
  *
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 250c806..393e7da 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -123,9 +123,12 @@
     return 0;
 }
 
-#ifdef ENABLE_X509ALTUSERNAME
-#warning "X509 alt user name not yet supported for mbed TLS"
-#endif
+/* not supported for mbedTLS yet */
+bool
+x509_username_field_ext_supported(const char *fieldname)
+{
+    return false;
+}
 
 result_t
 backend_x509_get_username(char *cn, size_t cn_len, char *x509_username_field, mbedtls_x509_crt *cert)
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 6cb04ee..9fdbe70 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -111,7 +111,6 @@
     return ret;
 }
 
-#ifdef ENABLE_X509ALTUSERNAME
 bool
 x509_username_field_ext_supported(const char *fieldname)
 {
@@ -180,7 +179,6 @@
     }
     return retval;
 }
-#endif /* ENABLE_X509ALTUSERNAME */
 
 /*
  * Extract a field from an X509 subject name.
@@ -252,7 +250,6 @@
 result_t
 backend_x509_get_username(char *common_name, size_t cn_len, char *x509_username_field, X509 *peer_cert)
 {
-#ifdef ENABLE_X509ALTUSERNAME
     if (strncmp("ext:", x509_username_field, 4) == 0)
     {
         if (!extract_x509_extension(peer_cert, x509_username_field + 4, common_name, cn_len))
@@ -275,7 +272,6 @@
         gc_free(&gc);
     }
     else
-#endif /* ifdef ENABLE_X509ALTUSERNAME */
     {
         X509_NAME *x509_subject_name = X509_get_subject_name(peer_cert);
         if (x509_subject_name == NULL)

