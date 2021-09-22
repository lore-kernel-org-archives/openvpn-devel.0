From: selva.nair@...277...
Date: Wed, 22 Sep 2021 17:12:46 -0400
Message-Id: <20210922211254.7570-2-selva.nair@...277...>
In-Reply-To: <20210922211254.7570-1-selva.nair@...277...>
References: <20210922211254.7570-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/9] A built-in provider for using external
 key with OpenSSL 3.0
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

Hooking into callbacks in RSA_METHOD and EVP_PKEY_METHOD
structures is deprecated in OpenSSL 3.0. For signing with
external keys that are not exportable (tokens, stores, etc.)
requires a custom provider interface so that key operations
are done under its context.

A single provider is enough for handling all external keys
we support -- management-external-key, cryptoapicert(CNG) and
pkcs11-helper. The series of patches starting with this implement
such a provider.

To activate the use of the provider, essentially, the
SSL_CTX object is created with property string set to
to prioritize our provider. In the provider we implement
only keymgmt and signature operations. All other operations
get directly used from the default provider.

However, signature operations include verify using peer's
public key as well. In particular, we get called for
both DigestVerify and DigestSign operations. For the former
we call back OpenSSL, for the latter we compute the digest
using OpenSSL and then pass it to the backend for signature.

So a lot of glue code is needed and this makes the patches
somewhat large even after splitting into many commits.

This patch implements only the provider_init function so
that it can be loaded, but has no capabilities. The required
interfaces are added in following commits.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 configure.ac                |  11 +++
 src/openvpn/Makefile.am     |   1 +
 src/openvpn/xkey_common.h   |  42 +++++++++
 src/openvpn/xkey_provider.c | 177 ++++++++++++++++++++++++++++++++++++
 4 files changed, 231 insertions(+)
 create mode 100644 src/openvpn/xkey_common.h
 create mode 100644 src/openvpn/xkey_provider.c

diff --git a/configure.ac b/configure.ac
index 7c2ead6a..0390a05e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -821,6 +821,17 @@ if test "${with_crypto_library}" = "openssl"; then
 		AC_DEFINE([HAVE_OPENSSL_ENGINE], [1], [OpenSSL engine support available])
 	fi
 
+	have_openssl_provider="yes"
+	AC_CHECK_FUNCS(
+		[OSSL_PROVIDER_load]
+		,
+		,
+		[have_openssl_provider="no"; break]
+	)
+	if test "${have_openssl_provider}" = "yes"; then
+		AC_DEFINE([HAVE_XKEY_PROVIDER], [1], [External key loading provider can be used])
+	fi
+
 	AC_CHECK_FUNC(
 		[EVP_aes_256_gcm],
 		,
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 5883c291..432efe73 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -128,6 +128,7 @@ openvpn_SOURCES = \
 	tls_crypt.c tls_crypt.h \
 	tun.c tun.h \
 	vlan.c vlan.h \
+	xkey_provider.c xkey_common.h \
 	win32.h win32.c \
 	win32-util.h win32-util.c \
 	cryptoapi.h cryptoapi.c
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
new file mode 100644
index 00000000..eb31604f
--- /dev/null
+++ b/src/openvpn/xkey_common.h
@@ -0,0 +1,42 @@
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
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
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
+#ifndef XKEY_PUBLIC_H_
+#define XKEY_PUBLIC_H_
+
+#ifdef HAVE_XKEY_PROVIDER
+
+#include <openssl/provider.h>
+#include <openssl/core_dispatch.h>
+
+/**
+ * Initialization function for OpenVPN external key provider for OpenSSL
+ * Follows the signature of OSSL_PROVIDER init
+ */
+OSSL_provider_init_fn xkey_provider_init;
+
+#endif /* HAVE_XKEY_PROVIDER */
+
+#define XKEY_PROV_PROPS "provider=ovpn.xkey"
+
+#endif /* XKEY_PUBLIC_H_ */
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
new file mode 100644
index 00000000..9d19d37d
--- /dev/null
+++ b/src/openvpn/xkey_provider.c
@@ -0,0 +1,177 @@
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
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
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
+#ifdef HAVE_XKEY_PROVIDER
+
+#include "syshead.h"
+#include "error.h"
+#include "buffer.h"
+#include "xkey_common.h"
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
+/* A descriptive name */
+static const char *provname = "OpenVPN External Key Provider";
+
+typedef struct
+{
+    const OSSL_CORE_HANDLE *core;
+    OSSL_PROVIDER *deflt;  /* default provider that we load for delegating some ops */
+    OSSL_LIB_CTX *libctx;  /* libctx of the core context in which we are running */
+} XKEY_PROVIDER_CTX;
+
+/* main provider interface */
+
+/* provider callbacks we implement */
+static OSSL_FUNC_provider_query_operation_fn query_operation;
+static OSSL_FUNC_provider_gettable_params_fn gettable_params;
+static OSSL_FUNC_provider_get_params_fn get_params;
+static OSSL_FUNC_provider_teardown_fn teardown;
+
+static const OSSL_ALGORITHM *
+query_operation(void *provctx, int op, int *no_store)
+{
+    dmsg(D_LOW, "In xkey provider query op with op = %d", op);
+
+    *no_store = 0;
+
+    switch (op)
+    {
+        case OSSL_OP_SIGNATURE:
+            return NULL;
+
+        case OSSL_OP_KEYMGMT:
+            return NULL;
+
+        default:
+            break;
+    }
+    return NULL;
+}
+
+static const OSSL_PARAM *
+gettable_params(void *provctx)
+{
+    dmsg(D_LOW, "In xkey provider gettable_params");
+
+    static const OSSL_PARAM param_types[] = {
+        OSSL_PARAM_DEFN(OSSL_PROV_PARAM_NAME, OSSL_PARAM_UTF8_PTR, NULL, 0),
+        OSSL_PARAM_END
+    };
+
+    return param_types;
+}
+static int
+get_params(void *provctx, OSSL_PARAM params[])
+{
+    OSSL_PARAM *p;
+
+    dmsg(D_LOW, "In xkey provider get_params");
+
+    p = OSSL_PARAM_locate(params, OSSL_PROV_PARAM_NAME);
+    if (p)
+    {
+        return (OSSL_PARAM_set_utf8_ptr(p, provname) != 0);
+    }
+
+    return 0;
+}
+
+static void
+teardown(void *provctx)
+{
+    dmsg(D_LOW, "In xkey provider teardown");
+
+    XKEY_PROVIDER_CTX *prov = provctx;
+    if (prov && prov->deflt)
+    {
+        OSSL_PROVIDER_unload(prov->deflt);
+    }
+    free(prov);
+}
+
+static const OSSL_DISPATCH dispatch_table[] = {
+    {OSSL_FUNC_PROVIDER_GETTABLE_PARAMS, (void (*)(void))gettable_params},
+    {OSSL_FUNC_PROVIDER_GET_PARAMS, (void (*)(void))get_params},
+    {OSSL_FUNC_PROVIDER_QUERY_OPERATION, (void (*)(void))query_operation},
+    {OSSL_FUNC_PROVIDER_TEARDOWN, (void (*)(void))teardown},
+    {0, NULL}
+};
+
+int
+xkey_provider_init(const OSSL_CORE_HANDLE *handle, const OSSL_DISPATCH *in,
+                   const OSSL_DISPATCH **out, void **provctx)
+{
+    XKEY_PROVIDER_CTX *prov;
+    OSSL_FUNC_core_get_libctx_fn *c_get_libctx = NULL;
+
+    dmsg(D_LOW, "In xkey provider init");
+
+    prov = calloc(sizeof(*prov), 1);
+    if (!prov)
+    {
+        msg(M_NONFATAL, "xkey_provider_init: out of memory");
+        return 0;
+    }
+
+    /* get our libctx */
+    for (; in->function_id != 0; in++)
+    {
+        if (in->function_id == OSSL_FUNC_CORE_GET_LIBCTX)
+        {
+            c_get_libctx = OSSL_FUNC_core_get_libctx(in);
+        }
+    }
+
+    if (c_get_libctx)
+    {
+        prov->libctx = (OSSL_LIB_CTX *)c_get_libctx(handle);
+    }
+    prov->core = handle;
+
+    prov->deflt = OSSL_PROVIDER_load(prov->libctx, "default");
+    if (!prov->deflt)
+    {
+        msg(M_NONFATAL, "xkey_provider_init: default provider could not be loaded");
+    }
+
+    *out = dispatch_table;
+    *provctx = prov;
+
+    return 1;
+}
+
+#endif /* HAVE_XKEY_PROVIDER */
-- 
2.20.1


