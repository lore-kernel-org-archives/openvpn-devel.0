From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:31:17 +0200
Message-Id: <20211019183127.614175-12-arne@...1227...>
In-Reply-To: <20211019183127.614175-1-arne@...1227...>
References: <20211019183127.614175-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 11/21] [OSSL 3.0] USe EVP_MD_get0_name
 instead EV_MD_name
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

Use the new name for the function as it indicates with
get0 the ownership of the returned value

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_openssl.c | 2 +-
 src/openvpn/openssl_compat.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index b10bd7cd5..407ea4a7c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -916,7 +916,7 @@ md_kt_name(const EVP_MD *kt)
     {
         return "[null-digest]";
     }
-    return EVP_MD_name(kt);
+    return EVP_MD_get0_name(kt);
 }
 
 unsigned char
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 0893bfbb2..2aa718a33 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -751,6 +751,8 @@ int EVP_PKEY_get_group_name(EVP_PKEY *pkey, char *gname, size_t gname_sz,
 
 /** Mimics SSL_CTX_new_ex for OpenSSL < 3 */
 #if OPENSSL_VERSION_NUMBER < 0x30000000L
+#define EVP_MD_get0_name EVP_MD_name
+
 static inline SSL_CTX *
 SSL_CTX_new_ex(void *libctx, const char *propq, const SSL_METHOD *method)
 {
-- 
2.33.0


