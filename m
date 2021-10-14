From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 14 Oct 2021 04:04:36 +0300
Message-Id: <20211014010436.359-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] config-msvc.h: fix OpenSSL-related defines
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Commit 2778443 ("msvc: OpenSSL 1.1.x support") added OpenSSL-related
defines to config-msvc.h, which in Linux/MinGW are set during configure step.

Turns out that OPENSSL_NO_EC was added by mistake - it breaks loading EC
keys.

Commit bc36d9d ("Remove OpenSSL configure checks") removed
abovementioned defines. Adjust config-msvc.h accordingly.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 config-msvc.h | 38 +-------------------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 97923228..b28d8742 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -41,43 +41,7 @@
 #define HAVE_IN_PKTINFO 1
 
 #define HAVE_OPENSSL_ENGINE 1
-/* hardcode usage of OpenSSL 1.1.x */
-#define HAVE_EVP_MD_CTX_RESET 1
-#define HAVE_EVP_MD_CTX_FREE 1
-#define HAVE_EVP_MD_CTX_NEW 1
-#define HAVE_HMAC_CTX_RESET 1
-#define HAVE_HMAC_CTX_FREE 1
-#define HAVE_HMAC_CTX_NEW 1
-#define HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA 1
-#define HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB 1
-#define HAVE_X509_GET0_PUBKEY 1
-#define HAVE_X509_STORE_GET0_OBJECTS 1
-#define HAVE_X509_OBJECT_FREE 1
-#define HAVE_X509_OBJECT_GET_TYPE 1
-#define HAVE_EVP_PKEY_GET0_RSA 1
-#define HAVE_EVP_PKEY_GET0_EC_KEY 1
-#define HAVE_EVP_PKEY_ID 1
-#define HAVE_EVP_PKEY_GET0_DSA 1
-#define HAVE_RSA_SET_FLAGS 1
-#define HAVE_RSA_GET0_KEY 1
-#define HAVE_RSA_SET0_KEY 1
-#define HAVE_RSA_BITS 1
-#define HAVE_DSA_GET0_PQG 1
-#define HAVE_DSA_BITS 1
-#define HAVE_RSA_METH_NEW 1
-#define HAVE_RSA_METH_FREE 1
-#define HAVE_RSA_METH_SET_PUB_ENC 1
-#define HAVE_RSA_METH_SET_PUB_DEC 1
-#define HAVE_RSA_METH_SET_PRIV_ENC 1
-#define HAVE_RSA_METH_SET_PRIV_DEC 1
-#define HAVE_RSA_METH_SET_INIT 1
-#define HAVE_RSA_METH_SET_SIGN 1
-#define HAVE_RSA_METH_SET_FINISH 1
-#define HAVE_RSA_METH_SET0_APP_DATA 1
-#define HAVE_RSA_METH_GET0_APP_DATA 1
-#define HAVE_EC_GROUP_ORDER_BITS 1
-#define OPENSSL_NO_EC 1
-#define HAVE_EVP_CIPHER_CTX_RESET 1
+
 #define HAVE_DIINSTALLDEVICE 1
 
 #ifndef __cplusplus
-- 
2.23.0.windows.1


