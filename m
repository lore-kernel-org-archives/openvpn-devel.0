From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:23:26 +0200
Message-Id: <20211019182332.613155-22-arne@...1227...>
In-Reply-To: <20211019182332.613155-1-arne@...1227...>
References: <20211019182332.613155-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 15/20] [OSSL 3.0] Do not allow CTS ciphers
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

We do not support CTS algorithms (cipher text stealing) algorithms.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_openssl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index ab552efab..ac8287440 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -760,6 +760,9 @@ cipher_kt_mode_cbc(const cipher_kt_t *cipher)
 {
     return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC
            /* Exclude AEAD cipher modes, they require a different API */
+#ifdef EVP_CIPH_FLAG_CTS
+           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_CTS)
+#endif
            && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER);
 }
 
-- 
2.33.0


