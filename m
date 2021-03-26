From: Arne Schwabe <arne@...1227...>
Date: Fri, 26 Mar 2021 17:05:45 +0100
Message-Id: <20210326160545.26836-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2] Always disable TLS renegotiations
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

Renegotiations have been troublesome in the past and also the recent OpenSSL
security problem (CVE-2021-3449) is only exploitable if TLS renegotiation
is enabled.

mbed TLS disables it by default and says in the documentation:

Warning: It is recommended to always disable renegotation unless you know you
need it and you know what you're doing. In the past, there have been
several issues associated with renegotiation or a poor understanding of
its properties.

TLS renegotiation can be used to restart a session with diffferent
parameters (e.g. now with client certs). This somethign that OpenVPN does
not use.

Furthermore because of all these problems, also TLS 1.3 completely
drops support for renegotiations.

Patch V2: Improve commments and commit message

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_mbedtls.c | 4 ++++
 src/openvpn/ssl_openssl.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 4626e9838..8917fb188 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1086,6 +1086,10 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
     {
         mbedtls_ssl_conf_curves(ks_ssl->ssl_config, ssl_ctx->groups);
     }
+    /* Disable TLS renegotiations. OpenVPN's renegotiation creates new SSL
+     * session and does not depend on this feature. And TLS renegotiations have
+     * been problematic in the past */
+    mbedtls_ssl_conf_renegotiation(ks_ssl->ssl_config, MBEDTLS_SSL_RENEGOTIATION_DISABLED);
 
     /* Disable record splitting (for now).  OpenVPN assumes records are sent
      * unfragmented, and changing that will require thorough review and
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d161f48b8..c311dd08e 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -320,6 +320,10 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
     sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
 #endif
     sslopt |= SSL_OP_NO_COMPRESSION;
+    /* Disable TLS renegotiations. OpenVPN's renegotiation creates new SSL
+     * session and does not depend on this feature. And TLS renegotiations have
+     * been problematic in the past */
+    sslopt |= SSL_OP_NO_RENEGOTIATION;
 
     SSL_CTX_set_options(ctx->ctx, sslopt);
 
-- 
2.30.1


