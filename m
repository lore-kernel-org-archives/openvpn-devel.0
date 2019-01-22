From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 22 Jan 2019 15:34:20 +0200
Message-Id: <1548164060-13144-1-git-send-email-lstipakov@...277...>
In-Reply-To: <e5ec298b-cd2e-ee95-955e-56df133e0ef8@...1227...>
References: <e5ec298b-cd2e-ee95-955e-56df133e0ef8@...1227...>
Subject: [Openvpn-devel] [PATCH v2] test_tls_crypt.c: fix
 global-buffer-overflow found by AddressSanitizer
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

From: Lev Stipakov <lev@...515...>

When writing data to buffer we incorrectly specify source length
 - sizeof for pointer returns 8, but actual buffer length is 1.

Fix by replacing empty global string to local string literal and
specifying the correct length.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 v2: use strlen(), fix misleading comments

 tests/unit_tests/openvpn/test_tls_crypt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index b793a7a..17f7d89 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -49,8 +49,6 @@
 #define PARAM1      "param1"
 #define PARAM2      "param two"
 
-static const char *plaintext_short = "";
-
 static const char *test_server_key = \
         "-----BEGIN OpenVPN tls-crypt-v2 server key-----\n"
         "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
@@ -148,10 +146,12 @@ test_tls_crypt_setup(void **state) {
     ctx->unwrapped = alloc_buf(TESTBUF_SIZE);
 
     /* Write test plaintext */
-    buf_write(&ctx->source, plaintext_short, sizeof(plaintext_short));
+    const char *plaintext = "1234567890";
+    buf_write(&ctx->source, plaintext, strlen(plaintext));
 
-    /* Write dummy opcode and session id */
-    buf_write(&ctx->ciphertext, "012345678", 1 + 8);
+    /* Write test ciphertext */
+    const char *ciphertext = "012345678";
+    buf_write(&ctx->ciphertext, ciphertext, strlen(ciphertext));
 
     return 0;
 }
-- 
2.7.4


