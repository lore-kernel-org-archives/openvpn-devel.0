From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:39 +0200
Message-Id: <1329787361-26096-34-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 33/35] build: proper crypto detection and
	usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac                      |  224 ++++++++++++++++++-------------------
 doc/doxygen/doc_data_crypto.h     |    2 +-
 include/openvpn-plugin.h          |   31 ++++--
 src/openvpn/Makefile.am           |    2 +
 src/openvpn/crypto.c              |   10 +-
 src/openvpn/crypto.h              |    8 +-
 src/openvpn/crypto_backend.h      |    4 +-
 src/openvpn/crypto_openssl.c      |   26 +---
 src/openvpn/crypto_polarssl.c     |    4 +-
 src/openvpn/error.c               |    8 +-
 src/openvpn/error.h               |    2 +-
 src/openvpn/forward-inline.h      |    6 +-
 src/openvpn/forward.c             |   24 ++--
 src/openvpn/init.c                |   84 +++++++-------
 src/openvpn/manage.c              |    4 +-
 src/openvpn/misc.c                |    2 +-
 src/openvpn/misc.h                |    6 +-
 src/openvpn/openvpn.h             |   26 ++--
 src/openvpn/options.c             |  140 ++++++++++++------------
 src/openvpn/options.h             |   14 +-
 src/openvpn/packet_id.c           |    4 +-
 src/openvpn/packet_id.h           |    4 +-
 src/openvpn/pkcs11_openssl.c      |    2 +-
 src/openvpn/pkcs11_polarssl.c     |    4 +-
 src/openvpn/plugin.c              |   12 +-
 src/openvpn/plugin.h              |   14 +-
 src/openvpn/reliable.c            |    4 +-
 src/openvpn/reliable.h            |    4 +-
 src/openvpn/session_id.c          |    4 +-
 src/openvpn/session_id.h          |    4 +-
 src/openvpn/ssl.c                 |    6 +-
 src/openvpn/ssl.h                 |    4 +-
 src/openvpn/ssl_backend.h         |   10 +-
 src/openvpn/ssl_openssl.c         |    8 +-
 src/openvpn/ssl_polarssl.c        |   10 +-
 src/openvpn/ssl_verify.c          |   22 ++--
 src/openvpn/ssl_verify.h          |    4 +-
 src/openvpn/ssl_verify_backend.h  |   26 ++--
 src/openvpn/ssl_verify_openssl.c  |   10 +-
 src/openvpn/ssl_verify_openssl.h  |    6 +-
 src/openvpn/ssl_verify_polarssl.c |    6 +-
 src/openvpn/ssl_verify_polarssl.h |    5 +-
 src/openvpn/syshead.h             |   14 +-
 src/plugins/examples/log_v3.c     |    4 +-
 44 files changed, 408 insertions(+), 410 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5a4f8b1..7c4bd9d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -227,19 +227,6 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_WITH(
-	[ssl-headers],
-	[AS_HELP_STRING([--with-ssl-headers=DIR], [Crypto/SSL Include files location])],
-	[CS_HDR_DIR="$withval"]
-	[CPPFLAGS="$CPPFLAGS -I$withval"] 
-)
-
-AC_ARG_WITH(
-	[ssl-lib],
-	[AS_HELP_STRING([--with-ssl-lib=DIR], [Crypto/SSL Library location])],
-	[LDFLAGS="$LDFLAGS -L$withval"] 
-)
-
-AC_ARG_WITH(
 	[mem-check],
 	[AS_HELP_STRING([--with-mem-check=TYPE], [build with debug memory checking, TYPE=dmalloc|valgrind|ssl])],
 	,
@@ -247,15 +234,15 @@ AC_ARG_WITH(
 )
 
 AC_ARG_WITH(
-	[ssl-type],
-	[AS_HELP_STRING([--with-ssl-type=TYPE], [build with the given SSL library, TYPE = openssl or polarssl])],
+	[crypto-library],
+	[AS_HELP_STRING([--with-crypto-library=library], [build with the given crypto library, TYPE=openssl|polarssl @<:@default=openssl@:>@])],
 	[
 		case "${withval}" in 
 			openssl|polarssl) ;;
-			*) AC_MSG_ERROR([bad value ${withval} for --with-ssl-type]) ;;
+			*) AC_MSG_ERROR([bad value ${withval} for --with-crypto-library]) ;;
 		esac
 	],
-	[with_ssl_type="openssl"]
+	[with_crypto_library="openssl"]
 )
 
 AC_DEFINE_UNQUOTED(TARGET_ALIAS, "${host}", [A string representing our host])
@@ -637,6 +624,72 @@ case "${with_mem_check}" in
 		;;
 esac
 
+have_openssl_crypto="yes"
+PKG_CHECK_MODULES(
+	[OPENSSL_CRYPTO],
+	[libcrypto >= 0.9.6],
+	,
+	[AC_CHECK_LIB(
+		[crypto],
+		[RSA_new],
+		[OPENSSL_CRYPTO_LIBS="-lcrypto"],
+		[have_openssl_crypto="no"]
+	)]
+)
+have_openssl_ssl="yes"
+PKG_CHECK_MODULES(
+	[OPENSSL_SSL],
+	[libssl >= 0.9.6],
+	,
+	[AC_CHECK_LIB(
+		[ssl],
+		[SSL_CTX_new],
+		[OPENSSL_SSL_LIBS="-lssl"],
+		[have_openssl_ssl="no"]
+	)]
+)
+if test "${have_openssl_crypto}" = "yes"; then
+	saved_CFLAGS="${CFLAGS}"
+	saved_LIBS="${LIBS}"
+	CFLAGS="${CFLAGS} ${OPENSSL_CRYPTO_CFLAGS}"
+	LIBS="${LIBS} ${OPENSSL_CRYPTO_LIBS}"
+	AC_CHECK_FUNCS([EVP_CIPHER_CTX_set_key_length])
+	have_openssl_engine="yes"
+	AC_CHECK_FUNCS(
+		[ \
+			ENGINE_load_builtin_engines \
+			ENGINE_register_all_complete \
+			ENGINE_cleanup \
+		],
+		,
+		[have_openssl_engine="no"; break]
+	)
+
+	CFLAGS="${saved_CFLAGS}"
+	LIBS="${saved_LIBS}"
+fi
+
+AC_ARG_VAR([POLARSSL_CFLAGS], [C compiler flags for polarssl])
+AC_ARG_VAR([POLARSSL_LIBS], [linker flags for polarssl])
+have_polarssl_ssl="yes"
+have_polarssl_crypto="yes"
+if test -z "${POLARSSL_LIBS}"; then
+	AC_CHECK_LIB(
+		[polarssl],
+		[ssl_init],
+		[POLARSSL_LIBS="-lpolarssl"],
+		[
+			have_polarssl_ssl="no"
+			AC_CHECK_LIB(
+				[polarssl],
+				[aes_crypt_cbc],
+				,
+				[have_polarssl_crypto="no"]
+			)
+		]
+	)
+fi
+
 AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for lzo])
 AC_ARG_VAR([LZO_LIBS], [linker flags for lzo])
 have_lzo="yes"
@@ -683,106 +736,9 @@ PKG_CHECK_MODULES(
 	[have_pkcs11_helper="yes"]
 )
 
-dnl
-dnl check for SSL-crypto library
-dnl
-if test "${enable_crypto}" = "yes"; then
-   if test "${with_ssl_type}" = "openssl"; then  
-       AC_CHECKING([for OpenSSL Crypto Library and Header files])
-       AC_CHECK_HEADER(openssl/evp.h,,
-	       [AC_MSG_ERROR([OpenSSL Crypto headers not found.])])
-
-       for lib in crypto eay32; do
-          AC_CHECK_LIB($lib, EVP_CIPHER_CTX_init,
-                [
-            		cryptofound=1
-			LIBS="${LIBS} -l$lib"
-    	        ]
-          )
-       done
-       test -n "$cryptofound" || AC_MSG_ERROR([OpenSSL Crypto library not found.])
-
-       AC_MSG_CHECKING([that OpenSSL Library is at least version 0.9.6])
-       AC_EGREP_CPP(yes,
-         [
-           #include <openssl/evp.h>
-           #if SSLEAY_VERSION_NUMBER >= 0x00906000L
-    	       yes
-           #endif
-         ],
-         [
-           AC_MSG_RESULT([yes])
-           AC_DEFINE(USE_CRYPTO, 1, [Use crypto library])
-           AC_DEFINE(USE_OPENSSL, 1, [Use OpenSSL library])
-           AC_CHECK_FUNCS(EVP_CIPHER_CTX_set_key_length)
-    
-           dnl check for OpenSSL crypto acceleration capability
-           AC_CHECK_HEADERS(openssl/engine.h)
-           AC_CHECK_FUNCS(ENGINE_load_builtin_engines)
-           AC_CHECK_FUNCS(ENGINE_register_all_complete)
-           AC_CHECK_FUNCS(ENGINE_cleanup)
-         ],
-         [AC_MSG_ERROR([OpenSSL crypto Library is too old.])]
-       )
-   fi
-   if test "${with_ssl_type}" = "polarssl"; then
-        AC_CHECKING([for PolarSSL Crypto Library and Header files])
-        AC_CHECK_HEADER(polarssl/aes.h,
-            [AC_CHECK_LIB(polarssl, aes_crypt_cbc,
-                [
-		    LIBS="${LIBS} -lpolarssl"
-                    AC_DEFINE(USE_CRYPTO, 1, [Use crypto library])
-                    AC_DEFINE(USE_POLARSSL, 1, [Use PolarSSL library])
-                ],
-                [AC_MSG_ERROR([PolarSSL Crypto library not found.])]
-            )],
-            [AC_MSG_ERROR([PolarSSL Crypto headers not found.])]
-        )
-    fi
-   dnl
-   dnl check for OpenSSL-SSL library
-   dnl
-
-   if test "${enable_ssl}" = "yes"; then
-      if test "${with_ssl_type}" = "openssl"; then  
-         AC_CHECKING([for OpenSSL SSL Library and Header files])
-         AC_CHECK_HEADER(openssl/ssl.h,,
-	      [AC_MSG_ERROR([OpenSSL SSL headers not found.])]
-         )
-
-         for lib in ssl ssl32; do
-	     AC_CHECK_LIB($lib, SSL_CTX_new,
-		   [
-			   sslfound=1
-			   LIBS="${LIBS} -l$lib"
-		   ]
-	     )
-         done
-
-         test -n "${sslfound}" || AC_MSG_ERROR([OpenSSL SSL library not found.])
-
-         AC_DEFINE(USE_SSL, 1, [Use OpenSSL SSL library])
-      fi
-      if test "${with_ssl_type}" = "polarssl"; then
-         AC_CHECKING([for PolarSSL SSL Library and Header files])
-         AC_CHECK_HEADER(polarssl/ssl.h,
-              [AC_CHECK_LIB(polarssl, ssl_init,
-              [
-		  LIBS="${LIBS} -lpolarssl"
-                  AC_DEFINE(USE_SSL, 1, [Use SSL library])
-                  AC_DEFINE(USE_POLARSSL, 1, [Use PolarSSL library])
-              ],
-              [AC_MSG_ERROR([PolarSSL SSL library not found.])]
-          )],
-              [AC_MSG_ERROR([PolarSSL SSL headers not found.])]
-          )
-       fi
-   fi
-fi
-
 dnl enable --x509-username-field feature if requested
 if test "${enable_x509_alt_username}" = "yes"; then
-	if test "${with_ssl_type}" = "polarssl" ; then
+	if test "${with_crypto_library}" = "polarssl" ; then
 		AC_MSG_ERROR([PolarSSL does not support the --x509-username-field feature])
 	fi
 
@@ -806,6 +762,42 @@ test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHEC
 test "${enable_password_save}" = "yes" && AC_DEFINE([ENABLE_PASSWORD_SAVE], [1], [Allow --askpass and --auth-user-pass passwords to be read from a file])
 test "${enable_systemd}" = "yes" && AC_DEFINE([ENABLE_SYSTEMD], [1], [Enable systemd support])
 
+case "${with_crypto_library}" in
+	openssl)
+		have_crypto_crypto="${have_openssl_crypto}"
+		have_crypto_ssl="${have_openssl_ssl}"
+		CRYPTO_CRYPTO_CFLAGS="${OPENSSL_CRYPTO_CFLAGS}"
+		CRYPTO_CRYPTO_LIBS="${OPENSSL_CRYPTO_LIBS}"
+		CRYPTO_SSL_CFLAGS="${OPENSSL_SSL_CFLAGS}"
+		CRYPTO_SSL_LIBS="${OPENSSL_SSL_LIBS}"
+		AC_DEFINE([ENABLE_CRYPTO_OPENSSL], [1], [Use OpenSSL library])
+		test "${have_openssl_engine}" = "yes" && AC_DEFINE([HAVE_OPENSSL_ENGINE], [1], [Use crypto library])
+		;;
+	polarssl)
+		have_crypto_crypto="${have_polarssl_crypto}"
+		have_crypto_ssl="${have_polarssl_ssl}"
+		CRYPTO_CRYPTO_CFLAGS="${POLARSSL_CRYPTO_CFLAGS}"
+		CRYPTO_CRYPTO_LIBS="${POLARSSL_LIBS}"
+		AC_DEFINE([ENABLE_CRYPTO_POLARSSL], [1], [Use PolarSSL library])
+		;;
+esac
+
+if test "${enable_crypto}" = "yes"; then
+	test "${have_crypto_crypto}" != "yes" && AC_MSG_ERROR([${with_crypto_library} crytpo is required but missing])
+	OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CRYPTO_CFLAGS}"
+	OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_CRYPTO_LIBS}"
+	AC_DEFINE([ENABLE_CRYPTO], [1], [Enable crypto library])
+fi
+
+
+if test "${enable_ssl}" = "yes"; then
+	test "${enable_crypto}" != "yes" && AC_MSG_ERROR([crypto must be enabled for ssl])
+	test "${have_crypto_ssl}" != "yes" && AC_MSG_ERROR([${with_ssl_library} ssl is required but missing])
+	OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_SSL_CFLAGS}"
+	OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_SSL_LIBS}"
+	AC_DEFINE([ENABLE_SSL], [1], [Enable ssl library])
+fi
+
 if test "${enable_plugins}" = "yes"; then
 	test "${WIN32}" != "yes" -a -z "${DL_LIBS}" && AC_MSG_ERROR([libdl is required for plugins])
 	OPTIONAL_DL_LIBS="${DL_LIBS}"
@@ -876,6 +868,8 @@ AC_SUBST([TAP_WIN_MIN_MINOR])
 
 AC_SUBST([OPTIONAL_DL_LIBS])
 AC_SUBST([OPTIONAL_SELINUX_LIBS])
+AC_SUBST([OPTIONAL_CRYPTO_CFLAGS])
+AC_SUBST([OPTIONAL_CRYPTO_LIBS])
 AC_SUBST([OPTIONAL_LZO_CFLAGS])
 AC_SUBST([OPTIONAL_LZO_LIBS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto.h
index 50437c1..ee72b8c 100644
--- a/doc/doxygen/doc_data_crypto.h
+++ b/doc/doxygen/doc_data_crypto.h
@@ -60,7 +60,7 @@
  *
  * @par Settings that control this module's activity
  * Whether or not the Data Channel Crypto module is active depends on the
- * compile-time \c USE_CRYPTO and \c USE_SSL preprocessor macros.  How it
+ * compile-time \c ENABLE_CRYPTO and \c ENABLE_SSL preprocessor macros.  How it
  * processes packets received from the \link data_control Data Channel
  * Control module\endlink at runtime depends on the associated \c
  * crypto_options structure.  To perform cryptographic operations, the \c
diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
index de54a5a..f82f61f 100644
--- a/include/openvpn-plugin.h
+++ b/include/openvpn-plugin.h
@@ -24,16 +24,25 @@
 
 #ifndef OPENVPN_PLUGIN_H_
 #define OPENVPN_PLUGIN_H_
-#ifdef USE_SSL
-#  if defined(SSL_VERIFY_OPENSSL_H_) || defined(SSL_VERIFY_POLARSSL_H_)
-#    define ENABLE_SSL_PLUGIN
-#  else
-#    warning "Neither OpenSSL or PoLarSSL headers included, disabling plugin's SSL support"
-#  endif
-#endif /*USE_SSL*/
 
 #define OPENVPN_PLUGIN_VERSION 3
 
+#ifdef ENABLE_SSL
+#ifdef ENABLE_CRYPTO_POLARSSL
+#include <polarssl/x509.h>
+#ifndef __OPENVPN_X509_CERT_T_DECLARED
+#define __OPENVPN_X509_CERT_T_DECLARED
+typedef x509_cert openvpn_x509_cert_t;
+#endif
+#else
+#include <openssl/x509.h>
+#ifndef __OPENVPN_X509_CERT_T_DECLARED
+#define __OPENVPN_X509_CERT_T_DECLARED
+typedef X509 openvpn_x509_cert_t;
+#endif
+#endif
+#endif
+
 /*
  * Plug-in types.  These types correspond to the set of script callbacks
  * supported by OpenVPN.
@@ -268,9 +277,9 @@ struct openvpn_plugin_args_open_return
  * *per_client_context : the per-client context pointer which was returned by
  *        openvpn_plugin_client_constructor_v1, if defined.
  *
- * current_cert_depth : Certificate depth of the certificate being passed over (only if compiled with USE_SSL defined)
+ * current_cert_depth : Certificate depth of the certificate being passed over (only if compiled with ENABLE_SSL defined)
  *
- * *current_cert : X509 Certificate object received from the client (only if compiled with USE_SSL defined)
+ * *current_cert : X509 Certificate object received from the client (only if compiled with ENABLE_SSL defined)
  *
  */
 struct openvpn_plugin_args_func_in
@@ -280,9 +289,9 @@ struct openvpn_plugin_args_func_in
   const char ** const envp;
   openvpn_plugin_handle_t handle;
   void *per_client_context;
-#ifdef ENABLE_SSL_PLUGIN
+#ifdef ENABLE_SSL
   int current_cert_depth;
-  x509_cert_t *current_cert;
+  openvpn_x509_cert_t *current_cert;
 #else
   int __current_cert_depth_disabled; /* Unused, for compatibility purposes only */
   void *__current_cert_disabled; /* Unused, for compatibility purposes only */
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 79016c3..ec5bbbf 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -17,6 +17,7 @@ MAINTAINERCLEANFILES = \
 INCLUDES = -I$(top_srcdir)/include
 
 AM_CFLAGS = \
+	$(OPTIONAL_CRYPTO_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
 
@@ -103,6 +104,7 @@ openvpn_LDADD = \
 	$(SOCKETS_LIBS) \
 	$(OPTIONAL_LZO_LIBS) \
 	$(OPTIONAL_PKCS11_HELPER_LIBS) \
+	$(OPTIONAL_CRYPTO_LIBS) \
 	$(OPTIONAL_SELINUX_LIBS) \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 5af92a0..9e7fa87 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -25,7 +25,7 @@
 
 #include "syshead.h"
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 
 #include "crypto.h"
 #include "error.h"
@@ -712,7 +712,7 @@ test_crypto (const struct crypto_options *co, struct frame* frame)
   gc_free (&gc);
 }
 
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
 
 void
 get_tls_handshake_key (const struct key_type *key_type,
@@ -1373,7 +1373,7 @@ get_random()
   return l;
 }
 
-#ifndef USE_SSL
+#ifndef ENABLE_SSL
 
 void
 init_ssl_lib (void)
@@ -1392,7 +1392,7 @@ free_ssl_lib (void)
   ERR_free_strings ();
 }
 
-#endif /* USE_SSL */
+#endif /* ENABLE_SSL */
 
 /*
  * md5 functions
@@ -1452,4 +1452,4 @@ md5_digest_equal (const struct md5_digest *d1, const struct md5_digest *d2)
   return memcmp(d1->digest, d2->digest, MD5_DIGEST_LENGTH) == 0;
 }
 
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_CRYPTO */
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 293f984..3b4b88e 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -30,7 +30,7 @@
 #ifndef CRYPTO_H
 #define CRYPTO_H
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 
 #define ALLOW_NON_CBC_CIPHERS
 
@@ -347,7 +347,7 @@ void key2_print (const struct key2* k,
 		 const char* prefix0,
 		 const char* prefix1);
 
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
 
 #define GHK_INLINE  (1<<0)
 void get_tls_handshake_key (const struct key_type *key_type,
@@ -361,7 +361,7 @@ void get_tls_handshake_key (const struct key_type *key_type,
 void init_ssl_lib (void);
 void free_ssl_lib (void);
 
-#endif /* USE_SSL */
+#endif /* ENABLE_SSL */
 
 /*
  * md5 functions
@@ -394,5 +394,5 @@ key_ctx_bi_defined(const struct key_ctx_bi* key)
 }
 
 
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_CRYPTO */
 #endif /* CRYPTO_H */
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index a0966dd..57f2ac4 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -32,10 +32,10 @@
 
 #include "config.h"
 
-#ifdef USE_OPENSSL
+#ifdef ENABLE_CRYPTO_OPENSSL
 #include "crypto_openssl.h"
 #endif
-#ifdef USE_POLARSSL
+#ifdef ENABLE_CRYPTO_POLARSSL
 #include "crypto_polarssl.h"
 #endif
 #include "basic.h"
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index e5e1122..72b0c3c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -29,7 +29,7 @@
 
 #include "syshead.h"
 
-#if defined(USE_CRYPTO) && defined(USE_OPENSSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
 
 #include "basic.h"
 #include "buffer.h"
@@ -104,19 +104,7 @@ cipher_ok (const char* name)
 #define EVP_MD_name(e)			OBJ_nid2sn(EVP_MD_type(e))
 #endif
 
-/*
- *
- * OpenSSL engine support. Allows loading/unloading of engines.
- *
- */
-
-#if defined(HAVE_OPENSSL_ENGINE_H) && defined(HAVE_ENGINE_LOAD_BUILTIN_ENGINES) && defined(HAVE_ENGINE_REGISTER_ALL_COMPLETE) && defined(HAVE_ENGINE_CLEANUP)
-#define CRYPTO_ENGINE 1
-#else
-#define CRYPTO_ENGINE 0
-#endif
-
-#if CRYPTO_ENGINE
+#if HAVE_OPENSSL_ENGINE
 #include <openssl/engine.h>
 
 static bool engine_initialized = false; /* GLOBAL */
@@ -173,12 +161,12 @@ setup_engine (const char *engine)
   return e;
 }
 
-#endif /* CRYPTO_ENGINE */
+#endif /* HAVE_OPENSSL_ENGINE */
 
 void
 crypto_init_lib_engine (const char *engine_name)
 {
-#if CRYPTO_ENGINE
+#if HAVE_OPENSSL_ENGINE
   if (!engine_initialized)
     {
       ASSERT (engine_name);
@@ -220,7 +208,7 @@ crypto_uninit_lib (void)
   fclose (fp);
 #endif
 
-#if CRYPTO_ENGINE
+#if HAVE_OPENSSL_ENGINE
   if (engine_initialized)
     {
       ENGINE_cleanup ();
@@ -335,7 +323,7 @@ show_available_digests ()
 void
 show_available_engines ()
 {
-#if CRYPTO_ENGINE /* Only defined for OpenSSL */
+#if HAVE_OPENSSL_ENGINE /* Only defined for OpenSSL */
   ENGINE *e;
 
   printf ("OpenSSL Crypto Engines\n\n");
@@ -741,4 +729,4 @@ hmac_ctx_final (HMAC_CTX *ctx, uint8_t *dst)
   HMAC_Final (ctx, dst, &in_hmac_len);
 }
 
-#endif /* USE_CRYPTO && USE_OPENSSL */
+#endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_OPENSSL */
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index ac4cadd..7a7d9b0 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -29,7 +29,7 @@
 
 #include "syshead.h"
 
-#if defined(USE_CRYPTO) && defined(USE_POLARSSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_POLARSSL)
 
 #include "errlevel.h"
 #include "basic.h"
@@ -557,4 +557,4 @@ hmac_ctx_final (md_context_t *ctx, uint8_t *dst)
   ASSERT(0 == md_hmac_finish(ctx, dst));
 }
 
-#endif /* USE_CRYPTO && USE_POLARSSL */
+#endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_POLARSSL */
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 34c4184..3de5487 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -37,8 +37,8 @@
 #include "ps.h"
 #include "mstats.h"
 
-#ifdef USE_CRYPTO
-#ifdef USE_OPENSSL
+#ifdef ENABLE_CRYPTO
+#ifdef ENABLE_CRYPTO_OPENSSL
 #include <openssl/err.h>
 #endif
 #endif
@@ -246,8 +246,8 @@ void x_msg (const unsigned int flags, const char *format, ...)
       SWAP;
     }
 
-#ifdef USE_CRYPTO
-#ifdef USE_OPENSSL
+#ifdef ENABLE_CRYPTO
+#ifdef ENABLE_CRYPTO_OPENSSL
   if (flags & M_SSL)
     {
       int nerrs = 0;
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index d2c04b0..ed8f903 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -96,7 +96,7 @@ extern int x_msg_line_num;
 #define M_ERRNO           (1<<8)	 /* show errno description */
 #define M_ERRNO_SOCK      (1<<9)	 /* show socket errno description */
 
-#ifdef USE_OPENSSL
+#ifdef ENABLE_CRYPTO_OPENSSL
 #  define M_SSL             (1<<10)	 /* show SSL error */
 #endif
 
diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
index 64ca941..5853ce2 100644
--- a/src/openvpn/forward-inline.h
+++ b/src/openvpn/forward-inline.h
@@ -35,7 +35,7 @@
 static inline void
 check_tls (struct context *c)
 {
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   void check_tls_dowork (struct context *c);
   if (c->c2.tls_multi)
     check_tls_dowork (c);
@@ -49,7 +49,7 @@ check_tls (struct context *c)
 static inline void
 check_tls_errors (struct context *c)
 {
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   void check_tls_errors_co (struct context *c);
   void check_tls_errors_nco (struct context *c);
   if (c->c2.tls_multi && c->c2.tls_exit_signal)
@@ -189,7 +189,7 @@ check_push_request (struct context *c)
 
 #endif
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 /*
  * Should we persist our anti-replay packet ID state to disk?
  */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 46bbfe7..5e1e2a6 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -81,7 +81,7 @@ show_wait_status (struct context *c)
  * traffic on the control-channel.
  *
  */
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
 void
 check_tls_dowork (struct context *c)
 {
@@ -112,7 +112,7 @@ check_tls_dowork (struct context *c)
 }
 #endif
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
 
 void
 check_tls_errors_co (struct context *c)
@@ -232,7 +232,7 @@ check_connection_established_dowork (struct context *c)
 bool
 send_control_channel_string (struct context *c, const char *str, int msglevel)
 {
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   if (c->c2.tls_multi) {
     struct gc_arena gc = gc_new ();
     bool stat;
@@ -449,8 +449,8 @@ encrypt_sign (struct context *c, bool comp_frag)
 #endif
     }
 
-#ifdef USE_CRYPTO
-#ifdef USE_SSL
+#ifdef ENABLE_CRYPTO
+#ifdef ENABLE_SSL
   /*
    * If TLS mode, get the key we will use to encrypt
    * the packet.
@@ -472,8 +472,8 @@ encrypt_sign (struct context *c, bool comp_frag)
    */
   link_socket_get_outgoing_addr (&c->c2.buf, get_link_socket_info (c),
 				 &c->c2.to_link_addr);
-#ifdef USE_CRYPTO
-#ifdef USE_SSL
+#ifdef ENABLE_CRYPTO
+#ifdef ENABLE_SSL
   /*
    * In TLS mode, prepend the appropriate one-byte opcode
    * to the packet which identifies it as a data channel
@@ -498,7 +498,7 @@ encrypt_sign (struct context *c, bool comp_frag)
 static void
 process_coarse_timers (struct context *c)
 {
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   /* flush current packet-id to file once per 60
      seconds if --replay-persist was specified */
   check_packet_id_persist_flush (c);
@@ -789,8 +789,8 @@ process_incoming_link (struct context *c)
       if (!link_socket_verify_incoming_addr (&c->c2.buf, lsi, &c->c2.from))
 	link_socket_bad_incoming_addr (&c->c2.buf, lsi, &c->c2.from);
 
-#ifdef USE_CRYPTO
-#ifdef USE_SSL
+#ifdef ENABLE_CRYPTO
+#ifdef ENABLE_SSL
       if (c->c2.tls_multi)
 	{
 	  /*
@@ -820,7 +820,7 @@ process_incoming_link (struct context *c)
       if (c->c2.context_auth != CAS_SUCCEEDED)
 	c->c2.buf.len = 0;
 #endif
-#endif /* USE_SSL */
+#endif /* ENABLE_SSL */
 
       /* authenticate and decrypt the incoming packet */
       decrypt_status = openvpn_decrypt (&c->c2.buf, c->c2.buffers->decrypt_buf, &c->c2.crypto_options, &c->c2.frame);
@@ -833,7 +833,7 @@ process_incoming_link (struct context *c)
 	  goto done;
 	}
 
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_CRYPTO */
 
 #ifdef ENABLE_FRAGMENT
       if (c->c2.fragment)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c3a2c58..e71ebb0 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -428,7 +428,7 @@ next_connection_entry (struct context *c)
 static void
 init_query_passwords (struct context *c)
 {
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   /* Certificate password input */
   if (c->options.key_pass_file)
     pem_password_setup (c->options.key_pass_file);
@@ -629,7 +629,7 @@ init_static (void)
 {
   /* configure_path (); */
 
-#if defined(USE_CRYPTO) && defined(DMALLOC)
+#if defined(ENABLE_CRYPTO) && defined(DMALLOC)
   crypto_init_dmalloc();
 #endif
 
@@ -652,7 +652,7 @@ init_static (void)
 
   update_time ();
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   init_ssl_lib ();
 
   /* init PRNG used for IV generation */
@@ -838,7 +838,7 @@ init_static (void)
 void
 uninit_static (void)
 {
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   free_ssl_lib ();
 #endif
 
@@ -850,7 +850,7 @@ uninit_static (void)
   close_port_share ();
 #endif
 
-#if defined(MEASURE_TLS_HANDSHAKE_STATS) && defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(MEASURE_TLS_HANDSHAKE_STATS) && defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   show_tls_performance_stats ();
 #endif
 }
@@ -891,9 +891,9 @@ print_openssl_info (const struct options *options)
   /*
    * OpenSSL info print mode?
    */
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   if (options->show_ciphers || options->show_digests || options->show_engines
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
       || options->show_tls_ciphers
 #endif
     )
@@ -904,7 +904,7 @@ print_openssl_info (const struct options *options)
 	show_available_digests ();
       if (options->show_engines)
 	show_available_engines ();
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
       if (options->show_tls_ciphers)
 	show_available_tls_ciphers ();
 #endif
@@ -920,7 +920,7 @@ print_openssl_info (const struct options *options)
 bool
 do_genkey (const struct options * options)
 {
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   if (options->genkey)
     {
       int nbits_written;
@@ -955,9 +955,9 @@ do_persist_tuntap (const struct options *options)
       notnull (options->dev, "TUN/TAP device (--dev)");
       if (options->ce.remote || options->ifconfig_local
 	  || options->ifconfig_remote_netmask
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 	  || options->shared_secret_file
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
 	  || options->tls_server || options->tls_client
 #endif
 #endif
@@ -1068,7 +1068,7 @@ const char *
 format_common_name (struct context *c, struct gc_arena *gc)
 {
   struct buffer out = alloc_buf_gc (256, gc);
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   if (c->c2.tls_multi)
     {
       buf_printf (&out, "[%s] ", tls_common_name (c->c2.tls_multi, false));
@@ -1155,12 +1155,12 @@ do_init_timers (struct context *c, bool deferred)
 #endif
 
       /* initialize packet_id persistence timer */
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
       if (c->options.packet_id_file)
 	event_timeout_init (&c->c2.packet_id_persist_interval, 60, now);
 #endif
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
       /* initialize tmp_int optimization that limits the number of times we call
 	 tls_multi_process in the main event loop */
       interval_init (&c->c2.tmp_int, TLS_MULTI_HORIZON, TLS_MULTI_REFRESH);
@@ -1967,20 +1967,20 @@ frame_finalize_options (struct context *c, const struct options *o)
 static void
 key_schedule_free (struct key_schedule *ks, bool free_ssl_ctx)
 {
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   free_key_ctx_bi (&ks->static_key);
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   if (tls_ctx_initialised(&ks->ssl_ctx) && free_ssl_ctx)
     {
       tls_ctx_free (&ks->ssl_ctx);
       free_key_ctx_bi (&ks->tls_auth_key);
     }
-#endif /* USE_SSL */
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_SSL */
+#endif /* ENABLE_CRYPTO */
   CLEAR (*ks);
 }
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 
 static void
 init_crypto_pre (struct context *c, const unsigned int flags)
@@ -2091,7 +2091,7 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
 			       options->use_iv);
 }
 
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
 
 /*
  * Initialize the persistent component of OpenVPN's TLS mode,
@@ -2330,10 +2330,10 @@ do_init_finalize_tls_frame (struct context *c)
     }
 }
 
-#endif /* USE_SSL */
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_SSL */
+#endif /* ENABLE_CRYPTO */
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 /*
  * No encryption or authentication.
  */
@@ -2349,20 +2349,20 @@ do_init_crypto_none (const struct context *c)
 static void
 do_init_crypto (struct context *c, const unsigned int flags)
 {
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   if (c->options.shared_secret_file)
     do_init_crypto_static (c, flags);
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   else if (c->options.tls_server || c->options.tls_client)
     do_init_crypto_tls (c, flags);
 #endif
   else				/* no encryption or authentication. */
     do_init_crypto_none (c);
-#else /* USE_CRYPTO */
+#else /* ENABLE_CRYPTO */
   msg (M_WARN,
        "******* WARNING *******: " PACKAGE_NAME
        " built without OpenSSL -- encryption and authentication features disabled -- all data will be tunnelled as cleartext");
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_CRYPTO */
 }
 
 static void
@@ -2501,13 +2501,13 @@ do_option_warnings (struct context *c)
 #endif
 #endif
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   if (!o->replay)
     msg (M_WARN, "WARNING: You have disabled Replay Protection (--no-replay) which may make " PACKAGE_NAME " less secure");
   if (!o->use_iv)
     msg (M_WARN, "WARNING: You have disabled Crypto IVs (--no-iv) which may make " PACKAGE_NAME " less secure");
 
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   if (o->tls_server)
     warn_on_use_of_common_subnets ();
   if (o->tls_client
@@ -2540,7 +2540,7 @@ do_option_warnings (struct context *c)
 static void
 do_init_frame_tls (struct context *c)
 {
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   do_init_finalize_tls_frame (c);
 #endif
 }
@@ -2557,7 +2557,7 @@ init_context_buffers (const struct frame *frame)
 
   b->aux_buf = alloc_buf (BUF_SIZE (frame));
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   b->encrypt_buf = alloc_buf (BUF_SIZE (frame));
   b->decrypt_buf = alloc_buf (BUF_SIZE (frame));
 #endif
@@ -2584,7 +2584,7 @@ free_context_buffers (struct context_buffers *b)
       free_buf (&b->lzo_decompress_buf);
 #endif
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
       free_buf (&b->encrypt_buf);
       free_buf (&b->decrypt_buf);
 #endif
@@ -2733,7 +2733,7 @@ do_compute_occ_strings (struct context *c)
   msg (D_SHOW_OCC, "Expected Remote Options String: '%s'",
        c->c2.options_string_remote);
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   msg (D_SHOW_OCC_HASH, "Local Options hash (VER=%s): '%s'",
        options_string_version (c->c2.options_string_local, &gc),
        md5sum ((uint8_t*)c->c2.options_string_local,
@@ -2744,7 +2744,7 @@ do_compute_occ_strings (struct context *c)
 	       strlen (c->c2.options_string_remote), 9, &gc));
 #endif
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   if (c->c2.tls_multi)
     tls_multi_init_set_options (c->c2.tls_multi,
 				c->c2.options_string_local,
@@ -2830,7 +2830,7 @@ do_close_free_buf (struct context *c)
 static void
 do_close_tls (struct context *c)
 {
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   if (c->c2.tls_multi)
     {
       tls_multi_free (c->c2.tls_multi, true);
@@ -2886,7 +2886,7 @@ do_close_link_socket (struct context *c)
 static void
 do_close_packet_id (struct context *c)
 {
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   packet_id_free (&c->c2.packet_id);
   packet_id_persist_save (&c->c1.pid_persist);
   if (!(c->sig->signal_received == SIGUSR1))
@@ -3064,7 +3064,7 @@ do_setup_fast_io (struct context *c)
 static void
 do_signal_on_tls_errors (struct context *c)
 {
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   if (c->options.tls_exit)
     c->c2.tls_exit_signal = SIGTERM;
   else
@@ -3609,9 +3609,9 @@ inherit_context_child (struct context *dest,
   /* c1 init */
   packet_id_persist_init (&dest->c1.pid_persist);
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   dest->c1.ks.key_type = src->c1.ks.key_type;
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   /* inherit SSL context */
   dest->c1.ks.ssl_ctx = src->c1.ks.ssl_ctx;
   dest->c1.ks.tls_auth_key = src->c1.ks.tls_auth_key;
@@ -3688,7 +3688,7 @@ inherit_context_top (struct context *dest,
   /* detach plugins */
   dest->plugins_owned = false;
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   dest->c2.tls_multi = NULL;
 #endif
 
@@ -3733,7 +3733,7 @@ close_context (struct context *c, int sig, unsigned int flags)
     context_gc_free (c);
 }
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 
 /*
  * Do a loopback test
@@ -3766,7 +3766,7 @@ test_crypto_thread (void *arg)
 bool
 do_test_crypto (const struct options *o)
 {
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   if (o->test_crypto)
     {
       struct context c;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 23e32db..e84a423 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -699,7 +699,7 @@ man_query_need_str (struct management *man, const char *type, const char *action
 static void
 man_forget_passwords (struct management *man)
 {
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   ssl_purge_auth (false);
   msg (M_CLIENT, "SUCCESS: Passwords were forgotten");
 #endif
@@ -1714,7 +1714,7 @@ man_reset_client_socket (struct management *man, const bool exiting)
     }
   if (!exiting)
     {
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
       if (man->settings.flags & MF_FORGET_DISCONNECT)
 	ssl_purge_auth (false);
 #endif
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 7070c21..4891251 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1243,7 +1243,7 @@ test_file (const char *filename)
   return ret;
 }
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 
 /* create a temporary filename in directory */
 const char *
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 96f8bf8..940c2c1 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -194,7 +194,7 @@ int openvpn_chdir (const char* dir);
 extern int inetd_socket_descriptor;
 void save_inetd_socket_descriptor (void);
 
-/* init random() function, only used as source for weak random numbers, when !USE_CRYPTO */
+/* init random() function, only used as source for weak random numbers, when !ENABLE_CRYPTO */
 void init_random_seed(void);
 
 /* set/delete environmental variable */
@@ -252,7 +252,7 @@ void sleep_milliseconds (unsigned int n);
 void sleep_until_signal (void);
 
 /* an analogue to the random() function, but use OpenSSL functions if available */
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 long int get_random(void);
 #else
 #define get_random random
@@ -273,7 +273,7 @@ bool delete_file (const char *filename);
 /* return true if pathname is absolute */
 bool absolute_pathname (const char *pathname);
 
-/* prepend a random prefix to hostname (need USE_CRYPTO) */
+/* prepend a random prefix to hostname (need ENABLE_CRYPTO) */
 const char *hostname_randomize(const char *hostname, struct gc_arena *gc);
 
 /*
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 5af422e..f4f877b 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -55,24 +55,24 @@
 
 struct key_schedule
 {
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   /* which cipher, HMAC digest, and key sizes are we using? */
   struct key_type key_type;
 
   /* pre-shared static key, read from a file */
   struct key_ctx_bi static_key;
 
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   /* our global SSL context */
   struct tls_root_ctx ssl_ctx;
 
   /* optional authentication HMAC key for TLS control channel */
   struct key_ctx_bi tls_auth_key;
 
-#endif				/* USE_SSL */
-#else				/* USE_CRYPTO */
+#endif				/* ENABLE_SSL */
+#else				/* ENABLE_CRYPTO */
   int dummy;
-#endif				/* USE_CRYPTO */
+#endif				/* ENABLE_CRYPTO */
 };
 
 /*
@@ -99,7 +99,7 @@ struct context_buffers
   struct buffer aux_buf;
 
   /* workspace buffers used by crypto routines */
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   struct buffer encrypt_buf;
   struct buffer decrypt_buf;
 #endif
@@ -331,12 +331,12 @@ struct context_2
   int occ_mtu_load_n_tries;
 #endif
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 
   /*
    * TLS-mode crypto objects.
    */
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
 
   struct tls_multi *tls_multi;  /**< TLS state structure for this VPN
                                  *   tunnel. */
@@ -358,7 +358,7 @@ struct context_2
   /* throw this signal on TLS errors */
   int tls_exit_signal;
 
-#endif /* USE_SSL */
+#endif /* ENABLE_SSL */
 
   struct crypto_options crypto_options;
                                 /**< Security parameters and crypto state
@@ -370,7 +370,7 @@ struct context_2
   struct packet_id packet_id;
   struct event_timeout packet_id_persist_interval;
 
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_CRYPTO */
 
 #ifdef ENABLE_LZO
   struct lzo_compress_workspace lzo_compwork;
@@ -566,7 +566,7 @@ struct context
  * have been compiled in.
  */
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
 #define TLS_MODE(c) ((c)->c2.tls_multi != NULL)
 #define PROTO_DUMP_FLAGS (check_debug_level (D_LINK_RW_VERBOSE) ? (PD_SHOW_DATA|PD_VERBOSE) : 0)
 #define PROTO_DUMP(buf, gc) protocol_dump((buf), \
@@ -579,13 +579,13 @@ struct context
 #define PROTO_DUMP(buf, gc) format_hex (BPTR (buf), BLEN (buf), 80, gc)
 #endif
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 #define MD5SUM(buf, len, gc) md5sum((buf), (len), 0, (gc))
 #else
 #define MD5SUM(buf, len, gc) "[unavailable]"
 #endif
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 #define CIPHER_ENABLED(c) (c->c1.ks.key_type.cipher != NULL)
 #else
 #define CIPHER_ENABLED(c) (false)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 45d2876..52207b5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -56,25 +56,25 @@
 const char title_string[] =
   PACKAGE_STRING
   " " TARGET_ALIAS
-#ifdef USE_CRYPTO
-#ifdef USE_SSL
-#if defined(USE_POLARSSL)
+#ifdef ENABLE_CRYPTO
+#ifdef ENABLE_SSL
+#if defined(ENABLE_CRYPTO_POLARSSL)
   " [SSL (PolarSSL)]"
-#elif defined(USE_OPENSSL)
+#elif defined(ENABLE_CRYPTO_OPENSSL)
   " [SSL (OpenSSL)]"
 #else
   " [SSL]"
-#endif /* defined(USE_POLARSSL) */
-#else /* ! USE_SSL */
-#if defined(USE_POLARSSL)
+#endif /* defined(ENABLE_CRYPTO_POLARSSL) */
+#else /* ! ENABLE_SSL */
+#if defined(ENABLE_CRYPTO_POLARSSL)
   " [CRYPTO (PolarSSL)]"
-#elif defined(USE_OPENSSL)
+#elif defined(ENABLE_CRYPTO_OPENSSL)
   " [CRYPTO (OpenSSL)]"
 #else
   " [CRYPTO]"
-#endif /* defined(USE_POLARSSL) */
-#endif /* USE_SSL */
-#endif /* USE_CRYPTO */
+#endif /* defined(ENABLE_CRYPTO_POLARSSL) */
+#endif /* ENABLE_SSL */
+#endif /* ENABLE_CRYPTO */
 #ifdef ENABLE_LZO
 #ifdef ENABLE_LZO_STUB
   " [LZO (STUB)]"
@@ -503,7 +503,7 @@ static const char usage_message[] =
   "--explicit-exit-notify [n] : On exit/restart, send exit signal to\n"
   "                  server/remote. n = # of retries, default=1.\n"
 #endif
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   "\n"
   "Data Channel Encryption Options (must be compatible between peers):\n"
   "(These options are meaningful for both Static Key & TLS-mode)\n"
@@ -526,7 +526,7 @@ static const char usage_message[] =
   "--keysize n     : Size of cipher key in bits (optional).\n"
   "                  If unspecified, defaults to cipher-specific default.\n"
 #endif
-#ifndef USE_POLARSSL
+#ifndef ENABLE_CRYPTO_POLARSSL
   "--engine [name] : Enable OpenSSL hardware crypto engine functionality.\n"
 #endif
   "--no-replay     : Disable replay protection.\n"
@@ -539,7 +539,7 @@ static const char usage_message[] =
   "                  using file.\n"
   "--test-crypto   : Run a self-test of crypto features enabled.\n"
   "                  For debugging only.\n"
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   "\n"
   "TLS Key Negotiation Options:\n"
   "(These options are meaningful only for TLS-mode)\n"
@@ -549,7 +549,7 @@ static const char usage_message[] =
   "                  number, such as 1 (default), 2, etc.\n"
   "--ca file       : Certificate authority file in .pem format containing\n"
   "                  root certificate.\n"
-#ifndef USE_POLARSSL
+#ifndef ENABLE_CRYPTO_POLARSSL
   "--capath dir    : A directory of trusted certificates (CAs"
 #if OPENSSL_VERSION_NUMBER >= 0x00907000L
   " and CRLs).\n"
@@ -557,7 +557,7 @@ static const char usage_message[] =
   ").\n"
   "                  WARNING: no support of CRL available with this version.\n"
 #endif /* OPENSSL_VERSION_NUMBER >= 0x00907000L */
-#endif /* USE_POLARSSL */
+#endif /* ENABLE_CRYPTO_POLARSSL */
   "--dh file       : File containing Diffie Hellman parameters\n"
   "                  in .pem format (for --tls-server only).\n"
   "                  Use \"openssl dhparam -out dh1024.pem 1024\" to generate.\n"
@@ -565,7 +565,7 @@ static const char usage_message[] =
   "                  by a Certificate Authority in --ca file.\n"
   "--extra-certs file : one or more PEM certs that complete the cert chain.\n"
   "--key file      : Local private key in .pem format.\n"
-#ifndef USE_POLARSSL
+#ifndef ENABLE_CRYPTO_POLARSSL
   "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
   "                  and optionally the root CA certificate.\n"
 #endif
@@ -616,7 +616,7 @@ static const char usage_message[] =
   "--x509-track x  : Save peer X509 attribute x in environment for use by\n"
   "                  plugins and management interface.\n"
 #endif
-#if OPENSSL_VERSION_NUMBER >= 0x00907000L || USE_POLARSSL
+#if OPENSSL_VERSION_NUMBER >= 0x00907000L || ENABLE_CRYPTO_POLARSSL
   "--remote-cert-ku v ... : Require that the peer certificate was signed with\n"
   "                  explicit key usage, you can specify more than one value.\n"
   "                  value should be given in hex format.\n"
@@ -626,8 +626,8 @@ static const char usage_message[] =
   "--remote-cert-tls t: Require that peer certificate was signed with explicit\n"
   "                  key usage and extended key usage based on RFC3280 TLS rules.\n"
   "                  t = 'client' | 'server'.\n"
-#endif				/* OPENSSL_VERSION_NUMBER || USE_POLARSSL */
-#endif				/* USE_SSL */
+#endif				/* OPENSSL_VERSION_NUMBER || ENABLE_CRYPTO_POLARSSL */
+#endif				/* ENABLE_SSL */
 #ifdef ENABLE_PKCS11
   "\n"
   "PKCS#11 Options:\n"
@@ -652,7 +652,7 @@ static const char usage_message[] =
   "--show-ciphers  : Show cipher algorithms to use with --cipher option.\n"
   "--show-digests  : Show message digest algorithms to use with --auth option.\n"
   "--show-engines  : Show hardware crypto accelerator engines (if available).\n"
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   "--show-tls      : Show all TLS ciphers (TLS used only as a control channel).\n"
 #endif
 #ifdef WIN32
@@ -718,7 +718,7 @@ static const char usage_message[] =
   "--genkey        : Generate a random key to be used as a shared secret,\n"
   "                  for use with the --secret option.\n"
   "--secret file   : Write key to file.\n"
-#endif				/* USE_CRYPTO */
+#endif				/* ENABLE_CRYPTO */
 #ifdef TUNSETPERSIST
   "\n"
   "Tun/tap config mode (available with linux 2.4+):\n"
@@ -819,7 +819,7 @@ init_options (struct options *o, const bool init_gc)
   o->scheduled_exit_interval = 5;
   o->server_poll_timeout = 0;
 #endif
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   o->ciphername = "BF-CBC";
   o->ciphername_defined = true;
   o->authname = "SHA1";
@@ -831,7 +831,7 @@ init_options (struct options *o, const bool init_gc)
   o->replay_time = DEFAULT_TIME_BACKTRACK;
   o->use_iv = true;
   o->key_direction = KEY_DIRECTION_BIDIRECTIONAL;
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   o->key_method = 2;
   o->tls_timeout = 2;
   o->renegotiate_seconds = 3600;
@@ -840,8 +840,8 @@ init_options (struct options *o, const bool init_gc)
 #ifdef ENABLE_X509ALTUSERNAME
   o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
 #endif
-#endif /* USE_SSL */
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_SSL */
+#endif /* ENABLE_CRYPTO */
 #ifdef ENABLE_PKCS11
   o->pkcs11_pin_cache_period = -1;
 #endif			/* ENABLE_PKCS11 */
@@ -1050,7 +1050,7 @@ is_stateful_restart (const struct options *o)
   return is_persist_option (o) || connection_list_defined (o);
 }
 
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
 static uint8_t *
 parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_arena *gc)
 {
@@ -1419,12 +1419,12 @@ show_settings (const struct options *o)
   SHOW_INT (persist_mode);
 #endif
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   SHOW_BOOL (show_ciphers);
   SHOW_BOOL (show_digests);
   SHOW_BOOL (show_engines);
   SHOW_BOOL (genkey);
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   SHOW_STR (key_pass_file);
   SHOW_BOOL (show_tls_ciphers);
 #endif
@@ -1555,7 +1555,7 @@ show_settings (const struct options *o)
     plugin_option_list_print (o->plugin_list, D_SHOW_PARMS);
 #endif
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   SHOW_STR (shared_secret_file);
   SHOW_INT (key_direction);
   SHOW_BOOL (ciphername_defined);
@@ -1565,9 +1565,9 @@ show_settings (const struct options *o)
   SHOW_STR (prng_hash);
   SHOW_INT (prng_nonce_secret_len);
   SHOW_INT (keysize);
-#ifndef USE_POLARSSL
+#ifndef ENABLE_CRYPTO_POLARSSL
   SHOW_BOOL (engine);
-#endif /* USE_POLARSSL */
+#endif /* ENABLE_CRYPTO_POLARSSL */
   SHOW_BOOL (replay);
   SHOW_BOOL (mute_replay_warnings);
   SHOW_INT (replay_window);
@@ -1576,7 +1576,7 @@ show_settings (const struct options *o)
   SHOW_BOOL (use_iv);
   SHOW_BOOL (test_crypto);
 
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   SHOW_BOOL (tls_server);
   SHOW_BOOL (tls_client);
   SHOW_INT (key_method);
@@ -1585,7 +1585,7 @@ show_settings (const struct options *o)
   SHOW_STR (dh_file);
   SHOW_STR (cert_file);
   SHOW_STR (priv_key_file);
-#ifndef USE_POLARSSL
+#ifndef ENABLE_CRYPTO_POLARSSL
   SHOW_STR (pkcs12_file);
 #endif
 #ifdef ENABLE_CRYPTOAPI
@@ -1892,7 +1892,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 
   init_options (&defaults, true);
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   if (options->test_crypto)
     {
       notnull (options->shared_secret_file, "key file (--secret)");
@@ -1930,7 +1930,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
     msg (M_USAGE, "--inetd nowait can only be used with --proto tcp-server");
 
   if (options->inetd == INETD_NOWAIT
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
       && !(options->tls_server || options->tls_client)
 #endif
       )
@@ -2218,7 +2218,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
     }
 #endif /* P2MP_SERVER */
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 
   /*
    * Check consistency of replay options
@@ -2237,7 +2237,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
    * SSL/TLS mode sanity checks.
    */
 
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   if (options->tls_server + options->tls_client +
       (options->shared_secret_file != NULL) > 1)
     msg (M_USAGE, "specify only one of --tls-server, --tls-client, or --secret");
@@ -2286,7 +2286,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 #endif
       if (options->pkcs12_file)
         {
-#ifdef USE_POLARSSL
+#ifdef ENABLE_CRYPTO_POLARSSL
 	  msg(M_USAGE, "Parameter --pkcs12 cannot be used with the PolarSSL version version of OpenVPN.");
 #else
           if (options->ca_path)
@@ -2299,7 +2299,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
         }
       else
         {
-#ifdef USE_POLARSSL
+#ifdef ENABLE_CRYPTO_POLARSSL
 	  if (!(options->ca_file))
 	    msg(M_USAGE, "You must define CA file (--ca)");
           if (options->ca_path)
@@ -2348,7 +2348,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       MUST_BE_UNDEF (dh_file);
       MUST_BE_UNDEF (cert_file);
       MUST_BE_UNDEF (priv_key_file);
-#ifndef USE_POLARSSL
+#ifndef ENABLE_CRYPTO_POLARSSL
       MUST_BE_UNDEF (pkcs12_file);
 #endif
       MUST_BE_UNDEF (cipher_list);
@@ -2383,8 +2383,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, err, "--pull");
     }
 #undef MUST_BE_UNDEF
-#endif /* USE_CRYPTO */
-#endif /* USE_SSL */
+#endif /* ENABLE_CRYPTO */
+#endif /* ENABLE_SSL */
 
 #if P2MP
   if (options->auth_user_pass_file && !options->pull)
@@ -2667,7 +2667,7 @@ options_postprocess_filechecks (struct options *options)
   bool errs = false;
 
   /* ** SSL/TLS/crypto related files ** */
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
   errs |= check_file_access (CHKACC_FILE, options->ca_path, R_OK, "--capath");
@@ -2688,20 +2688,20 @@ options_postprocess_filechecks (struct options *options)
 
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_auth_file, R_OK,
                              "--tls-auth");
-#endif /* USE_SSL */
-#ifdef USE_CRYPTO
+#endif /* ENABLE_SSL */
+#ifdef ENABLE_CRYPTO
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->shared_secret_file, R_OK,
                              "--secret");
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR,
                              options->packet_id_file, R_OK|W_OK, "--replay-persist");
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_CRYPTO */
 
 
   /* ** Password files ** */
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   errs |= check_file_access (CHKACC_FILE, options->key_pass_file, R_OK,
                              "--askpass");
-#endif /* USE_SSL */
+#endif /* ENABLE_SSL */
 #ifdef ENABLE_MANAGEMENT
   errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
                              options->management_user_pass, R_OK,
@@ -2726,10 +2726,10 @@ options_postprocess_filechecks (struct options *options)
                              R_OK|W_OK, "--status");
 
   /* ** Config related ** */
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   errs |= check_file_access (CHKACC_FILE, options->tls_export_cert,
                              R_OK|W_OK|X_OK, "--tls-export-cert");
-#endif /* USE_SSL */
+#endif /* ENABLE_SSL */
 #if P2MP_SERVER
   errs |= check_file_access (CHKACC_FILE, options->client_config_dir,
                              R_OK|X_OK, "--client-config-dir");
@@ -2968,9 +2968,9 @@ options_string (const struct options *o,
     buf_printf (&out, ",mtu-dynamic");
 #endif
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
 #define TLS_CLIENT (o->tls_client)
 #define TLS_SERVER (o->tls_server)
 #else
@@ -3014,7 +3014,7 @@ options_string (const struct options *o,
 	  buf_printf (&out, ",no-iv");
       }
 
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   /*
    * SSL Options
    */
@@ -3043,12 +3043,12 @@ options_string (const struct options *o,
 	  buf_printf (&out, ",tls-server");
       }
   }
-#endif /* USE_SSL */
+#endif /* ENABLE_SSL */
 
 #undef TLS_CLIENT
 #undef TLS_SERVER
 
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_CRYPTO */
 
   return BSTR (&out);
 }
@@ -3357,7 +3357,7 @@ usage (void)
   struct options o;
   init_options (&o, true);
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
   fprintf (fp, usage_message,
 	   title_string,
 	   o.ce.connect_retry_seconds,
@@ -3368,7 +3368,7 @@ usage (void)
            o.replay_window, o.replay_time,
 	   o.tls_timeout, o.renegotiate_seconds,
 	   o.handshake_window, o.transition_window);
-#elif defined(USE_CRYPTO)
+#elif defined(ENABLE_CRYPTO)
   fprintf (fp, usage_message,
 	   title_string,
 	   o.ce.connect_retry_seconds,
@@ -6211,7 +6211,7 @@ add_option (struct options *options,
       options->lzo &= ~LZO_ADAPTIVE;
     }
 #endif /* ENABLE_LZO */
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   else if (streq (p[0], "show-ciphers"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6383,7 +6383,7 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->test_crypto = true;
     }
-#ifndef USE_POLARSSL
+#ifndef ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "engine"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6394,7 +6394,7 @@ add_option (struct options *options,
       else
 	options->engine = "auto";
     }  
-#endif /* USE_POLARSSL */
+#endif /* ENABLE_CRYPTO_POLARSSL */
 #ifdef HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH
   else if (streq (p[0], "keysize") && p[1])
     {
@@ -6410,7 +6410,7 @@ add_option (struct options *options,
       options->keysize = keysize;
     }
 #endif
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   else if (streq (p[0], "show-tls"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6437,13 +6437,13 @@ add_option (struct options *options,
 	}
 #endif
     }
-#ifndef USE_POLARSSL
+#ifndef ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "capath") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->ca_path = p[1];
     }
-#endif /* USE_POLARSSL */
+#endif /* ENABLE_CRYPTO_POLARSSL */
   else if (streq (p[0], "dh") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6500,7 +6500,7 @@ add_option (struct options *options,
 	}
 #endif
     }
-#ifndef USE_POLARSSL
+#ifndef ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "pkcs12") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6512,7 +6512,7 @@ add_option (struct options *options,
 	}
 #endif
     }
-#endif /* USE_POLARSSL */
+#endif /* ENABLE_CRYPTO_POLARSSL */
   else if (streq (p[0], "askpass"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6574,7 +6574,7 @@ add_option (struct options *options,
       warn_multiple_script (options->tls_verify, "tls-verify");
       options->tls_verify = string_substitute (p[1], ',', ' ', &options->gc);
     }
-#ifndef USE_POLARSSL
+#ifndef ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "tls-export-cert") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6599,7 +6599,7 @@ add_option (struct options *options,
 	  goto err;
 	}
     }
-#if OPENSSL_VERSION_NUMBER >= 0x00907000L || USE_POLARSSL
+#if OPENSSL_VERSION_NUMBER >= 0x00907000L || ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "remote-cert-ku"))
     {
       int j;
@@ -6716,8 +6716,8 @@ add_option (struct options *options,
       options->x509_username_field = p[1];
     }
 #endif /* ENABLE_X509ALTUSERNAME */
-#endif /* USE_SSL */
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_SSL */
+#endif /* ENABLE_CRYPTO */
 #ifdef ENABLE_PKCS11
   else if (streq (p[0], "show-pkcs11-ids") && p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 87fea48..4e5b7a4 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -80,7 +80,7 @@ struct options_pre_pull
 };
 
 #endif
-#if defined(USE_CRYPTO) && !defined(USE_OPENSSL) && !defined(USE_POLARSSL)
+#if defined(ENABLE_CRYPTO) && !defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_POLARSSL)
 # error "At least one of OpenSSL or PolarSSL needs to be defined."
 #endif
 
@@ -211,12 +211,12 @@ struct options
   bool persist_config;
   int persist_mode;
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   const char *key_pass_file;
   bool show_ciphers;
   bool show_digests;
   bool show_engines;
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   bool show_tls_ciphers;
 #endif
   bool genkey;
@@ -498,7 +498,7 @@ struct options
 #endif
 #endif
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
   /* Cipher parms */
   const char *shared_secret_file;
 #if ENABLE_INLINE_FILES
@@ -521,7 +521,7 @@ struct options
   bool use_iv;
   bool test_crypto;
 
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
   /* TLS (control channel) parms */
   bool tls_server;
   bool tls_client;
@@ -605,8 +605,8 @@ struct options
 
   bool tls_exit;
 
-#endif /* USE_SSL */
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_SSL */
+#endif /* ENABLE_CRYPTO */
 
 #ifdef ENABLE_X509_TRACK
   const struct x509_track *x509_track;
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index ba8973a..fceead9 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -33,7 +33,7 @@
 
 #include "syshead.h"
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 
 #include "packet_id.h"
 #include "misc.h"
@@ -593,4 +593,4 @@ packet_id_interactive_test ()
 }
 #endif
 
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_CRYPTO */
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 7f4be8a..3ddaab6 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -28,7 +28,7 @@
  * attempts to replay them back later.
  */
 
-#ifdef USE_CRYPTO
+#ifdef ENABLE_CRYPTO
 
 #ifndef PACKET_ID_H
 #define PACKET_ID_H
@@ -335,4 +335,4 @@ packet_id_reap_test (struct packet_id_rec *p)
 }
 
 #endif /* PACKET_ID_H */
-#endif /* USE_CRYPTO */
+#endif /* ENABLE_CRYPTO */
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index aa1eccc..4a14b7c 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -29,7 +29,7 @@
 
 #include "syshead.h"
 
-#if defined(ENABLE_PKCS11) && defined(USE_OPENSSL)
+#if defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_OPENSSL)
 
 #include "errlevel.h"
 #include "pkcs11_backend.h"
diff --git a/src/openvpn/pkcs11_polarssl.c b/src/openvpn/pkcs11_polarssl.c
index 0f9daab..349c312 100644
--- a/src/openvpn/pkcs11_polarssl.c
+++ b/src/openvpn/pkcs11_polarssl.c
@@ -29,7 +29,7 @@
 
 #include "syshead.h"
 
-#if defined(ENABLE_PKCS11) && defined(USE_POLARSSL)
+#if defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_POLARSSL)
 
 #include "errlevel.h"
 #include "pkcs11_backend.h"
@@ -117,4 +117,4 @@ cleanup:
 
   return ret;
 }
-#endif /* defined(ENABLE_PKCS11) && defined(USE_POLARSSL) */
+#endif /* defined(ENABLE_PKCS11) && defined(ENABLE_CRYPTO_POLARSSL) */
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 3f379dd..a975161 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -351,9 +351,9 @@ plugin_call_item (const struct plugin *p,
 		  const struct argv *av,
 		  struct openvpn_plugin_string_list **retlist,
 		  const char **envp
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
 		  , int certdepth,
-		  x509_cert_t *current_cert
+		  openvpn_x509_cert_t *current_cert
 #endif
 		 )
 {
@@ -380,7 +380,7 @@ plugin_call_item (const struct plugin *p,
                                                     (const char ** const) envp,
                                                     p->plugin_handle,
                                                     per_client_context,
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
 						    (current_cert ? certdepth : -1),
 						    current_cert
 #else
@@ -590,9 +590,9 @@ plugin_call_ssl (const struct plugin_list *pl,
 	     const struct argv *av,
 	     struct plugin_return *pr,
 	     struct env_set *es
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
              , int certdepth,
-	     x509_cert_t *current_cert
+	     openvpn_x509_cert_t *current_cert
 #endif
 	    )
 {
@@ -620,7 +620,7 @@ plugin_call_ssl (const struct plugin_list *pl,
 					       av,
 					       pr ? &pr->list[i] : NULL,
 					       envp
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
 					       ,certdepth,
 					       current_cert
 #endif
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 4c0a1fd..4ba150d 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -29,10 +29,10 @@
 #ifndef OPENVPN_PLUGIN_H
 #define OPENVPN_PLUGIN_H
 
-#ifdef USE_OPENSSL
+#ifdef ENABLE_CRYPTO_OPENSSL
 #include "ssl_verify_openssl.h"
 #endif
-#ifdef USE_POLARSSL
+#ifdef ENABLE_CRYPTO_POLARSSL
 #include "ssl_verify_polarssl.h"
 #endif
 #include "openvpn-plugin.h"
@@ -127,9 +127,9 @@ int plugin_call_ssl (const struct plugin_list *pl,
 		 const struct argv *av,
 		 struct plugin_return *pr,
 		 struct env_set *es
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
 		 , int current_cert_depth,
-		 x509_cert_t *current_cert
+		 openvpn_x509_cert_t *current_cert
 #endif
 		);
 
@@ -183,9 +183,9 @@ plugin_call_ssl (const struct plugin_list *pl,
 	     const struct argv *av,
 	     struct plugin_return *pr,
 	     struct env_set *es
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
 	     , int current_cert_depth,
-	     x509_cert_t *current_cert
+	     openvpn_x509_cert_t *current_cert
 #endif
 	    )
 {
@@ -202,7 +202,7 @@ plugin_call(const struct plugin_list *pl,
 	struct env_set *es)
 {
   return plugin_call_ssl(pl, type, av, pr, es
-#ifdef USE_SSL
+#ifdef ENABLE_SSL
       , -1, NULL
 #endif
       );
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 1f238cc..7c0bb54 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -29,7 +29,7 @@
 
 #include "syshead.h"
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
 
 #include "buffer.h"
 #include "error.h"
@@ -748,4 +748,4 @@ reliable_debug_print (const struct reliable *rel, char *desc)
 
 #else
 static void dummy(void) {}
-#endif /* USE_CRYPTO && USE_SSL*/
+#endif /* ENABLE_CRYPTO && ENABLE_SSL*/
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 086761f..594ab82 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -29,7 +29,7 @@
  */
 
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
 
 #ifndef RELIABLE_H
 #define RELIABLE_H
@@ -477,4 +477,4 @@ void reliable_ack_debug_print (const struct reliable_ack *ack, char *desc);
 
 
 #endif /* RELIABLE_H */
-#endif /* USE_CRYPTO && USE_SSL */
+#endif /* ENABLE_CRYPTO && ENABLE_SSL */
diff --git a/src/openvpn/session_id.c b/src/openvpn/session_id.c
index 95fa5f7..7caf105 100644
--- a/src/openvpn/session_id.c
+++ b/src/openvpn/session_id.c
@@ -33,7 +33,7 @@
 
 #include "syshead.h"
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
 
 #include "error.h"
 #include "common.h"
@@ -58,4 +58,4 @@ session_id_print (const struct session_id *sid, struct gc_arena *gc)
 
 #else
 static void dummy(void) {}
-#endif /* USE_CRYPTO && USE_SSL*/
+#endif /* ENABLE_CRYPTO && ENABLE_SSL*/
diff --git a/src/openvpn/session_id.h b/src/openvpn/session_id.h
index 10f30ed..33909dd 100644
--- a/src/openvpn/session_id.h
+++ b/src/openvpn/session_id.h
@@ -30,7 +30,7 @@
  * negotiated).
  */
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
 
 #ifndef SESSION_ID_H
 #define SESSION_ID_H
@@ -83,4 +83,4 @@ void session_id_random (struct session_id *sid);
 const char *session_id_print (const struct session_id *sid, struct gc_arena *gc);
 
 #endif /* SESSION_ID_H */
-#endif /* USE_CRYPTO && USE_SSL */
+#endif /* ENABLE_CRYPTO && ENABLE_SSL */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index ba06ff7..caafd18 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -41,7 +41,7 @@
 
 #include "syshead.h"
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
 
 #include "error.h"
 #include "common.h"
@@ -342,7 +342,7 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
 #ifdef MANAGMENT_EXTERNAL_KEY
   else if ((options->management_flags & MF_EXTERNAL_KEY) && options->cert_file)
     {
-      x509_cert_t *my_cert = NULL;
+      openvpn_x509_cert_t *my_cert = NULL;
       tls_ctx_load_cert_file(new_ctx, options->cert_file, options->cert_file_inline,
 	  &my_cert);
       tls_ctx_use_external_private_key(new_ctx, my_cert);
@@ -3370,4 +3370,4 @@ done:
 
 #else
 static void dummy(void) {}
-#endif /* USE_CRYPTO && USE_SSL*/
+#endif /* ENABLE_CRYPTO && ENABLE_SSL*/
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index aa6abc7..cd7cae2 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -30,7 +30,7 @@
 #ifndef OPENVPN_SSL_H
 #define OPENVPN_SSL_H
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
 
 #include "basic.h"
 #include "common.h"
@@ -502,6 +502,6 @@ void show_tls_performance_stats(void);
 /*#define EXTRACT_X509_FIELD_TEST*/
 void extract_x509_field_test (void);
 
-#endif /* USE_CRYPTO && USE_SSL */
+#endif /* ENABLE_CRYPTO && ENABLE_SSL */
 
 #endif
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 243c9e3..5ea6a06 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -33,11 +33,11 @@
 
 #include "buffer.h"
 
-#ifdef USE_OPENSSL
+#ifdef ENABLE_CRYPTO_OPENSSL
 #include "ssl_openssl.h"
 #include "ssl_verify_openssl.h"
 #endif
-#ifdef USE_POLARSSL
+#ifdef ENABLE_CRYPTO_POLARSSL
 #include "ssl_polarssl.h"
 #include "ssl_verify_polarssl.h"
 #endif
@@ -193,7 +193,7 @@ void tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
 #if ENABLE_INLINE_FILES
     const char *cert_file_inline,
 #endif
-    x509_cert_t **x509
+    openvpn_x509_cert_t **x509
     );
 
 /**
@@ -201,7 +201,7 @@ void tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
  *
  * @param x509			certificate to free
  */
-void tls_ctx_free_cert_file (x509_cert_t *x509);
+void tls_ctx_free_cert_file (openvpn_x509_cert_t *x509);
 
 /**
  * Load private key file into the given TLS context.
@@ -233,7 +233,7 @@ int tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file
  * @return 			1 if an error occurred, 0 if parsing was
  * 				successful.
  */
-int tls_ctx_use_external_private_key (struct tls_root_ctx *ctx, x509_cert_t *cert);
+int tls_ctx_use_external_private_key (struct tls_root_ctx *ctx, openvpn_x509_cert_t *cert);
 
 #endif
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 1267e6b..9a0c4d0 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -29,7 +29,7 @@
 
 #include "syshead.h"
 
-#if defined(USE_SSL) && defined(USE_OPENSSL)
+#if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL)
 
 #include "errlevel.h"
 #include "buffer.h"
@@ -1020,13 +1020,13 @@ key_state_write_plaintext (struct key_state_ssl *ks_ssl, struct buffer *buf)
   int ret = 0;
   perf_push (PERF_BIO_WRITE_PLAINTEXT);
 
-#ifdef USE_OPENSSL
+#ifdef ENABLE_CRYPTO_OPENSSL
   ASSERT (NULL != ks_ssl);
 
   ret = bio_write (ks_ssl->ssl_bio, BPTR(buf), BLEN(buf),
       "tls_write_plaintext");
   bio_write_post (ret, buf);
-#endif /* USE_OPENSSL */
+#endif /* ENABLE_CRYPTO_OPENSSL */
 
   perf_pop ();
   return ret;
@@ -1187,4 +1187,4 @@ get_highest_preference_tls_cipher (char *buf, int size)
   SSL_CTX_free (ctx);
 }
 
-#endif /* defined(USE_SSL) && defined(USE_OPENSSL) */
+#endif /* defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL) */
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index c50cf0a..e5bd8ca 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -29,7 +29,7 @@
 
 #include "syshead.h"
 
-#if defined(USE_SSL) && defined(USE_POLARSSL)
+#if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL)
 
 #include "errlevel.h"
 #include "ssl_backend.h"
@@ -243,7 +243,7 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
 #if ENABLE_INLINE_FILES
     const char *cert_file_inline,
 #endif
-    x509_cert_t **x509
+    openvpn_x509_cert_t **x509
     )
 {
   ASSERT(NULL != ctx);
@@ -270,7 +270,7 @@ tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
 }
 
 void
-tls_ctx_free_cert_file (x509_cert_t *x509)
+tls_ctx_free_cert_file (openvpn_x509_cert_t *x509)
 {
   x509_free(x509);
 }
@@ -332,7 +332,7 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file
 #ifdef MANAGMENT_EXTERNAL_KEY
 
 int
-tls_ctx_use_external_private_key (struct tls_root_ctx *ctx, x509_cert_t *cert)
+tls_ctx_use_external_private_key (struct tls_root_ctx *ctx, openvpn_x509_cert_t *cert)
 {
   msg(M_FATAL, "Use of management external keys not yet supported for PolarSSL.");
   return false;
@@ -863,4 +863,4 @@ get_highest_preference_tls_cipher (char *buf, int size)
   strncpynt (buf, cipher_name, size);
 }
 
-#endif /* defined(USE_SSL) && defined(USE_POLARSSL) */
+#endif /* defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL) */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index a7b361f..0fa1137 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -29,14 +29,14 @@
 
 #include "syshead.h"
 
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
 
 #include "misc.h"
 #include "manage.h"
 #include "ssl_verify.h"
 #include "ssl_verify_backend.h"
 
-#ifdef USE_OPENSSL
+#ifdef ENABLE_CRYPTO_OPENSSL
 #include "ssl_verify_openssl.h"
 #endif
 
@@ -296,7 +296,7 @@ print_nsCertType (int type)
  * @param subject the peer's extracted common name
  */
 static result_t
-verify_peer_cert(const struct tls_options *opt, x509_cert_t *peer_cert,
+verify_peer_cert(const struct tls_options *opt, openvpn_x509_cert_t *peer_cert,
     const char *subject, const char *common_name)
 {
   /* verify certificate nsCertType */
@@ -315,7 +315,7 @@ verify_peer_cert(const struct tls_options *opt, x509_cert_t *peer_cert,
 	}
     }
 
-#if OPENSSL_VERSION_NUMBER >= 0x00907000L || USE_POLARSSL
+#if OPENSSL_VERSION_NUMBER >= 0x00907000L || ENABLE_CRYPTO_POLARSSL
 
   /* verify certificate ku */
   if (opt->remote_cert_ku[0] != 0)
@@ -369,7 +369,7 @@ verify_peer_cert(const struct tls_options *opt, x509_cert_t *peer_cert,
  * environment for later verification by scripts and plugins.
  */
 static void
-verify_cert_set_env(struct env_set *es, x509_cert_t *peer_cert, int cert_depth,
+verify_cert_set_env(struct env_set *es, openvpn_x509_cert_t *peer_cert, int cert_depth,
     const char *subject, const char *common_name
 #ifdef ENABLE_X509_TRACK
     , const struct x509_track *x509_track
@@ -425,7 +425,7 @@ verify_cert_set_env(struct env_set *es, x509_cert_t *peer_cert, int cert_depth,
  */
 static result_t
 verify_cert_call_plugin(const struct plugin_list *plugins, struct env_set *es,
-    int cert_depth, x509_cert_t *cert, char *subject)
+    int cert_depth, openvpn_x509_cert_t *cert, char *subject)
 {
   if (plugin_defined (plugins, OPENVPN_PLUGIN_TLS_VERIFY))
     {
@@ -454,7 +454,7 @@ verify_cert_call_plugin(const struct plugin_list *plugins, struct env_set *es,
 }
 
 static const char *
-verify_cert_export_cert(x509_cert_t *peercert, const char *tmp_dir, struct gc_arena *gc)
+verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, struct gc_arena *gc)
 {
   FILE *peercert_file;
   const char *peercert_filename="";
@@ -486,7 +486,7 @@ verify_cert_export_cert(x509_cert_t *peercert, const char *tmp_dir, struct gc_ar
  */
 static result_t
 verify_cert_call_command(const char *verify_command, struct env_set *es,
-    int cert_depth, x509_cert_t *cert, char *subject, const char *verify_export_cert)
+    int cert_depth, openvpn_x509_cert_t *cert, char *subject, const char *verify_export_cert)
 {
   const char *tmp_file = NULL;
   int ret;
@@ -533,7 +533,7 @@ verify_cert_call_command(const char *verify_command, struct env_set *es,
  * check peer cert against CRL directory
  */
 static result_t
-verify_check_crl_dir(const char *crl_dir, x509_cert_t *cert)
+verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert)
 {
   char fn[256];
   int fd;
@@ -560,7 +560,7 @@ verify_check_crl_dir(const char *crl_dir, x509_cert_t *cert)
 }
 
 result_t
-verify_cert(struct tls_session *session, x509_cert_t *cert, int cert_depth)
+verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_depth)
 {
   char *subject = NULL;
   char common_name[TLS_USERNAME_LEN] = {0};
@@ -1215,4 +1215,4 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
       gc_free (&gc);
     }
 }
-#endif /* defined(USE_CRYPTO) && defined(USE_SSL) */
+#endif /* defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) */
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 1809137..1d20152 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -36,10 +36,10 @@
 #include "ssl_common.h"
 
 /* Include OpenSSL-specific code */
-#ifdef USE_OPENSSL
+#ifdef ENABLE_CRYPTO_OPENSSL
 #include "ssl_verify_openssl.h"
 #endif
-#ifdef USE_POLARSSL
+#ifdef ENABLE_CRYPTO_POLARSSL
 #include "ssl_verify_polarssl.h"
 #endif
 
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 2ba3723..cc67cb9 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -55,7 +55,7 @@ typedef enum { SUCCESS=0, FAILURE=1 } result_t;
  *
  * @return 		\c SUCCESS if verification was successful, \c FAILURE on failure.
  */
-result_t verify_cert(struct tls_session *session, x509_cert_t *cert, int cert_depth);
+result_t verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_depth);
 
 /*
  * Remember the given certificate hash, allowing the certificate chain to be
@@ -86,7 +86,7 @@ void cert_hash_remember (struct tls_session *session, const int cert_depth,
  *
  * @return 		a string containing the subject
  */
-char *x509_get_subject (x509_cert_t *cert);
+char *x509_get_subject (openvpn_x509_cert_t *cert);
 
 /*
  * Free a subject string as returned by \c verify_get_subject()
@@ -103,7 +103,7 @@ void x509_free_subject (char *subject);
  *
  * @return 		a string containing the SHA1 hash of the certificate
  */
-unsigned char *x509_get_sha1_hash (x509_cert_t *cert);
+unsigned char *x509_get_sha1_hash (openvpn_x509_cert_t *cert);
 
 /*
  * Free a hash as returned by \c verify_get_hash()
@@ -126,7 +126,7 @@ void x509_free_sha1_hash (unsigned char *hash);
  * @return 		\c FAILURE, \c or SUCCESS
  */
 result_t x509_get_username (char *common_name, int cn_len,
-    char * x509_username_field, x509_cert_t *peer_cert);
+    char * x509_username_field, openvpn_x509_cert_t *peer_cert);
 
 /*
  * Return the certificate's serial number.
@@ -138,7 +138,7 @@ result_t x509_get_username (char *common_name, int cn_len,
  *
  * @return 		The certificate's serial number.
  */
-char *x509_get_serial (x509_cert_t *cert);
+char *x509_get_serial (openvpn_x509_cert_t *cert);
 
 /*
  * Free a serial number string as returned by \c verify_get_serial()
@@ -156,7 +156,7 @@ void x509_free_serial (char *serial);
  * @param cert_depth	Depth of the certificate
  * @param cert		Certificate to set the environment for
  */
-void x509_setenv (struct env_set *es, int cert_depth, x509_cert_t *cert);
+void x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert);
 
 #ifdef ENABLE_X509_TRACK
 
@@ -195,7 +195,7 @@ void x509_track_add (const struct x509_track **ll_head, const char *name,
  * @param cert		Certificate to set the environment for
  */
 void x509_setenv_track (const struct x509_track *xt, struct env_set *es,
-    const int depth, x509_cert_t *x509);
+    const int depth, openvpn_x509_cert_t *x509);
 
 #endif
 
@@ -210,9 +210,9 @@ void x509_setenv_track (const struct x509_track *xt, struct env_set *es,
  * 			the expected bit set. \c FAILURE if the certificate does
  * 			not have NS cert type verification or the wrong bit set.
  */
-result_t x509_verify_ns_cert_type(const x509_cert_t *cert, const int usage);
+result_t x509_verify_ns_cert_type(const openvpn_x509_cert_t *cert, const int usage);
 
-#if OPENSSL_VERSION_NUMBER >= 0x00907000L || USE_POLARSSL
+#if OPENSSL_VERSION_NUMBER >= 0x00907000L || ENABLE_CRYPTO_POLARSSL
 
 /*
  * Verify X.509 key usage extension field.
@@ -224,7 +224,7 @@ result_t x509_verify_ns_cert_type(const x509_cert_t *cert, const int usage);
  * @return 		\c SUCCESS if one of the key usage values matches, \c FAILURE
  * 			if key usage is not enabled, or the values do not match.
  */
-result_t x509_verify_cert_ku (x509_cert_t *x509, const unsigned * const expected_ku,
+result_t x509_verify_cert_ku (openvpn_x509_cert_t *x509, const unsigned * const expected_ku,
     int expected_len);
 
 /*
@@ -240,7 +240,7 @@ result_t x509_verify_cert_ku (x509_cert_t *x509, const unsigned * const expected
  * 			extended key usage fields, \c FAILURE if extended key
  * 			usage is not enabled, or the values do not match.
  */
-result_t x509_verify_cert_eku (x509_cert_t *x509, const char * const expected_oid);
+result_t x509_verify_cert_eku (openvpn_x509_cert_t *x509, const char * const expected_oid);
 
 #endif
 
@@ -253,7 +253,7 @@ result_t x509_verify_cert_eku (x509_cert_t *x509, const char * const expected_oi
  *
  *
  */
-result_t x509_write_pem(FILE *peercert_file, x509_cert_t *peercert);
+result_t x509_write_pem(FILE *peercert_file, openvpn_x509_cert_t *peercert);
 
 /*
  * Check the certificate against a CRL file.
@@ -266,7 +266,7 @@ result_t x509_write_pem(FILE *peercert_file, x509_cert_t *peercert);
  * 			certificate or does not contain an entry for it.
  * 			\c FAILURE otherwise.
  */
-result_t x509_verify_crl(const char *crl_file, x509_cert_t *cert,
+result_t x509_verify_crl(const char *crl_file, openvpn_x509_cert_t *cert,
     const char *subject);
 
 #endif /* SSL_VERIFY_BACKEND_H_ */
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 200a570..e647c2a 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -29,7 +29,7 @@
 
 #include "syshead.h"
 
-#if defined(USE_SSL) && defined(USE_OPENSSL)
+#if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL)
 
 #include "ssl_verify.h"
 #include "ssl_verify_backend.h"
@@ -210,7 +210,7 @@ x509_get_username (char *common_name, int cn_len,
 }
 
 char *
-x509_get_serial (x509_cert_t *cert)
+x509_get_serial (openvpn_x509_cert_t *cert)
 {
   ASN1_INTEGER *asn1_i;
   BIGNUM *bignum;
@@ -401,7 +401,7 @@ x509_setenv_track (const struct x509_track *xt, struct env_set *es, const int de
  *  X509_{cert_depth}_{name}={value}
  */
 void
-x509_setenv (struct env_set *es, int cert_depth, x509_cert_t *peer_cert)
+x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *peer_cert)
 {
   int i, n;
   int fn_nid;
@@ -449,7 +449,7 @@ x509_setenv (struct env_set *es, int cert_depth, x509_cert_t *peer_cert)
 }
 
 result_t
-x509_verify_ns_cert_type(const x509_cert_t *peer_cert, const int usage)
+x509_verify_ns_cert_type(const openvpn_x509_cert_t *peer_cert, const int usage)
 {
   if (usage == NS_CERT_CHECK_NONE)
     return SUCCESS;
@@ -623,4 +623,4 @@ end:
   return retval;
 }
 
-#endif /* defined(USE_SSL) && defined(USE_OPENSSL) */
+#endif /* defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL) */
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
index 9c76d34..afd6110 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -32,7 +32,11 @@
 #define SSL_VERIFY_OPENSSL_H_
 
 #include <openssl/x509.h>
-typedef X509 x509_cert_t;
+
+#ifndef __OPENVPN_X509_CERT_T_DECLARED
+#define __OPENVPN_X509_CERT_T_DECLARED
+typedef X509 openvpn_x509_cert_t;
+#endif
 
 /** @name Function for authenticating a new connection from a remote OpenVPN peer
  *  @{ */
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 699eb47..249e687 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -29,7 +29,7 @@
 
 #include "syshead.h"
 
-#if defined(USE_SSL) && defined(USE_POLARSSL)
+#if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL)
 
 #include "ssl_verify.h"
 #include <polarssl/sha1.h>
@@ -189,7 +189,7 @@ x509_free_subject (char *subject)
  * X509_{cert_depth}_{name}={value}
  */
 void
-x509_setenv (struct env_set *es, int cert_depth, x509_cert_t *cert)
+x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *cert)
 {
   int i;
   unsigned char c;
@@ -422,4 +422,4 @@ end:
   return retval;
 }
 
-#endif /* #if defined(USE_SSL) && defined(USE_POLARSSL) */
+#endif /* #if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL) */
diff --git a/src/openvpn/ssl_verify_polarssl.h b/src/openvpn/ssl_verify_polarssl.h
index cd7eb75..fceee66 100644
--- a/src/openvpn/ssl_verify_polarssl.h
+++ b/src/openvpn/ssl_verify_polarssl.h
@@ -35,7 +35,10 @@
 #include "manage.h"
 #include <polarssl/x509.h>
 
-typedef x509_cert x509_cert_t;
+#ifndef __OPENVPN_X509_CERT_T_DECLARED
+#define __OPENVPN_X509_CERT_T_DECLARED
+typedef x509_cert openvpn_x509_cert_t;
+#endif
 
 /** @name Function for authenticating a new connection from a remote OpenVPN peer
  *  @{ */
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index a396b3c..cdcfbda 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -479,7 +479,7 @@ socket_defined (const socket_descriptor_t sd)
  * Do we have point-to-multipoint capability?
  */
 
-#if defined(ENABLE_CLIENT_SERVER) && defined(USE_CRYPTO) && defined(USE_SSL) && defined(HAVE_GETTIMEOFDAY)
+#if defined(ENABLE_CLIENT_SERVER) && defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) && defined(HAVE_GETTIMEOFDAY)
 #define P2MP 1
 #else
 #define P2MP 0
@@ -516,7 +516,7 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Enable external private key
  */
-#if defined(ENABLE_MANAGEMENT) && defined(USE_SSL) && !defined(USE_POLARSSL)
+#if defined(ENABLE_MANAGEMENT) && defined(ENABLE_SSL) && !defined(ENABLE_CRYPTO_POLARSSL)
 #define MANAGMENT_EXTERNAL_KEY
 #endif
 
@@ -565,7 +565,7 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Should we include NTLM proxy functionality
  */
-#if defined(USE_CRYPTO) && defined(ENABLE_HTTP_PROXY)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_HTTP_PROXY)
 #define NTLM 1
 #else
 #define NTLM 0
@@ -574,7 +574,7 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Should we include proxy digest auth functionality
  */
-#if defined(USE_CRYPTO) && defined(ENABLE_HTTP_PROXY)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_HTTP_PROXY)
 #define PROXY_DIGEST_AUTH 1
 #else
 #define PROXY_DIGEST_AUTH 0
@@ -590,14 +590,14 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Do we have CryptoAPI capability?
  */
-#if defined(WIN32) && defined(USE_CRYPTO) && defined(USE_SSL) && defined(USE_OPENSSL)
+#if defined(WIN32) && defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL)
 #define ENABLE_CRYPTOAPI
 #endif
 
 /*
  * Enable x509-track feature?
  */
-#if defined(USE_CRYPTO) && defined(USE_SSL) && defined (USE_OPENSSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) && defined (ENABLE_CRYPTO_OPENSSL)
 #define ENABLE_X509_TRACK
 #endif
 
@@ -688,7 +688,7 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Do we support pushing peer info?
  */
-#if defined(USE_CRYPTO) && defined(USE_SSL)
+#if defined(ENABLE_CRYPTO) && defined(ENABLE_SSL)
 #define ENABLE_PUSH_PEER_INFO
 #endif
 
diff --git a/src/plugins/examples/log_v3.c b/src/plugins/examples/log_v3.c
index 187c592..742c756 100644
--- a/src/plugins/examples/log_v3.c
+++ b/src/plugins/examples/log_v3.c
@@ -36,9 +36,7 @@
 #include <string.h>
 #include <stdlib.h>
 
-#define USE_SSL
-#define USE_OPENSSL
-#include "ssl_verify_openssl.h"
+#define ENABLE_SSL
 
 #include "openvpn-plugin.h"
 
-- 
1.7.3.4


