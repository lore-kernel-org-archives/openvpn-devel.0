From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 17 Aug 2011 15:53:01 +0000
Message-Id: <1313596381-23302-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH] remove wrapper code for Windows CryptoAPI
	function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The CryptoAPI function CryptAcquireCertificatePrivateKey() was previously
unsupported in MinGW. With recent w32api headers it's now defined, mostly.
Since the code used to load the CryptoAPI DLL is prone to a DLL hijacking
attack [1], it's now a good time to get rid of wrapper completely.

Just a few macros left that may still be undefined on some
systems using the original MinGW headers.

[1] http://isc.sans.edu/diary.html?storyid=9445

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 cryptoapi.c |   43 +++++++++++++------------------------------
 1 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/cryptoapi.c b/cryptoapi.c
index 3365cd7..0ba27eb 100644
--- a/cryptoapi.c
+++ b/cryptoapi.c
@@ -40,21 +40,23 @@
 #include <ctype.h>
 #include <assert.h>
 
-#ifdef __MINGW32_VERSION
-/* MinGW w32api is incomplete when it comes to CryptoAPI, as per version 3.1
- * anyway. This is a hack around that problem. */
-#define CALG_SSL3_SHAMD5 (ALG_CLASS_HASH | ALG_TYPE_ANY | ALG_SID_SSL3SHAMD5)
+/* MinGW w32api 3.17 is still incomplete when it comes to CryptoAPI while
+ * MinGW32-w64 defines all macros used. This is a hack around that problem.
+ */
+#ifndef CERT_SYSTEM_STORE_LOCATION_SHIFT
 #define CERT_SYSTEM_STORE_LOCATION_SHIFT 16
+#endif
+#ifndef CERT_SYSTEM_STORE_CURRENT_USER_ID
 #define CERT_SYSTEM_STORE_CURRENT_USER_ID 1
+#endif
+#ifndef CERT_SYSTEM_STORE_CURRENT_USER
 #define CERT_SYSTEM_STORE_CURRENT_USER (CERT_SYSTEM_STORE_CURRENT_USER_ID << CERT_SYSTEM_STORE_LOCATION_SHIFT)
+#endif
+#ifndef CERT_STORE_READONLY_FLAG
 #define CERT_STORE_READONLY_FLAG 0x00008000
+#endif
+#ifndef CERT_STORE_OPEN_EXISTING_FLAG
 #define CERT_STORE_OPEN_EXISTING_FLAG 0x00004000
-#define CRYPT_ACQUIRE_COMPARE_KEY_FLAG 0x00000004
-static HINSTANCE crypt32dll = NULL;
-static BOOL WINAPI (*OpenVPNCryptAcquireCertificatePrivateKey) (PCCERT_CONTEXT pCert, DWORD dwFlags,
-  void *pvReserved, HCRYPTPROV *phCryptProv, DWORD *pdwKeySpec, BOOL *pfCallerFreeProv) = NULL;
-#else
-#define OpenVPNCryptAcquireCertificatePrivateKey CryptAcquireCertificatePrivateKey
 #endif
 
 /* Size of an SSL signature: MD5+SHA1 */
@@ -379,26 +381,7 @@ int SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     }
 
     /* set up stuff to use the private key */
-#ifdef __MINGW32_VERSION
-    /* MinGW w32api is incomplete when it comes to CryptoAPI, as per version 3.1
-     * anyway. This is a hack around that problem. */
-    if (crypt32dll == NULL) {
-	crypt32dll = LoadLibrary("crypt32");
-	if (crypt32dll == NULL) {
-	    CRYPTOAPIerr(CRYPTOAPI_F_LOAD_LIBRARY);
-	    goto err;
-	}
-    }
-    if (OpenVPNCryptAcquireCertificatePrivateKey == NULL) {
-	OpenVPNCryptAcquireCertificatePrivateKey = GetProcAddress(crypt32dll,
-		"CryptAcquireCertificatePrivateKey");
-	if (OpenVPNCryptAcquireCertificatePrivateKey == NULL) {
-	    CRYPTOAPIerr(CRYPTOAPI_F_GET_PROC_ADDRESS);
-	    goto err;
-	}
-    }
-#endif
-    if (!OpenVPNCryptAcquireCertificatePrivateKey(cd->cert_context, CRYPT_ACQUIRE_COMPARE_KEY_FLAG,
+    if (!CryptAcquireCertificatePrivateKey(cd->cert_context, CRYPT_ACQUIRE_COMPARE_KEY_FLAG,
 	    NULL, &cd->crypt_prov, &cd->key_spec, &cd->free_crypt_prov)) {
 	/* if we don't have a smart card reader here, and we try to access a
 	 * smart card certificate, we get:
-- 
1.7.5.4


