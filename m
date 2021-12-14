From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:11 -0500
Message-Id: <20211214165928.30676-2-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 01/18] A built-in provider for using
 external key with OpenSSL 3.0
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

This patch implements only the provider_init function so
that it can be loaded, but has no capabilities. The required
interfaces are added in following commits.

v2 changes:
 - Require OpenSSL 3.0.1 or newer: 3.0.0 is "buggy" as it
   does not preferentially fetch operations from the keymgmt
   of the key. This causes either an unsuccessful attempt at
   exporting unexportable keys or an onerous requirement that
   the external key's KEYMGMT should support a whole lot
   of unrelated functionalities including key generation and
   key exchange.
   Fixed by PR #16725 in OpenSSL.
 - Use a child libctx for internal use in the provider

v3 changes:
 - Move OpenSSL version check for 3.0.1+ from configure to
   xkey_common.h

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/Makefile.am     |   1 +
 src/openvpn/xkey_common.h   |  45 ++++++++++
 src/openvpn/xkey_provider.c | 169 ++++++++++++++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 src/openvpn/xkey_common.h
 create mode 100644 src/openvpn/xkey_provider.c

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
index 00000000..a3bc3f2a
--- /dev/null
+++ b/src/openvpn/xkey_common.h
@@ -0,0 +1,45 @@
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
+#ifndef XKEY_COMMON_H_
+#define XKEY_COMMON_H_
+
+#include <openssl/opensslv.h>
+#if OPENSSL_VERSION_NUMBER >= 0x30000010L && !defined(DISABLE_XKEY_PROVIDER)
+#define HAVE_XKEY_PROVIDER 1
+
+#include <openssl/provider.h>
+#include <openssl/core_dispatch.h>
+
+/**
+ * Initialization function for OpenVPN external key provider for OpenSSL
+ * Follows the function signature of OSSL_PROVIDER init()
+ */
+OSSL_provider_init_fn xkey_provider_init;
+
+#define XKEY_PROV_PROPS "provider=ovpn.xkey"
+
+#endif /* HAVE_XKEY_PROVIDER */
+
+#endif /* XKEY_COMMON_H_ */
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
new file mode 100644
index 00000000..d47faf0a
--- /dev/null
+++ b/src/openvpn/xkey_provider.c
@@ -0,0 +1,169 @@
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
+/* A descriptive name */
+static const char *provname = "OpenVPN External Key Provider";
+
+typedef struct
+{
+    OSSL_LIB_CTX *libctx;  /**< a child libctx for our own use */
+} XKEY_PROVIDER_CTX;
+
+/* helper to print debug messages */
+#define xkey_dmsg(f, ...) \
+        do {                                                        \
+              dmsg(f|M_NOLF, "xkey_provider: In %s: ", __func__);    \
+              dmsg(f|M_NOPREFIX, __VA_ARGS__);                      \
+           } while(0)
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
+    xkey_dmsg(D_LOW, "op = %d", op);
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
+            xkey_dmsg(D_LOW, "op not supported");
+            break;
+    }
+    return NULL;
+}
+
+static const OSSL_PARAM *
+gettable_params(void *provctx)
+{
+    xkey_dmsg(D_LOW, "entry");
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
+    xkey_dmsg(D_LOW, "entry");
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
+    xkey_dmsg(D_LOW, "entry");
+
+    XKEY_PROVIDER_CTX *prov = provctx;
+    if (prov && prov->libctx)
+    {
+        OSSL_LIB_CTX_free(prov->libctx);
+    }
+    OPENSSL_free(prov);
+}
+
+static const OSSL_DISPATCH dispatch_table[] = {
+    {OSSL_FUNC_PROVIDER_GETTABLE_PARAMS, (void (*)(void)) gettable_params},
+    {OSSL_FUNC_PROVIDER_GET_PARAMS, (void (*)(void)) get_params},
+    {OSSL_FUNC_PROVIDER_QUERY_OPERATION, (void (*)(void)) query_operation},
+    {OSSL_FUNC_PROVIDER_TEARDOWN, (void (*)(void)) teardown},
+    {0, NULL}
+};
+
+int
+xkey_provider_init(const OSSL_CORE_HANDLE *handle, const OSSL_DISPATCH *in,
+                   const OSSL_DISPATCH **out, void **provctx)
+{
+    XKEY_PROVIDER_CTX *prov;
+
+    xkey_dmsg(D_LOW, "entry");
+
+    prov = OPENSSL_zalloc(sizeof(*prov));
+    if (!prov)
+    {
+        msg(M_NONFATAL, "xkey_provider_init: out of memory");
+        return 0;
+    }
+
+    /* Make a child libctx for our use and set default prop query
+     * on it to ensure calls we delegate won't loop back to us.
+     */
+    prov->libctx = OSSL_LIB_CTX_new_child(handle, in);
+
+    EVP_set_default_properties(prov->libctx, "provider!=ovpn.xkey");
+
+    *out = dispatch_table;
+    *provctx = prov;
+
+    return 1;
+}
+
+#endif /* HAVE_XKEY_PROVIDER */
-- 
2.30.2


