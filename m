From: Steffan Karger <steffan@...1856...>
Date: Sat,  1 Mar 2014 15:36:14 +0100
Message-Id: <1393684575-28112-2-git-send-email-steffan@...1856...>
In-Reply-To: <1393684575-28112-1-git-send-email-steffan@...1856...>
References: <1393684575-28112-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] Add openssl-specific common cipher list
	names to ssl.c.
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

This adds a number of commonly used cipher list names to ssl.c, which makes
OpenVPN not give a "translation not found" warning when using these.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c61701a..d4acc0f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -235,6 +235,19 @@ static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
     {"SRP-RSA-3DES-EDE-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-3DES-EDE-CBC-SHA"},
     {"SRP-RSA-AES-128-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-AES-128-CBC-SHA"},
     {"SRP-RSA-AES-256-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-AES-256-CBC-SHA"},
+#ifdef ENABLE_CRYPTO_OPENSSL
+    {"DEFAULT", "DEFAULT"},
+    {"ALL", "ALL"},
+    {"HIGH", "HIGH"},
+    {"MEDIUM", "MEDIUM"},
+    {"LOW", "LOW"},
+    {"ECDH", "ECDH"},
+    {"ECDSA", "ECDSA"},
+    {"EDH", "EDH"},
+    {"EXP", "EXP"},
+    {"RSA", "RSA"},
+    {"SRP", "SRP"},
+#endif
     {NULL, NULL}
 };
 
-- 
1.8.3.2


