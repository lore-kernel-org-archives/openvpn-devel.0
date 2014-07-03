From: Steffan Karger <steffan@...1856...>
Date: Thu,  3 Jul 2014 23:47:45 +0200
Message-Id: <1404424065-24787-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Don't issue warning for 'translate to self'
	tls-ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

All cipher suite names supplied through --tls-cipher are translated by
OpenVPN to IANA names, to get OpenSSL and PolarSSL configuration files
compatible. OpenSSL however supports cipher suite group names, like
'DEFAULT', 'HIGH', or 'ECDH'. To make OpenVPN not complain about these,
entries translating these to themselves were added to the translation
table. However, to make OpenVPN not still complain, the deprecated-name
check has to be reversed from 'if this is a deprecated name then complain'
to 'if this is not a iana name, then complain'. Which this commit does.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index c9d2d26..adf3ae6 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -270,7 +270,8 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
           current_cipher_len = strlen(current_cipher);
 
 	  if (end_of_cipher - begin_of_cipher == current_cipher_len &&
-	      0 == memcmp (&ciphers[begin_of_cipher], cipher_pair->openssl_name, end_of_cipher - begin_of_cipher))
+	      0 != memcmp (&ciphers[begin_of_cipher], cipher_pair->iana_name,
+		  end_of_cipher - begin_of_cipher))
 	    {
 	      // Non-IANA name used, show warning
 	      msg (M_WARN, "Deprecated TLS cipher name '%s', please use IANA name '%s'", cipher_pair->openssl_name, cipher_pair->iana_name);
-- 
1.9.1


