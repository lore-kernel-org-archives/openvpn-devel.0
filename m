From: Antonio Quartulli <a@...2181...>
Date: Tue,  5 Dec 2017 16:57:11 +0800
Message-Id: <20171205085711.25075-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] mbedtls: fix typ0 in comment
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

the function used to set the verify callback in mbedTLS is
actually called mbedtls_ssl_conf_verify() and it is invoked
in key_state_ssl_init().

Fix comment accordingly.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/ssl_verify_mbedtls.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
index 8b0a5ae9..2fba362f 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -48,9 +48,9 @@ typedef mbedtls_x509_crt openvpn_x509_cert_t;
  * This callback function is called when a new TLS session is being setup to
  * determine whether the remote OpenVPN peer's certificate is allowed to
  * connect. It is called for once for every certificate in the chain. The
- * callback functionality is configured in the \c init_ssl() function, which
- * calls the mbed TLS library's \c ssl_set_verify_callback() function with \c
- * verify_callback() as its callback argument.
+ * callback functionality is configured in the \c key_state_ssl_init() function,
+ * which calls the mbed TLS library's \c mbedtls_ssl_conf_verify() function with
+ * \c verify_callback() as its callback argument.
  *
  * It checks *flags and registers the certificate hash. If these steps succeed,
  * it calls the \c verify_cert() function, which performs OpenVPN-specific
-- 
2.15.1


