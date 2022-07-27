From: selva.nair@...277...
Date: Wed, 27 Jul 2022 18:18:30 -0400
Message-Id: <20220727221830.31861-1-selva.nair@...277...>
In-Reply-To: <20220726115100.31449-1-selva.nair@...277...>
References: <20220726115100.31449-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] xkey_provider: fix building with
 --disable-management
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

v2: also fix building test_provider
 - ifdefs in test_provider.c
 - include integer.h for min_int as manage.h
   may not always pull it in

Too many ifdefs, unfortunately..

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_helper.c                | 4 ++++
 tests/unit_tests/openvpn/test_provider.c | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 81dd71dc..27e87d79 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -85,6 +85,7 @@ xkey_digest(const unsigned char *src, size_t srclen, unsigned char *buf,
     return 1;
 }
 
+#ifdef ENABLE_MANAGEMENT
 /**
  * Load external key for signing via management interface.
  * The public key must be passed in by the caller as we may not
@@ -107,6 +108,7 @@ xkey_load_management_key(OSSL_LIB_CTX *libctx, EVP_PKEY *pubkey)
 
     return xkey_load_generic_key(libctx, dummy, pubkey, sign_op, NULL);
 }
+#endif
 
 /**
  * Load a generic key into the xkey provider.
@@ -147,6 +149,7 @@ xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
     return pkey;
 }
 
+#ifdef ENABLE_MANAGEMENT
 /**
  * Signature callback for xkey_provider with management-external-key
  *
@@ -277,6 +280,7 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
 
     return (*siglen > 0);
 }
+#endif /* ENABLE MANAGEMENT */
 
 /**
  * Add PKCS1 DigestInfo to tbs and return the result in *enc.
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 47e7e395..d146af62 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -30,6 +30,7 @@
 
 #include "syshead.h"
 #include "manage.h"
+#include "integer.h"
 #include "xkey_common.h"
 
 #ifdef HAVE_XKEY_PROVIDER
@@ -127,7 +128,9 @@ init_test()
     /* set default propq matching what we use in ssl_openssl.c */
     EVP_set_default_properties(NULL, "?provider!=ovpn.xkey");
 
+#ifdef ENABLE_MANAGEMENT
     management = test_calloc(sizeof(*management), 1);
+#endif
 }
 
 static void
@@ -272,6 +275,7 @@ done:
     return sig;
 }
 
+#ifdef ENABLE_MANAGEMENT
 /* Check loading of management external key and have sign callback exercised
  * for RSA and EC keys with and without digest support in management client.
  * Sha256 digest used for both cases with pss padding for RSA.
@@ -310,6 +314,7 @@ again:
         EVP_PKEY_free(privkey);
     }
 }
+#endif
 
 /* helpers for testing generic key load and sign */
 static int xkey_free_called;
@@ -409,7 +414,9 @@ main(void)
 
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(xkey_provider_test_fetch),
+#ifdef ENABLE_MANAGEMENT
         cmocka_unit_test(xkey_provider_test_mgmt_sign_cb),
+#endif
         cmocka_unit_test(xkey_provider_test_generic_sign_cb),
     };
 
-- 
2.30.2


