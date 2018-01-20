From: selva.nair@...277...
Date: Sat, 20 Jan 2018 12:11:34 -0500
Message-Id: <1516468294-32635-1-git-send-email-selva.nair@...277...>
In-Reply-To: <5fa43bce-203f-1470-d66c-c7739dc8aa6a@...2373...@karger.me>
References: <5fa43bce-203f-1470-d66c-c7739dc8aa6a@...2373...@karger.me>
Subject: [Openvpn-devel] [PATCH 2.4] Add SSL_CTX_get_max_proto_version() not
 in openssl 1.0
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
This is for 2.4
Same as the patch merged into master except for the ifdefs
needed for 0.9.8

 src/openvpn/openssl_compat.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 9f1e92a..4b338d2 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -670,6 +670,33 @@ SSL_CTX_get_min_proto_version(SSL_CTX *ctx)
 }
 #endif /* SSL_CTX_get_min_proto_version */
 
+#ifndef SSL_CTX_get_max_proto_version
+/** Return the max SSL protocol version currently enabled in the context.
+ *  If no valid version >= TLS1.0 is found, return 0. */
+static inline int
+SSL_CTX_get_max_proto_version(SSL_CTX *ctx)
+{
+    long sslopt = SSL_CTX_get_options(ctx);
+#ifdef SSL_OP_NO_TLSv1_2
+    if (!(sslopt & SSL_OP_NO_TLSv1_2))
+    {
+	return TLS1_2_VERSION;
+    }
+#endif
+#ifdef SSL_OP_NO_TLSv1_1
+    if (!(sslopt & SSL_OP_NO_TLSv1_1))
+    {
+	return TLS1_1_VERSION;
+    }
+#endif
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


