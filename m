From: selva.nair@...277...
Date: Fri, 19 Jan 2018 23:47:27 -0500
Message-Id: <1516423647-21932-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Add SSL_CTX_get_max_proto_version() not in
 openssl 1.0
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

- No change in functionality. This is used in a subsequent
  patch for extending TLS1.2 support with cryptoapicert

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/openssl_compat.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 9f1e92a..c94341a 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -670,6 +670,29 @@ SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
 }
 #endif /* SSL_CTX_get_min_proto_version */
 
+#ifndef SSL_CTX_get_max_proto_version
+/** Return the max SSL protocol version currently enabled in the context.
+ *  If no valid version >= TLS1.0 is found, return 0. */
+static inline int
+SSL_CTX_get_max_proto_version(SSL_CTX *ctx)
+{
+    long sslopt = SSL_CTX_get_options(ctx);
+    if (!(sslopt & SSL_OP_NO_TLSv1_2))
+    {
+	return TLS1_2_VERSION;
+    }
+    if (!(sslopt & SSL_OP_NO_TLSv1_1))
+    {
+	return TLS1_1_VERSION;
+    }
+    if (!(sslopt & SSL_OP_NO_TLSv1))
+    {
+	return TLS1_VERSION;
+    }
+    return 0;
+}
+#endif /* SSL_CTX_get_max_proto_version */
+
 #ifndef SSL_CTX_set_min_proto_version
 /** Mimics SSL_CTX_set_min_proto_version for OpenSSL < 1.1 */
 static inline int
-- 
2.1.4


