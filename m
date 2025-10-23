From: Gert Doering <gert@...1296...>
Date: Thu, 23 Oct 2025 17:35:08 +0200
Message-ID: <20251023153514.18691-1-gert@...1296...>
In-Reply-To: <gerrit.1761218398000.Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d@...2715...>
References: <gerrit.1761218398000.Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Do not try to use the encrypt-then-mac
 ciphers from OpenSSL 3.6.0
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

From: Arne Schwabe <arne@...1227...>

These ciphers claim to be CBC but since they are also include an HMAC
are more a mix of AEAD and CBC. Nevertheless, we do not support these
and also have no (good) reason to support them.

Change-Id: Iafe3c94b952cd3fbecf6f3d05816e5859f425e7d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1295
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1295
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 331af99..280389c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -798,7 +798,8 @@
 #ifdef EVP_CIPH_FLAG_CTS
                           && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_CTS)
 #endif
-                          && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER));
+                          && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER)
+                          && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_ENC_THEN_MAC));
     EVP_CIPHER_free(cipher);
     return ret;
 }
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index c9fa719..03ece13 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -817,4 +817,9 @@
 
 #endif /* OPENSSL_VERSION_NUMBER < 0x30000000L */
 
+/* Introduced in OpenSSL 3.6.0 */
+#ifndef EVP_CIPH_FLAG_ENC_THEN_MAC
+#define EVP_CIPH_FLAG_ENC_THEN_MAC 0x10000000
+#endif
+
 #endif /* OPENSSL_COMPAT_H_ */

