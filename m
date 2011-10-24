From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 24 Oct 2011 10:46:01 +0200
Message-ID: <1319445962-21686-2-git-send-email-dejong@...1435...>
In-Reply-To: <1319445962-21686-1-git-send-email-dejong@...1435...>
References: <1319445962-21686-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Fixed disabling crypto and SSL
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
 Makefile.am           |   23 ++++++++---------------
 configure.ac          |    2 --
 crypto_openssl.c      |    4 ++++
 crypto_polarssl.c     |    4 ++++
 options.h             |    2 +-
 pkcs11_openssl.c      |    4 ++--
 pkcs11_polarssl.c     |    4 ++--
 ssl_openssl.c         |    5 +++++
 ssl_polarssl.c        |    5 +++++
 ssl_verify.c          |    4 ++++
 ssl_verify_openssl.c  |    6 ++++++
 ssl_verify_polarssl.c |    6 ++++++
 12 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 3228798..075270f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -86,6 +86,8 @@ openvpn_SOURCES = \
 	common.h \
 	config-win32.h \
 	crypto.c crypto.h crypto_backend.h \
+	crypto_openssl.c crypto_openssl.h \
+	crypto_polarssl.c crypto_polarssl.h \
 	dhcp.c dhcp.h \
 	errlevel.h \
 	error.c error.h \
@@ -115,6 +117,8 @@ openvpn_SOURCES = \
         ntlm.c ntlm.h \
 	occ.c occ.h occ-inline.h \
 	pkcs11.c pkcs11.h pkcs11_backend.h \
+	pkcs11_openssl.c \
+	pkcs11_polarssl.c \
 	openvpn.c openvpn.h \
 	openvpn-plugin.h \
 	options.c options.h \
@@ -139,7 +143,11 @@ openvpn_SOURCES = \
 	socket.c socket.h \
 	socks.c socks.h \
 	ssl.c ssl.h  ssl_backend.h \
+	ssl_openssl.c ssl_openssl.h \
+	ssl_polarssl.c ssl_polarssl.h \
 	ssl_verify.c ssl_verify.h ssl_verify_backend.h \
+	ssl_verify_openssl.c ssl_verify_openssl.h \
+	ssl_verify_polarssl.c ssl_verify_polarssl.h \
 	status.c status.h \
 	syshead.h \
 	tun.c tun.h \
@@ -153,21 +161,6 @@ configure.h: Makefile
 	awk -f $(srcdir)/configure_h.awk config.h > $@
 	awk -f $(srcdir)/configure_log.awk config.log >> $@
 
-if USE_OPENSSL
-openvpn_SOURCES += \
-	crypto_openssl.c crypto_openssl.h \
-	pkcs11_openssl.c \
-	ssl_openssl.c ssl_openssl.h \
-	ssl_verify_openssl.c ssl_verify_openssl.h
-endif
-if USE_POLARSSL
-openvpn_SOURCES += \
-	crypto_polarssl.c crypto_polarssl.h \
-	pkcs11_polarssl.c \
-	ssl_polarssl.c ssl_polarssl.h \
-	ssl_verify_polarssl.c ssl_verify_polarssl.h
-endif
-
 dist-hook:
 	cd $(distdir) && for i in $(EXTRA_DIST) $(SUBDIRS) ; do find $$i -name .svn -type d -prune -exec rm -rf '{}' ';' ; rm -f `find $$i -type f | grep -E '(^|\/)\.?\#|\~$$|\.s?o$$'` ; done
 
diff --git a/configure.ac b/configure.ac
index a6b3019..a4d68e6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -299,8 +299,6 @@ AC_ARG_WITH([ssl-type],
    esac],
    [SSL_LIB="openssl"]
 )
-AM_CONDITIONAL([USE_OPENSSL], [test x$SSL_LIB = xopenssl])
-AM_CONDITIONAL([USE_POLARSSL], [test x$SSL_LIB = xpolarssl])
 
 dnl fix search path, to allow compilers to find syshead.h
 CPPFLAGS="$CPPFLAGS -I${srcdir}"
diff --git a/crypto_openssl.c b/crypto_openssl.c
index 4f14ce2..e43d73c 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -29,6 +29,8 @@
 
 #include "syshead.h"
 
+#if defined(USE_CRYPTO) && defined(USE_OPENSSL)
+
 #include "basic.h"
 #include "buffer.h"
 #include "integer.h"
@@ -789,3 +791,5 @@ hmac_ctx_final (HMAC_CTX *ctx, uint8_t *dst)
 
   HMAC_Final (ctx, dst, &in_hmac_len);
 }
+
+#endif /* USE_CRYPTO && USE_OPENSSL */
diff --git a/crypto_polarssl.c b/crypto_polarssl.c
index 293a1fd..8119d58 100644
--- a/crypto_polarssl.c
+++ b/crypto_polarssl.c
@@ -29,6 +29,8 @@
 
 #include "syshead.h"
 
+#if defined(USE_CRYPTO) && defined(USE_POLARSSL)
+
 #include "errlevel.h"
 #include "basic.h"
 #include "buffer.h"
@@ -555,3 +557,5 @@ hmac_ctx_final (md_context_t *ctx, uint8_t *dst)
 {
   ASSERT(0 == md_hmac_finish(ctx, dst));
 }
+
+#endif /* USE_CRYPTO && USE_POLARSSL */
diff --git a/options.h b/options.h
index abdddba..0f80e70 100644
--- a/options.h
+++ b/options.h
@@ -77,7 +77,7 @@ struct options_pre_pull
 };
 
 #endif
-#if !defined(USE_OPENSSL) && !defined(USE_POLARSSL)
+#if defined(USE_CRYPTO) && !defined(USE_OPENSSL) && !defined(USE_POLARSSL)
 # error "At least one of OpenSSL or PolarSSL needs to be defined."
 #endif
 
diff --git a/pkcs11_openssl.c b/pkcs11_openssl.c
index 5c99bf3..e3463dc 100644
--- a/pkcs11_openssl.c
+++ b/pkcs11_openssl.c
@@ -29,7 +29,7 @@
 
 #include "syshead.h"
 
-#ifdef ENABLE_PKCS11
+#if defined(ENABLE_PKCS11) && defined(USE_OPENSSL)
 
 #include "errlevel.h"
 #include "pkcs11_backend.h"
@@ -185,4 +185,4 @@ cleanup:
     }
   return ret;
 }
-#endif /* ENABLE_PKCS11 */
+#endif /* defined(ENABLE_PKCS11) && defined(ENABLE_OPENSSL) */
diff --git a/pkcs11_polarssl.c b/pkcs11_polarssl.c
index 49d6a6b..4f8bf33 100644
--- a/pkcs11_polarssl.c
+++ b/pkcs11_polarssl.c
@@ -29,7 +29,7 @@
 
 #include "syshead.h"
 
-#if defined(ENABLE_PKCS11)
+#if defined(ENABLE_PKCS11) && defined(USE_POLARSSL)
 
 #include "errlevel.h"
 #include "pkcs11_backend.h"
@@ -118,4 +118,4 @@ cleanup:
 
   return ret;
 }
-#endif /* defined(ENABLE_PKCS11) */
+#endif /* defined(ENABLE_PKCS11) && defined(USE_POLARSSL) */
diff --git a/ssl_openssl.c b/ssl_openssl.c
index 7f579d2..a1e45d9 100644
--- a/ssl_openssl.c
+++ b/ssl_openssl.c
@@ -28,6 +28,9 @@
  */
 
 #include "syshead.h"
+
+#if defined(USE_SSL) && defined(USE_OPENSSL)
+
 #include "errlevel.h"
 #include "buffer.h"
 #include "misc.h"
@@ -1286,3 +1289,5 @@ get_highest_preference_tls_cipher (char *buf, int size)
   SSL_free (ssl);
   SSL_CTX_free (ctx);
 }
+
+#endif /* defined(USE_SSL) && defined(USE_OPENSSL) */
diff --git a/ssl_polarssl.c b/ssl_polarssl.c
index c95c0c0..9a8c49c 100644
--- a/ssl_polarssl.c
+++ b/ssl_polarssl.c
@@ -28,6 +28,9 @@
  */
 
 #include "syshead.h"
+
+#if defined(USE_SSL) && defined(USE_POLARSSL)
+
 #include "errlevel.h"
 #include "ssl_backend.h"
 #include "buffer.h"
@@ -857,3 +860,5 @@ get_highest_preference_tls_cipher (char *buf, int size)
   cipher_name = ssl_get_ciphersuite_name(*ciphers);
   strncpynt (buf, cipher_name, size);
 }
+
+#endif /* defined(USE_SSL) && defined(USE_POLARSSL) */
diff --git a/ssl_verify.c b/ssl_verify.c
index f0bc994..326b005 100644
--- a/ssl_verify.c
+++ b/ssl_verify.c
@@ -28,6 +28,9 @@
  */
 
 #include "syshead.h"
+
+#if defined(USE_CRYPTO) && defined(USE_SSL)
+
 #include "misc.h"
 #include "manage.h"
 #include "ssl_verify.h"
@@ -1237,3 +1240,4 @@ verify_final_auth_checks(struct tls_multi *multi, struct tls_session *session)
       gc_free (&gc);
     }
 }
+#endif /* defined(USE_CRYPTO) && defined(USE_SSL) */
diff --git a/ssl_verify_openssl.c b/ssl_verify_openssl.c
index 4f090e6..13c2f4e 100644
--- a/ssl_verify_openssl.c
+++ b/ssl_verify_openssl.c
@@ -27,6 +27,10 @@
  * @file Control Channel Verification Module OpenSSL implementation
  */
 
+#include "syshead.h"
+
+#if defined(USE_SSL) && defined(USE_OPENSSL)
+
 #include "ssl_verify.h"
 #include "ssl_verify_backend.h"
 #include "ssl_openssl.h"
@@ -584,3 +588,5 @@ end:
 
   return retval;
 }
+
+#endif /* defined(USE_SSL) && defined(USE_OPENSSL) */
diff --git a/ssl_verify_polarssl.c b/ssl_verify_polarssl.c
index 4cd6383..7fdca1f 100644
--- a/ssl_verify_polarssl.c
+++ b/ssl_verify_polarssl.c
@@ -27,6 +27,10 @@
  * @file Control Channel Verification Module PolarSSL backend
  */
 
+#include "syshead.h"
+
+#if defined(USE_SSL) && defined(USE_POLARSSL)
+
 #include "ssl_verify.h"
 #include <polarssl/sha1.h>
 
@@ -417,3 +421,5 @@ end:
   x509_crl_free(&crl);
   return retval;
 }
+
+#endif /* #if defined(USE_SSL) && defined(USE_POLARSSL) */
-- 
1.7.5.4


