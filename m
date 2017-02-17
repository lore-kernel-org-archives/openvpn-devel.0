Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: logout@...260...
Date: Fri, 17 Feb 2017 23:00:40 +0100
Message-Id: <a77187a66affdba318ef70e0e218b69cdad509d1.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
In-Reply-To: <cover.1487368114.git.logout@...260...>
References: <cover.1487368114.git.logout@...260...>
Subject: [Openvpn-devel] [RFC PATCH v1 01/15] OpenSSL: don't use direct
	access to the internal of SSL_CTX
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

From: Emmanuel Deloget <logout@...260...>

OpenSSL 1.1 does not allow us to directly access the internal of
any data type, including SSL_CTX. We have to use the defined functions
to do so.

Compatibility with OpenSSL 1.0 is kept by defining the corresponding
functions when they are not found in the library.

Signed-off-by: Emmanuel Deloget <logout@...260...>
---
 configure.ac                 |  9 ++++++
 src/openvpn/openssl_compat.h | 74 ++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_openssl.c    | 13 +++++---
 3 files changed, 91 insertions(+), 5 deletions(-)
 create mode 100644 src/openvpn/openssl_compat.h

diff --git a/configure.ac b/configure.ac
index b29f8b410dfb69bce1145c3bb4a1ba011f0636ec..5fe5d6046ceafa2b577296af772c347ac2ad8039 100644
--- a/configure.ac
+++ b/configure.ac
@@ -898,6 +898,15 @@ if test "${enable_crypto}" = "yes" -a "${with_crypto_library}" = "openssl"; then
 		[have_crypto_aead_modes="no"; break]
 	)
 
+	AC_CHECK_FUNCS(
+		[ \
+			SSL_CTX_get_default_passwd_cb \
+			SSL_CTX_get_default_passwd_cb_userdata \
+		],
+		,
+		[]
+	)
+
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
 
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
new file mode 100644
index 0000000000000000000000000000000000000000..59bad9ff24d10b358419d345181a0e2e52a0c662
--- /dev/null
+++ b/src/openvpn/openssl_compat.h
@@ -0,0 +1,74 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010-2017 Fox Crypto B.V. <openvpn@...1435...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/**
+ * @file OpenSSL compatibility stub
+ *
+ * This file provide compatibility stubs for the OpenSSL libraries
+ * prior to version 1.1. This version introduces many changes in the
+ * library interface, including the fact that various objects and
+ * structures are not fully opaque.
+ */
+
+#ifndef OPENSSL_COMPAT_H_
+#define OPENSSL_COMPAT_H_
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include <openssl/ssl.h>
+
+#if !defined(HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA)
+/**
+ * Fetch the default password callback user data from the SSL context
+ *
+ * @param ctx                SSL context
+ * @return                   The password callback user data
+ */
+static inline void *
+SSL_CTX_get_default_passwd_cb_userdata(SSL_CTX *ctx)
+{
+    return ctx ? ctx->default_passwd_callback_userdata : NULL;
+}
+#endif
+
+#if !defined(HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB)
+/**
+ * Fetch the default password callback from the SSL context
+ *
+ * @param ctx                SSL context
+ * @return                   The password callback
+ */
+static inline pem_password_cb *
+SSL_CTX_get_default_passwd_cb(SSL_CTX *ctx)
+{
+    return ctx ? ctx->default_passwd_callback : NULL;
+}
+#endif
+
+#endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index abf69c91a60910e450ae6d2d49ea7e5b1cd3a535..39e92f8cdae52d54d0ad95a9362e4e0e1b2289f4 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -45,6 +45,7 @@
 #include "ssl_backend.h"
 #include "ssl_common.h"
 #include "base64.h"
+#include "openssl_compat.h"
 
 #ifdef ENABLE_CRYPTOAPI
 #include "cryptoapi.h"
@@ -658,7 +659,8 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
         {
             for (i = 0; i < sk_X509_num(ca); i++)
             {
-                if (!X509_STORE_add_cert(ctx->ctx->cert_store,sk_X509_value(ca, i)))
+                X509_STORE *cert_store = SSL_CTX_get_cert_store(ctx->ctx);
+                if (!X509_STORE_add_cert(cert_store,sk_X509_value(ca, i)))
                 {
                     crypto_msg(M_FATAL,"Cannot add certificate to certificate chain (X509_STORE_add_cert)");
                 }
@@ -760,8 +762,9 @@ tls_ctx_load_cert_file_and_copy(struct tls_root_ctx *ctx,
         goto end;
     }
 
-    x = PEM_read_bio_X509(in, NULL, ctx->ctx->default_passwd_callback,
-                          ctx->ctx->default_passwd_callback_userdata);
+    x = PEM_read_bio_X509(in, NULL,
+                          SSL_CTX_get_default_passwd_cb(ctx->ctx),
+                          SSL_CTX_get_default_passwd_cb_userdata(ctx->ctx));
     if (x == NULL)
     {
         SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_PEM_LIB);
@@ -843,8 +846,8 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
     }
 
     pkey = PEM_read_bio_PrivateKey(in, NULL,
-                                   ssl_ctx->default_passwd_callback,
-                                   ssl_ctx->default_passwd_callback_userdata);
+                                   SSL_CTX_get_default_passwd_cb(ctx->ctx),
+                                   SSL_CTX_get_default_passwd_cb_userdata(ctx->ctx));
     if (!pkey)
     {
         goto end;
-- 
2.7.4


