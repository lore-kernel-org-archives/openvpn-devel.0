From: Gert Doering <gert@...1296...>
Date: Tue, 11 Nov 2025 18:24:57 +0100
Message-ID: <20251111172504.7683-1-gert@...1296...>
In-Reply-To: <gerrit.1762865473000.I13e34119303e056fdb51ff9925f4944171c824f2@...2715...>
References: <gerrit.1762865473000.I13e34119303e056fdb51ff9925f4944171c824f2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] msvc: fix struct initialization for v19
 compilers
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

From: Heiko Hund <heiko@...2662...>

Newer version of MSVC do not show the error anymore, but I do get, e.g.:

  test_crypto.c(538,23): error C2059: syntax error: '}'

with version 19.38.33133 installed on a test system.

Change-Id: I13e34119303e056fdb51ff9925f4944171c824f2
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1366
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1366
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 9e2aa19..80ef837 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -230,7 +230,7 @@
      * headers and footer */
     struct buffer pem = alloc_buf_gc(cert->raw.len * 3 + 100, &gc);
 
-    struct buffer der = {};
+    struct buffer der = { 0 };
     buf_set_read(&der, cert->raw.p, cert->raw.len);
 
     if (!crypto_pem_encode("CERTIFICATE", &pem, &der, &gc))
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 93dfa42..ba386bd 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -535,7 +535,7 @@
                         0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67, 0x76, 0xaf, 0xdb,
                         0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0xcb, 0x04 };
 
-    uint8_t info[] = {};
+    uint8_t info[] = { 0 };
 
     int L = 42;
     uint8_t okm[42] = { 0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x80,
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 81d2280..44bfa1d 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -411,7 +411,7 @@
 test_tls_ctx_use_pkcs11(void **state)
 {
     (void)state;
-    struct tls_root_ctx tls_ctx = {};
+    struct tls_root_ctx tls_ctx = { 0 };
     uint8_t sha1[HASHSIZE];
     for (struct test_cert *c = certs; c->cert; c++)
     {

