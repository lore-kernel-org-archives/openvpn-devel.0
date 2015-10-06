From: Steffan Karger <steffan@...1856...>
Date: Tue,  6 Oct 2015 20:38:27 +0200
Message-Id: <1444156707-14087-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] openssl: be less verbose about cipher
	translation errors
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

Translation errors are usually not a real problem, since we don't maintain
the complete list of ciphers OpenSSL supports.  So, be less verbose if we
can not find a translation.

Also, add 'translations' for commonly used negated cipher suites to
suppress messages about those completely.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c         | 21 +++++++++++----------
 src/openvpn/ssl_openssl.c |  2 +-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 54a3e09..529d14d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -232,18 +232,19 @@ static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
     {"SRP-RSA-AES-128-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-AES-128-CBC-SHA"},
     {"SRP-RSA-AES-256-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-AES-256-CBC-SHA"},
 #ifdef ENABLE_CRYPTO_OPENSSL
+    /* OpenSSL-specific group names */
     {"DEFAULT", "DEFAULT"},
     {"ALL", "ALL"},
-    {"HIGH", "HIGH"},
-    {"MEDIUM", "MEDIUM"},
-    {"LOW", "LOW"},
-    {"ECDH", "ECDH"},
-    {"ECDSA", "ECDSA"},
-    {"EDH", "EDH"},
-    {"EXP", "EXP"},
-    {"RSA", "RSA"},
-    {"kRSA", "kRSA"},
-    {"SRP", "SRP"},
+    {"HIGH", "HIGH"}, {"!HIGH", "!HIGH"},
+    {"MEDIUM", "MEDIUM"}, {"!MEDIUM", "!MEDIUM"},
+    {"LOW", "LOW"}, {"!LOW", "!LOW"},
+    {"ECDH", "ECDH"}, {"!ECDH", "!ECDH"},
+    {"ECDSA", "ECDSA"}, {"!ECDSA", "!ECDSA"},
+    {"EDH", "EDH"}, {"!EDH", "!EDH"},
+    {"EXP", "EXP"}, {"!EXP", "!EXP"},
+    {"RSA", "RSA"}, {"!RSA", "!RSA"},
+    {"kRSA", "kRSA"}, {"!kRSA", "!kRSA"},
+    {"SRP", "SRP"}, {"!SRP", "!SRP"},
 #endif
     {NULL, NULL}
 };
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index df9fa87..a38c41b 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -272,7 +272,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
           // Issue warning on missing translation
           // %.*s format specifier expects length of type int, so guarantee
           // that length is small enough and cast to int.
-          msg (M_WARN, "No valid translation found for TLS cipher '%.*s'",
+          msg (D_LOW, "No valid translation found for TLS cipher '%.*s'",
                  constrain_int(current_cipher_len, 0, 256), current_cipher);
         }
       else
-- 
2.1.4


