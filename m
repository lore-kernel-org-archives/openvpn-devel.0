From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 14 Oct 2021 02:04:42 +0300
Message-Id: <20211013230442.305-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 3/3] config-msvc.h: fix OpenSSL-related
 defines
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
keys. Also few others were missing.

Compare with MinGW-generated config.h, which uses the same OpenSSL version.
Remove unneeded defines and add missing ones.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 config-msvc.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index f199bb2c..a39eeed8 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -84,13 +84,16 @@
 #define HAVE_HMAC_CTX_NEW 1
 #define HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB_USERDATA 1
 #define HAVE_SSL_CTX_GET_DEFAULT_PASSWD_CB 1
+#define HAVE_SSL_CTX_NEW 1
+#define HAVE_SSL_CTX_SET_SECURITY_LEVEL 1
 #define HAVE_X509_GET0_PUBKEY 1
 #define HAVE_X509_STORE_GET0_OBJECTS 1
 #define HAVE_X509_OBJECT_FREE 1
 #define HAVE_X509_OBJECT_GET_TYPE 1
+#define HAVE_X509_GET0_NOTAFTER 1
+#define HAVE_X509_GET0_NOTBEFORE 1
 #define HAVE_EVP_PKEY_GET0_RSA 1
 #define HAVE_EVP_PKEY_GET0_EC_KEY 1
-#define HAVE_EVP_PKEY_ID 1
 #define HAVE_EVP_PKEY_GET0_DSA 1
 #define HAVE_RSA_SET_FLAGS 1
 #define HAVE_RSA_GET0_KEY 1
@@ -110,8 +113,8 @@
 #define HAVE_RSA_METH_SET0_APP_DATA 1
 #define HAVE_RSA_METH_GET0_APP_DATA 1
 #define HAVE_EC_GROUP_ORDER_BITS 1
-#define OPENSSL_NO_EC 1
 #define HAVE_EVP_CIPHER_CTX_RESET 1
+
 #define HAVE_DIINSTALLDEVICE 1
 
 #define PATH_SEPARATOR     '\\'
-- 
2.23.0.windows.1


