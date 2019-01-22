From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 22 Jan 2019 13:02:48 +0200
Message-Id: <1548154968-13019-2-git-send-email-lstipakov@...277...>
In-Reply-To: <1548154968-13019-1-git-send-email-lstipakov@...277...>
References: <1548154968-13019-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] test_tls_crypt.c: fix
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
 tests/unit_tests/openvpn/test_tls_crypt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index b793a7a..b4ce03d 100644
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
@@ -148,7 +146,7 @@ test_tls_crypt_setup(void **state) {
     ctx->unwrapped = alloc_buf(TESTBUF_SIZE);
 
     /* Write test plaintext */
-    buf_write(&ctx->source, plaintext_short, sizeof(plaintext_short));
+    buf_write(&ctx->source, "1234567890", 10);
 
     /* Write dummy opcode and session id */
     buf_write(&ctx->ciphertext, "012345678", 1 + 8);
-- 
2.7.4


