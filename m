From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:31:14 +0200
Message-Id: <20211019183127.614175-9-arne@...1227...>
In-Reply-To: <20211019183127.614175-1-arne@...1227...>
References: <20211019183127.614175-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 08/21] [OSSL 3.0] Use
 EVP_PKEY_get_group_name to query group name
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

EC_Key methods are deprecated in OpenSSL 3.0. Use
EVP_PKEY_get_group_name instead to query the EC group name from an
EVP_PKEY and add a compatibility function for older OpenSSL versions.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/openssl_compat.h | 42 ++++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_openssl.c    | 14 ++++++------
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index ce8e2b360..dda47d76c 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -718,4 +718,46 @@ SSL_CTX_set_max_proto_version(SSL_CTX *ctx, long tls_ver_max)
     return 1;
 }
 #endif /* if OPENSSL_VERSION_NUMBER < 0x10100000L && !defined(ENABLE_CRYPTO_WOLFSSL) */
+
+/* Functionality missing in 1.1.1 */
+#if OPENSSL_VERSION_NUMBER < 0x30000000L && !defined(OPENSSL_NO_EC)
+
+/* Note that this is not a perfect emulation of the new function but
+ * is good enough for our case of printing certificate details during
+ * handshake */
+static inline
+int EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,
+                            size_t *gname_len)
+{
+    const EC_KEY* ec = EVP_PKEY_get0_EC_KEY(pkey);
+    if (ec == NULL)
+    {
+        return 0;
+    }
+    const EC_GROUP* group = EC_KEY_get0_group(ec);
+    int nid = EC_GROUP_get_curve_name(group);
+
+    if (nid == 0)
+    {
+        return 0;
+    }
+    const char *curve = OBJ_nid2sn(nid);
+
+    strncpynt(gname, curve, gname_sz);
+    *gname_len = min_int(strlen(curve), gname_sz);
+    return 1;
+}
+#endif
+
+/** Mimics SSL_CTX_new_ex for OpenSSL < 3 */
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
+static inline SSL_CTX *
+SSL_CTX_new_ex(void *libctx, const char *propq, const SSL_METHOD *method)
+{
+    (void) libctx;
+    (void) propq;
+    return SSL_CTX_new(method);
+}
+#endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */
+
 #endif /* OPENSSL_COMPAT_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 92d8d0eeb..8ec96e66c 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2053,13 +2053,15 @@ print_cert_details(X509 *cert, char *buf, size_t buflen)
     int typeid = EVP_PKEY_id(pkey);
 
 #ifndef OPENSSL_NO_EC
-    if (typeid == EVP_PKEY_EC && EVP_PKEY_get0_EC_KEY(pkey) != NULL)
+    char groupname[256];
+    if (typeid == EVP_PKEY_EC)
     {
-        const EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
-        const EC_GROUP *group = EC_KEY_get0_group(ec);
-
-        int nid = EC_GROUP_get_curve_name(group);
-        if (nid == 0 || (curve = OBJ_nid2sn(nid)) == NULL)
+        size_t len;
+        if(EVP_PKEY_get_group_name(pkey, groupname, sizeof(groupname), &len))
+        {
+           curve = groupname;
+        }
+        else
         {
             curve = "(error getting curve name)";
         }
-- 
2.33.0


