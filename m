From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:16 -0500
Message-Id: <20211214165928.30676-7-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 06/18] A helper function to import
 private key for management-external-key
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

From: Selva Nair <selva.nair@...277...>

- Leverage keymgmt_import through EVP_PKEY_new_fromdata() to
  import "management-external-key"

- When required, use this to set SSL_CTX_use_PrivateKey

The sign_op is not implemented yet. This will error out while
signing with --management-external-key. The next commit
fixes that.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/Makefile.am   |   1 +
 src/openvpn/ssl_openssl.c |  11 ++++
 src/openvpn/xkey_common.h |  11 ++++
 src/openvpn/xkey_helper.c | 106 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 129 insertions(+)
 create mode 100644 src/openvpn/xkey_helper.c

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 432efe73..0331298b 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -129,6 +129,7 @@ openvpn_SOURCES = \
 	tun.c tun.h \
 	vlan.c vlan.h \
 	xkey_provider.c xkey_common.h \
+	xkey_helper.c \
 	win32.h win32.c \
 	win32-util.h win32-util.c \
 	cryptoapi.h cryptoapi.c
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index bdaa7a2b..23c74f55 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1486,6 +1486,15 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
     EVP_PKEY *pkey = X509_get0_pubkey(cert);
     ASSERT(pkey); /* NULL before SSL_CTX_use_certificate() is called */
 
+#ifdef HAVE_XKEY_PROVIDER
+    EVP_PKEY *privkey = xkey_load_management_key(tls_libctx, pkey);
+    if (!privkey
+        || !SSL_CTX_use_PrivateKey(ctx->ctx, privkey))
+    {
+        goto cleanup;
+    }
+    EVP_PKEY_free(privkey);
+#else
     if (EVP_PKEY_id(pkey) == EVP_PKEY_RSA)
     {
         if (!tls_ctx_use_external_rsa_key(ctx, pkey))
@@ -1514,6 +1523,8 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
     }
 #endif /* OPENSSL_VERSION_NUMBER > 1.1.0 dev && !defined(OPENSSL_NO_EC) */
 
+#endif /* HAVE_XKEY_PROVIDER */
+
     ret = 0;
 cleanup:
     if (ret)
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index f46bacd2..5bda5e30 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -82,6 +82,17 @@ typedef int (XKEY_EXTERNAL_SIGN_fn)(void *handle, unsigned char *sig, size_t *si
  */
 typedef void (XKEY_PRIVKEY_FREE_fn)(void *handle);
 
+/**
+ * Generate an encapsulated EVP_PKEY for management-external-key
+ *
+ * @param libctx library context in which xkey provider has been loaded
+ * @param pubkey corresponding pubkey in the default provider's context
+ *
+ * @returns a new EVP_PKEY in the provider's keymgmt context.
+ * The pubkey is up-refd if retained -- the caller can free it after return
+ */
+EVP_PKEY *xkey_load_management_key(OSSL_LIB_CTX *libctx, EVP_PKEY *pubkey);
+
 #endif /* HAVE_XKEY_PROVIDER */
 
 #endif /* XKEY_COMMON_H_ */
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
new file mode 100644
index 00000000..51cfb12b
--- /dev/null
+++ b/src/openvpn/xkey_helper.c
@@ -0,0 +1,106 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2021 Selva Nair <selva.nair@...277...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by the
+ *  Free Software Foundation, either version 2 of the License,
+ *  or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+#include "error.h"
+#include "buffer.h"
+#include "xkey_common.h"
+
+#ifdef HAVE_XKEY_PROVIDER
+
+#include <openssl/provider.h>
+#include <openssl/params.h>
+#include <openssl/core_dispatch.h>
+#include <openssl/core_object.h>
+#include <openssl/core_names.h>
+#include <openssl/store.h>
+#include <openssl/evp.h>
+#include <openssl/err.h>
+
+static const char *const props = XKEY_PROV_PROPS;
+
+XKEY_EXTERNAL_SIGN_fn xkey_management_sign;
+
+/**
+ * Load external key for signing via management interface.
+ * The public key must be passed in by the caller as we may not
+ * be able to get it from the management.
+ * Returns an EVP_PKEY object attached to xkey provider.
+ * Caller must free it when no longer needed.
+ */
+EVP_PKEY *
+xkey_load_management_key(OSSL_LIB_CTX *libctx, EVP_PKEY *pubkey)
+{
+    EVP_PKEY *pkey = NULL;
+    ASSERT(pubkey);
+
+    /* Management interface doesnt require any handle to be
+     * stored in the key. We use a dummy pointer as we do need a
+     * non-NULL value to indicate private key is avaialble.
+     */
+    void *dummy = & "dummy";
+
+    const char *origin = "management";
+    XKEY_EXTERNAL_SIGN_fn *sign_op = xkey_management_sign;
+
+    /* UTF8 string pointers in here are only read from, so cast is safe */
+    OSSL_PARAM params[] = {
+        {"xkey-origin", OSSL_PARAM_UTF8_STRING, (char *) origin, 0, 0},
+        {"pubkey", OSSL_PARAM_OCTET_STRING, &pubkey, sizeof(pubkey), 0},
+        {"handle", OSSL_PARAM_OCTET_PTR, &dummy, sizeof(dummy), 0},
+        {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op, sizeof(sign_op), 0},
+        {NULL, 0, NULL, 0, 0}};
+
+    /* Do not use EVP_PKEY_new_from_pkey as that will take keymgmt from pubkey */
+    EVP_PKEY_CTX *ctx = EVP_PKEY_CTX_new_from_name(libctx, EVP_PKEY_get0_type_name(pubkey), props);
+    if (!ctx
+        || EVP_PKEY_fromdata_init(ctx) != 1
+        || EVP_PKEY_fromdata(ctx, &pkey, EVP_PKEY_KEYPAIR, params) != 1)
+    {
+        msg(M_NONFATAL, "Error loading key into ovpn.xkey provider");
+    }
+    if (ctx)
+    {
+        EVP_PKEY_CTX_free(ctx);
+    }
+
+    return pkey;
+}
+
+/* not yet implemented */
+int
+xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
+                     const unsigned char *tbs, size_t tbslen, XKEY_SIGALG alg)
+{
+    msg(M_FATAL, "FATAL ERROR: A sign callback for this key is not implemented.");
+    return 0;
+}
+
+#endif /* HAVE_XKEY_PROVIDER */
-- 
2.30.2


