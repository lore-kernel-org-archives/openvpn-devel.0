From: Dorian Harmans <me@...3020...>
Date: Tue, 14 Apr 2026 16:22:09 +0200
Message-ID: <20260414142209.584424-1-me@...3020...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add ARIA ciphersuite IANA name translations
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

---
 src/openvpn/ssl_util.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index c0620a4e..71fbc9e5 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -126,6 +126,8 @@ static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
     { "AES256-GCM-SHA384", "TLS-RSA-WITH-AES-256-GCM-SHA384" },
     { "AES256-SHA256", "TLS-RSA-WITH-AES-256-CBC-SHA256" },
     { "AES256-SHA", "TLS-RSA-WITH-AES-256-CBC-SHA" },
+    { "ARIA128-GCM-SHA256", "TLS-RSA-WITH-ARIA-128-GCM-SHA256" },
+    { "ARIA256-GCM-SHA384", "TLS-RSA-WITH-ARIA-256-GCM-SHA384" },
     { "CAMELLIA128-SHA256", "TLS-RSA-WITH-CAMELLIA-128-CBC-SHA256" },
     { "CAMELLIA128-SHA", "TLS-RSA-WITH-CAMELLIA-128-CBC-SHA" },
     { "CAMELLIA256-SHA256", "TLS-RSA-WITH-CAMELLIA-256-CBC-SHA256" },
@@ -139,6 +141,8 @@ static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
     { "DHE-DSS-AES256-GCM-SHA384", "TLS-DHE-DSS-WITH-AES-256-GCM-SHA384" },
     { "DHE-DSS-AES256-SHA256", "TLS-DHE-DSS-WITH-AES-256-CBC-SHA256" },
     { "DHE-DSS-AES256-SHA", "TLS-DHE-DSS-WITH-AES-256-CBC-SHA" },
+    { "DHE-DSS-ARIA128-GCM-SHA256", "TLS-DHE-DSS-WITH-ARIA-128-GCM-SHA256" },
+    { "DHE-DSS-ARIA256-GCM-SHA384", "TLS-DHE-DSS-WITH-ARIA-256-GCM-SHA384" },
     { "DHE-DSS-CAMELLIA128-SHA256", "TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA256" },
     { "DHE-DSS-CAMELLIA128-SHA", "TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA" },
     { "DHE-DSS-CAMELLIA256-SHA256", "TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA256" },
@@ -150,6 +154,8 @@ static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
     { "DHE-RSA-AES256-GCM-SHA384", "TLS-DHE-RSA-WITH-AES-256-GCM-SHA384" },
     { "DHE-RSA-AES256-SHA256", "TLS-DHE-RSA-WITH-AES-256-CBC-SHA256" },
     { "DHE-RSA-AES256-SHA", "TLS-DHE-RSA-WITH-AES-256-CBC-SHA" },
+    { "DHE-RSA-ARIA128-GCM-SHA256", "TLS-DHE-RSA-WITH-ARIA-128-GCM-SHA256" },
+    { "DHE-RSA-ARIA256-GCM-SHA384", "TLS-DHE-RSA-WITH-ARIA-256-GCM-SHA384" },
     { "DHE-RSA-CAMELLIA128-SHA256", "TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA256" },
     { "DHE-RSA-CAMELLIA128-SHA", "TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA" },
     { "DHE-RSA-CAMELLIA256-SHA256", "TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA256" },
@@ -171,6 +177,8 @@ static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
     { "ECDH-ECDSA-DES-CBC3-SHA", "TLS-ECDH-ECDSA-WITH-3DES-EDE-CBC-SHA" },
     { "ECDH-ECDSA-DES-CBC-SHA", "TLS-ECDH-ECDSA-WITH-DES-CBC-SHA" },
     { "ECDH-ECDSA-RC4-SHA", "TLS-ECDH-ECDSA-WITH-RC4-128-SHA" },
+    { "ECDHE-ARIA128-GCM-SHA256", "TLS-ECDHE-RSA-WITH-ARIA-128-GCM-SHA256" },
+    { "ECDHE-ARIA256-GCM-SHA384", "TLS-ECDHE-RSA-WITH-ARIA-256-GCM-SHA384" },
     { "ECDHE-ECDSA-AES128-GCM-SHA256", "TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256" },
     { "ECDHE-ECDSA-AES128-SHA256", "TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA256" },
     { "ECDHE-ECDSA-AES128-SHA384", "TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA384" },
@@ -179,6 +187,8 @@ static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
     { "ECDHE-ECDSA-AES256-SHA256", "TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA256" },
     { "ECDHE-ECDSA-AES256-SHA384", "TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA384" },
     { "ECDHE-ECDSA-AES256-SHA", "TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA" },
+    { "ECDHE-ECDSA-ARIA128-GCM-SHA256", "TLS-ECDHE-ECDSA-WITH-ARIA-128-GCM-SHA256" },
+    { "ECDHE-ECDSA-ARIA256-GCM-SHA384", "TLS-ECDHE-ECDSA-WITH-ARIA-256-GCM-SHA384" },
     { "ECDHE-ECDSA-CAMELLIA128-SHA256", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-128-CBC-SHA256" },
     { "ECDHE-ECDSA-CAMELLIA128-SHA", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-128-CBC-SHA" },
     { "ECDHE-ECDSA-CAMELLIA256-SHA256", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-256-CBC-SHA256" },
-- 
2.51.0


