From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:23:12 +0200
Message-Id: <20211019182332.613155-8-arne@...1227...>
In-Reply-To: <20211019182332.613155-1-arne@...1227...>
References: <20211019182332.613155-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 06/20] [OSSL 3.0] Deprecate --ecdh-curve
 with OpenSSL 3.0 and adjust mbed TLS message
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

OpenSSL 3.0 deprecates SSL_CTX_set_tmp_ecdh() in favour of
SSL_CTX_set1_groups(3). We already support the SSL_CTX_set1_groups
using the --tls-groups. Adjust both mbed TLS and OpenSSL 3.0 to
say that --ecdh-curve is ingored and --tls-groups should be used.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_mbedtls.c |  5 +++--
 src/openvpn/ssl_openssl.c | 12 +++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index cea88f41e..e7c45c099 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -440,8 +440,9 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
 {
     if (NULL != curve_name)
     {
-        msg(M_WARN, "WARNING: mbed TLS builds do not support specifying an ECDH "
-            "curve, using default curves.");
+        msg(M_WARN, "WARNING: mbed TLS builds do not support specifying an "
+            "ECDH curve with --ecdh-curve, using default curves. Use "
+            "--tls-groups to specify curves.");
     }
 }
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a44d4f85c..92d8d0eeb 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -709,10 +709,16 @@ tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
 }
 
 void
-tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
-                         )
+tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name)
 {
-#ifndef OPENSSL_NO_EC
+#if OPENSSL_VERSION_NUMBER >= 0x30000000L
+    if (curve_name != NULL)
+    {
+        msg(M_WARN, "WARNING: OpenSSL 3.0+ builds do not support specifying an "
+                    "ECDH curve with --ecdh-curve, using default curves. Use "
+                    "--tls-groups to specify groups.");
+    }
+#elif !defined(OPENSSL_NO_EC)
     int nid = NID_undef;
     EC_KEY *ecdh = NULL;
     const char *sname = NULL;
-- 
2.33.0


