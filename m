From: Dorian Harmans <dorian@...2138...>
Date: Fri, 13 May 2016 18:44:52 +0200
Message-Id: <1463157892-701-1-git-send-email-dorian@...2138...>
Subject: [Openvpn-devel] [PATCH] Add CHACHA20-POLY1305 ciphersuite IANA name
	translations.
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
Cc: Dorian Harmans <dorian@...2138...>

---
 src/openvpn/ssl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index ddd0c9b..4291314 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -146,6 +146,7 @@ static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
     {"DHE-RSA-CAMELLIA128-SHA", "TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA"},
     {"DHE-RSA-CAMELLIA256-SHA256", "TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA256"},
     {"DHE-RSA-CAMELLIA256-SHA", "TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA"},
+    {"DHE-RSA-CHACHA20-POLY1305", "TLS-DHE-RSA-WITH-CHACHA20-POLY1305-SHA256"},
     {"DHE-RSA-SEED-SHA", "TLS-DHE-RSA-WITH-SEED-CBC-SHA"},
     {"DH-RSA-SEED-SHA", "TLS-DH-RSA-WITH-SEED-CBC-SHA"},
     {"ECDH-ECDSA-AES128-GCM-SHA256", "TLS-ECDH-ECDSA-WITH-AES-128-GCM-SHA256"},
@@ -174,6 +175,7 @@ static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
     {"ECDHE-ECDSA-CAMELLIA128-SHA", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-128-CBC-SHA"},
     {"ECDHE-ECDSA-CAMELLIA256-SHA256", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-256-CBC-SHA256"},
     {"ECDHE-ECDSA-CAMELLIA256-SHA", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-256-CBC-SHA"},
+    {"ECDHE-ECDSA-CHACHA20-POLY1305", "TLS-ECDHE-ECDSA-WITH-CHACHA20-POLY1305-SHA256"},
     {"ECDHE-ECDSA-DES-CBC3-SHA", "TLS-ECDHE-ECDSA-WITH-3DES-EDE-CBC-SHA"},
     {"ECDHE-ECDSA-DES-CBC-SHA", "TLS-ECDHE-ECDSA-WITH-DES-CBC-SHA"},
     {"ECDHE-ECDSA-RC4-SHA", "TLS-ECDHE-ECDSA-WITH-RC4-128-SHA"},
@@ -189,6 +191,7 @@ static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
     {"ECDHE-RSA-CAMELLIA128-SHA", "TLS-ECDHE-RSA-WITH-CAMELLIA-128-CBC-SHA"},
     {"ECDHE-RSA-CAMELLIA256-SHA256", "TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-SHA256"},
     {"ECDHE-RSA-CAMELLIA256-SHA", "TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-SHA"},
+    {"ECDHE-RSA-CHACHA20-POLY1305", "TLS-ECDHE-RSA-WITH-CHACHA20-POLY1305-SHA256"},
     {"ECDHE-RSA-DES-CBC3-SHA", "TLS-ECDHE-RSA-WITH-3DES-EDE-CBC-SHA"},
     {"ECDHE-RSA-DES-CBC-SHA", "TLS-ECDHE-RSA-WITH-DES-CBC-SHA"},
     {"ECDHE-RSA-RC4-SHA", "TLS-ECDHE-RSA-WITH-RC4-128-SHA"},
-- 
2.7.4


