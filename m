From: Gert Doering <gert@...1296...>
Date: Mon,  8 Mar 2021 12:44:05 +0100
Message-Id: <20210308114405.19066-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix EVP_PKEY_CTX_... compilation with
 LibreSSL
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

Commit 06f6cf3ff850f29 introduced use of newer OpenSSL functions
for the TLS 1.0-1.1 PRF, to make OpenVPN work with FIPS-enabled OpenSSL.

LibreSSL masquerades as "very new OpenSSL" but does not have these
functions (or at least not on the OpenBSD system tested), so compilationg
breaks.

Add a "but not if LibreSSL" check to the OpenSSL version check, as we
do in other places.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/crypto_openssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 7aaa6624..49698e4b 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -51,7 +51,7 @@
 #include <openssl/rand.h>
 #include <openssl/ssl.h>
 
-#if OPENSSL_VERSION_NUMBER >= 0x10100000L
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(LIBRESSL_VERSION_NUMBER)
 #include <openssl/kdf.h>
 #endif
 
@@ -1128,7 +1128,7 @@ engine_load_key(const char *file, SSL_CTX *ctx)
 #endif /* if HAVE_OPENSSL_ENGINE */
 }
 
-#if OPENSSL_VERSION_NUMBER >= 0x10100000L
+#if (OPENSSL_VERSION_NUMBER >= 0x10100000L) && !defined(LIBRESSL_VERSION_NUMBER)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)
-- 
2.21.0


