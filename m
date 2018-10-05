From: Arne Schwabe <arne@...1227...>
Date: Fri,  5 Oct 2018 13:49:18 +0200
Message-Id: <20181005114918.30626-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Add OpenSSL compat definition for
 RSA_meth_set_sign
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

Commit 6b495dc4c5cfc118091ddc9c19330b3c9e3e3dff introduced
RSA_meth_set_sign, which is OpenSSL 1.1.0 and newer. Add a compatibility
definition.
---
 configure.ac                 |  1 +
 src/openvpn/openssl_compat.h | 20 ++++++++++++++++++++
 src/openvpn/ssl_openssl.c    |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/configure.ac b/configure.ac
index 3d8e15bd..399cdf4e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -943,6 +943,7 @@ if test "${with_crypto_library}" = "openssl"; then
 			RSA_meth_set_priv_enc \
 			RSA_meth_set_priv_dec \
 			RSA_meth_set_init \
+			RSA_meth_set_sign \
 			RSA_meth_set_finish \
 			RSA_meth_set0_app_data \
 			RSA_meth_get0_app_data \
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index f5328c4c..3877734f 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -585,6 +585,26 @@ RSA_meth_set_init(RSA_METHOD *meth, int (*init) (RSA *rsa))
 }
 #endif
 
+#if !(defined HAVE_RSA_MATH_SET_SIGN)
+/**
+ * Set the init function of an RSA_METHOD object
+ *
+ * @param meth               The RSA_METHOD object
+ * @param init               the init function
+ * @return                   1 on success, 0 on error
+ */
+static inline
+int RSA_meth_set_sign(RSA_METHOD *meth,
+                      int (*sign) (int type, const unsigned char *m,
+                                   unsigned int m_length,
+                                   unsigned char *sigret, unsigned int *siglen,
+                                   const RSA *rsa))
+{
+  meth->rsa_sign = sign;
+  return 1;
+}
+#endif
+
 #if !defined(HAVE_RSA_METH_SET_FINISH)
 /**
  * Set the finish function of an RSA_METHOD object
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index cfc628b6..0861db4f 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2000,6 +2000,10 @@ show_available_tls_ciphers_list(const char *cipher_list,
     tls_ctx_set_cert_profile(&tls_ctx, tls_cert_profile);
     tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
 
+    /* Even though setting the version does not seem to work,
+     * we do this because it might get fixed in future SSL
+     * versions
+     */
 #if (OPENSSL_VERSION_NUMBER >= 0x1010100fL)
     if (tls13)
     {
-- 
2.19.0


