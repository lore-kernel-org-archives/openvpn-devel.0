From: selva.nair@...277...
Date: Tue, 26 Jul 2022 07:51:00 -0400
Message-Id: <20220726115100.31449-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] xkey_provider: fix building with
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

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

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
-- 
2.30.2


