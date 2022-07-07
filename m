From: selva.nair@...277...
Date: Wed,  6 Jul 2022 23:51:51 -0400
Message-Id: <20220707035151.25469-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix crash in xkey-provider in msvc builds
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

The function signature for xkey_load_generic_key had
function pointers defined as function types that seems
to work in gcc but not in msvc.

Fix it by changing the function signatures to what was
intended.
Also revert part of commit 627d1a3d28638... as that work-
around should be no longer required.

Reported by: Lev Stipakov https://github.com/lstipakov

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_common.h | 2 +-
 src/openvpn/xkey_helper.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index e0e5ed5b..6d6a1e2c 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -152,7 +152,7 @@ xkey_digest(const unsigned char *src, size_t srclen, unsigned char *buf,
  */
 EVP_PKEY *
 xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
-                      XKEY_EXTERNAL_SIGN_fn sign_op, XKEY_PRIVKEY_FREE_fn free_op);
+                      XKEY_EXTERNAL_SIGN_fn *sign_op, XKEY_PRIVKEY_FREE_fn *free_op);
 
 extern OSSL_LIB_CTX *tls_libctx; /* Global */
 
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index 14f074ae..73235fd6 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -115,7 +115,7 @@ xkey_load_management_key(OSSL_LIB_CTX *libctx, EVP_PKEY *pubkey)
  */
 EVP_PKEY *
 xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
-                      XKEY_EXTERNAL_SIGN_fn sign_op, XKEY_PRIVKEY_FREE_fn free_op)
+                      XKEY_EXTERNAL_SIGN_fn *sign_op, XKEY_PRIVKEY_FREE_fn *free_op)
 {
     EVP_PKEY *pkey = NULL;
     const char *origin = "external";
@@ -125,8 +125,8 @@ xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
         {"xkey-origin", OSSL_PARAM_UTF8_STRING, (char *) origin, 0, 0},
         {"pubkey", OSSL_PARAM_OCTET_STRING, &pubkey, sizeof(pubkey), 0},
         {"handle", OSSL_PARAM_OCTET_PTR, &handle, sizeof(handle), 0},
-        {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op, sizeof(void *), 0},
-        {"free_op", OSSL_PARAM_OCTET_PTR, (void **) &free_op, sizeof(void *), 0},
+        {"sign_op", OSSL_PARAM_OCTET_PTR, (void **) &sign_op, sizeof(sign_op), 0},
+        {"free_op", OSSL_PARAM_OCTET_PTR, (void **) &free_op, sizeof(free_op), 0},
         {NULL, 0, NULL, 0, 0}
     };
     msg(M_INFO, "%s: handle = %p sign_op = %p free_op = %p ", __FUNCTION__,
-- 
2.30.2


