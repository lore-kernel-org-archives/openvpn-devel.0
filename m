From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:54:54 +0200
Message-ID: <1308909312-17824-2-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 10/28] Changed configure to accept
	--with-ssl-type=openssl
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 configure.ac |  153 ++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 84 insertions(+), 69 deletions(-)

diff --git a/configure.ac b/configure.ac
index a3789d9..5e7c10d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -75,13 +75,13 @@ AC_ARG_ENABLE(lzo-stub,
 )
 
 AC_ARG_ENABLE(crypto,
-   [  --disable-crypto        Disable OpenSSL crypto support],
+   [  --disable-crypto        Disable crypto support],
    [CRYPTO="$enableval"],
    [CRYPTO="yes"]
 )
 
 AC_ARG_ENABLE(ssl,
-   [  --disable-ssl           Disable OpenSSL SSL support for TLS-based key exchange],
+   [  --disable-ssl           Disable SSL support for TLS-based key exchange],
    [SSL="$enableval"],
    [SSL="yes"]
 )
@@ -296,6 +296,16 @@ AC_ARG_WITH(mem-check,
    [MEMCHECK="$withval"]
 )
 
+AC_ARG_WITH([ssl-type],
+   [  --with-ssl-type=TYPE  Build with the given SSL library, TYPE = openssl ],
+   [case "${withval}" in 
+        openssl) SSL_LIB=openssl ;;
+        *) AC_MSG_ERROR([bad value ${withval} for --with-ssl-type]) ;;
+   esac],
+   [SSL_LIB="openssl"]
+)
+AM_CONDITIONAL([USE_OPENSSL], [test x$SSL_LIB = xopenssl])
+
 dnl fix search path, to allow compilers to find syshead.h
 CPPFLAGS="$CPPFLAGS -I${srcdir}"
 
@@ -309,7 +319,7 @@ case "$host" in
 *-*-linux*)
 	AC_DEFINE(TARGET_LINUX, 1, [Are we running on Linux?])
 	dnl RH9 SSL headers workaround
-        if test -z $CS_HDR_DIR && test "$CRYPTO" = "yes"; then
+	    if test -z $CS_HDR_DIR && test "$CRYPTO" = "yes"; then
            CPPFLAGS="$CPPFLAGS $(pkg-config --cflags openssl 2>/dev/null)"
         fi
 	;;
@@ -708,80 +718,84 @@ if test "$LZO_STUB" = "yes"; then
 fi
 
 dnl
-dnl check for OpenSSL-crypto library
+dnl check for SSL-crypto library
 dnl
 
 if test "$CRYPTO" = "yes"; then
-   AC_CHECKING([for OpenSSL Crypto Library and Header files])
-   AC_CHECK_HEADER(openssl/evp.h,,
-	[AC_MSG_ERROR([OpenSSL Crypto headers not found.])])
-
-   for lib in crypto eay32; do
-      AC_CHECK_LIB($lib, EVP_CIPHER_CTX_init,
-            [
-		cryptofound=1
-		OPENVPN_ADD_LIBS(-l$lib)
-	    ]
-      )
-   done
-
-   test -n "$cryptofound" || AC_MSG_ERROR([OpenSSL Crypto library not found.])
-
-   AC_MSG_CHECKING([that OpenSSL Library is at least version 0.9.6])
-   AC_EGREP_CPP(yes,
-     [
-       #include <openssl/evp.h>
-       #if SSLEAY_VERSION_NUMBER >= 0x00906000L
-	 yes
-       #endif
-     ],
-     [
-       AC_MSG_RESULT([yes])
-       AC_DEFINE(USE_CRYPTO, 1, [Use OpenSSL crypto library])
-       AC_CHECK_FUNCS(EVP_CIPHER_CTX_set_key_length)
-
-       dnl check for OpenSSL crypto acceleration capability
-       AC_CHECK_HEADERS(openssl/engine.h)
-       AC_CHECK_FUNCS(ENGINE_load_builtin_engines)
-       AC_CHECK_FUNCS(ENGINE_register_all_complete)
-       AC_CHECK_FUNCS(ENGINE_cleanup)
-     ],
-     [AC_MSG_ERROR([OpenSSL crypto Library is too old.])]
-   )
+   if test "$SSL_LIB" = "openssl"; then  
+       AC_CHECKING([for OpenSSL Crypto Library and Header files])
+       AC_CHECK_HEADER(openssl/evp.h,,
+	       [AC_MSG_ERROR([OpenSSL Crypto headers not found.])])
+
+       for lib in crypto eay32; do
+          AC_CHECK_LIB($lib, EVP_CIPHER_CTX_init,
+                [
+            		cryptofound=1
+            		OPENVPN_ADD_LIBS(-l$lib)
+    	        ]
+          )
+       done
+       test -n "$cryptofound" || AC_MSG_ERROR([OpenSSL Crypto library not found.])
+
+       AC_MSG_CHECKING([that OpenSSL Library is at least version 0.9.6])
+       AC_EGREP_CPP(yes,
+         [
+           #include <openssl/evp.h>
+           #if SSLEAY_VERSION_NUMBER >= 0x00906000L
+    	       yes
+           #endif
+         ],
+         [
+           AC_MSG_RESULT([yes])
+           AC_DEFINE(USE_CRYPTO, 1, [Use crypto library])
+           AC_DEFINE(USE_OPENSSL, 1, [Use OpenSSL library])
+           AC_CHECK_FUNCS(EVP_CIPHER_CTX_set_key_length)
+    
+           dnl check for OpenSSL crypto acceleration capability
+           AC_CHECK_HEADERS(openssl/engine.h)
+           AC_CHECK_FUNCS(ENGINE_load_builtin_engines)
+           AC_CHECK_FUNCS(ENGINE_register_all_complete)
+           AC_CHECK_FUNCS(ENGINE_cleanup)
+         ],
+         [AC_MSG_ERROR([OpenSSL crypto Library is too old.])]
+       )
+   fi
 
-dnl
-dnl check for OpenSSL-SSL library
-dnl
+   dnl
+   dnl check for OpenSSL-SSL library
+   dnl
 
    if test "$SSL" = "yes"; then
-      AC_CHECKING([for OpenSSL SSL Library and Header files])
-      AC_CHECK_HEADER(openssl/ssl.h,,
-	   [AC_MSG_ERROR([OpenSSL SSL headers not found.])]
-      )
-
-      for lib in ssl ssl32; do
-	  AC_CHECK_LIB($lib, SSL_CTX_new,
-		[
-			sslfound=1
-			OPENVPN_ADD_LIBS(-l$lib)
-		]
-	  )
-      done
-
-      test -n "${sslfound}" || AC_MSG_ERROR([OpenSSL SSL library not found.])
-
-      if test "$MEMCHECK" = "ssl"; then
-	     AC_CHECKING([for Memory Debugging Capabilities in OpenSSL Library])
-	     AC_CHECK_LIB(ssl, CRYPTO_mem_ctrl,
-		 [
-		     AC_DEFINE(CRYPTO_MDEBUG, 1, [Use memory debugging function in OpenSSL])
-		     AC_MSG_RESULT([NOTE: OpenSSL library must be compiled with CRYPTO_MDEBUG])
-		 ],
-		 [AC_MSG_ERROR([Memory Debugging function in OpenSSL library not found.])]
+      if test "$SSL_LIB" = "openssl"; then  
+         AC_CHECKING([for OpenSSL SSL Library and Header files])
+         AC_CHECK_HEADER(openssl/ssl.h,,
+	      [AC_MSG_ERROR([OpenSSL SSL headers not found.])]
+         )
+
+         for lib in ssl ssl32; do
+	     AC_CHECK_LIB($lib, SSL_CTX_new,
+		   [
+			   sslfound=1
+			   OPENVPN_ADD_LIBS(-l$lib)
+		   ]
 	     )
+         done
+
+         test -n "${sslfound}" || AC_MSG_ERROR([OpenSSL SSL library not found.])
+
+         if test "$MEMCHECK" = "ssl"; then
+	        AC_CHECKING([for Memory Debugging Capabilities in OpenSSL Library])
+	        AC_CHECK_LIB(ssl, CRYPTO_mem_ctrl,
+		    [
+		        AC_DEFINE(CRYPTO_MDEBUG, 1, [Use memory debugging function in OpenSSL])
+		        AC_MSG_RESULT([NOTE: OpenSSL library must be compiled with CRYPTO_MDEBUG])
+		    ],
+		    [AC_MSG_ERROR([Memory Debugging function in OpenSSL library not found.])]
+	        )
+         fi
+
+         AC_DEFINE(USE_SSL, 1, [Use OpenSSL SSL library])
       fi
-
-      AC_DEFINE(USE_SSL, 1, [Use OpenSSL SSL library])
    fi
 fi
 
@@ -791,6 +805,7 @@ if test "$X509ALTUSERNAME" = "yes"; then
 fi
 
 dnl enable pkcs11 capability
+
 if test "$PKCS11" = "yes"; then
    AC_CHECKING([for pkcs11-helper Library and Header files])
    AC_CHECK_HEADER(pkcs11-helper-1.0/pkcs11h-core.h,
-- 
1.7.4.1


