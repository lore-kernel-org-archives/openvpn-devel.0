From: Arne Schwabe <arne@...1227...>
Date: Wed, 18 Aug 2021 23:33:53 +0200
Message-Id: <20210818213354.687736-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Detect unusable ciphers on patched
 OpenSSL of RHEL/Centos
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

OpenSSL on RHEL 8 and CentOS 8 system when these system are put into
FIPS mode need extra code to figure out if a specific cipher algorithm
is usable on these system. This is particularly problem in data-ciphers
as the errors might occur much later when a client connects and as these
cipher are not caught during config initialisation.

This also prepares for adding Chacha20-Poly1305 when available to
data-ciphers by making the detection logic used to check if
cipher_kt_get returns non-NULL work on these systems.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c         |  6 ++++++
 src/openvpn/crypto_openssl.c | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index b9c95225a..1dfc760f9 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1806,6 +1806,12 @@ print_cipher(const cipher_kt_t *cipher)
     {
         printf(", TLS client/server mode only");
     }
+#ifdef OPENSSL_FIPS
+    if (FIPS_mode() && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_FIPS))
+    {
+        printf(", disabled by FIPS mode");
+    }
+#endif
 
     printf(")\n");
 }
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index b55d32b2c..419265a51 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -599,7 +599,17 @@ cipher_kt_get(const char *ciphername)
         return NULL;
     }
 
+#ifdef OPENSSL_FIPS
+    /* Rhel 8/CentOS 8 have a patched OpenSSL version that return a cipher
+     * here that is actually not usable if in FIPS mode */
 
+    if (FIPS_mode() && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_FIPS))
+    {
+        msg(D_LOW, "Cipher algorithm '%s' is known by OpenSSL library but "
+                    "currently disabled by running in FIPS mode.", ciphername);
+        return NULL;
+    }
+#endif
     if (EVP_CIPHER_key_length(cipher) > MAX_CIPHER_KEY_LENGTH)
     {
         msg(D_LOW, "Cipher algorithm '%s' uses a default key size (%d bytes) "
-- 
2.32.0


