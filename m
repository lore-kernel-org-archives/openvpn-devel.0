From: Antonio Quartulli <a@...2181...>
Date: Sun, 10 Nov 2019 14:35:24 +0100
Message-Id: <20191110133525.6069-2-a@...2181...>
In-Reply-To: <20191110133525.6069-1-a@...2181...>
References: <20191110133525.6069-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] auth.c: make cast explicit in the
 crypto API
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

mbedtls_md_get_size() returns unsigned char, while EVP_MD_size() returns
int. Results coming from both functions are normally in a uint8_t member
of the key_type struct, because it is known that 8bits are enough (also
for EVP_MD_size()).

This unexpected cast can, however, trigger unsolicited warnings.
Make the cast explicit by changing the return value of our crypto API.

Reported-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/crypto_backend.h | 2 +-
 src/openvpn/crypto_mbedtls.c | 2 +-
 src/openvpn/crypto_openssl.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index d119442f..1d206a8c 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -526,7 +526,7 @@ const char *md_kt_name(const md_kt_t *kt);
  *
  * @return              Message digest size, in bytes, or 0 if ctx was NULL.
  */
-int md_kt_size(const md_kt_t *kt);
+unsigned char md_kt_size(const md_kt_t *kt);
 
 
 /*
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 648a988e..3e77fa9e 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -823,7 +823,7 @@ md_kt_name(const mbedtls_md_info_t *kt)
     return mbedtls_md_get_name(kt);
 }
 
-int
+unsigned char
 md_kt_size(const mbedtls_md_info_t *kt)
 {
     if (NULL == kt)
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 520e40ee..a81dcfd8 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -930,10 +930,10 @@ md_kt_name(const EVP_MD *kt)
     return EVP_MD_name(kt);
 }
 
-int
+unsigned char
 md_kt_size(const EVP_MD *kt)
 {
-    return EVP_MD_size(kt);
+    return (unsigned char)EVP_MD_size(kt);
 }
 
 
-- 
2.24.0


