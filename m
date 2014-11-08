Message-ID: <545DED2C.5070002@...1856...>
Date: Sat, 08 Nov 2014 11:15:08 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1415312819-16048-1-git-send-email-steffan@...1856...>
In-Reply-To: <1415312819-16048-1-git-send-email-steffan@...1856...>
Content-Type: multipart/mixed; boundary="------------090000010506090703010303"
Subject: Re: [Openvpn-devel] [PATCH] Fix assertion error when using --cipher
	none
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090000010506090703010303
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit


On 06-11-14 23:26, Steffan Karger wrote:
> Some commits ago, the cipher mode checks were cleaned up to
> remove code duplication (and fix the issue in #471), but broke
> '--cipher none' (reported in #473). This commit fixes that.

Attached a v2 of this patch that removes the (inconsistent) renaming of
the cipher_kt_mode() parameter. Otherwise this patch is the same.

-Steffan

--------------090000010506090703010303
Content-Type: text/x-patch;
	name="0001-Fix-assertion-error-when-using-cipher-none.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Fix-assertion-error-when-using-cipher-none.patch"

From 1fed00bc54bb9b774bdd7d522a80d0ec83effdfd Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Sat, 8 Nov 2014 11:03:52 +0100
Subject: [PATCH] Fix assertion error when using --cipher none

Some commits ago, the cipher mode checks were cleaned up to
remove code duplication (and fix the issue in #471), but broke
'--cipher none' (reported in #473). This commit fixes that.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_backend.h  | 6 +++---
 src/openvpn/crypto_openssl.c  | 4 ++--
 src/openvpn/crypto_polarssl.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index bc067a7..8749878 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -223,7 +223,7 @@ int cipher_kt_block_size (const cipher_kt_t *cipher_kt);
 /**
  * Returns the mode that the cipher runs in.
  *
- * @param cipher_kt 	Static cipher parameters
+ * @param cipher_kt	Static cipher parameters. May not be NULL.
  *
  * @return 		Cipher mode, either \c OPENVPN_MODE_CBC, \c
  * 			OPENVPN_MODE_OFB or \c OPENVPN_MODE_CFB
@@ -233,7 +233,7 @@ int cipher_kt_mode (const cipher_kt_t *cipher_kt);
 /**
  * Check if the supplied cipher is a supported CBC mode cipher.
  *
- * @param cipher	Static cipher parameters. May not be NULL.
+ * @param cipher	Static cipher parameters.
  *
  * @return		true iff the cipher is a CBC mode cipher.
  */
@@ -243,7 +243,7 @@ bool cipher_kt_mode_cbc(const cipher_kt_t *cipher)
 /**
  * Check if the supplied cipher is a supported OFB or CFB mode cipher.
  *
- * @param cipher	Static cipher parameters. May not be NULL.
+ * @param cipher	Static cipher parameters.
  *
  * @return		true iff the cipher is a OFB or CFB mode cipher.
  */
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index cc00a7d..9d5fe7c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -519,7 +519,7 @@ cipher_kt_mode (const EVP_CIPHER *cipher_kt)
 bool
 cipher_kt_mode_cbc(const cipher_kt_t *cipher)
 {
-  return cipher_kt_mode(cipher) == OPENVPN_MODE_CBC
+  return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC
 #ifdef EVP_CIPH_FLAG_AEAD_CIPHER
       /* Exclude AEAD cipher modes, they require a different API */
       && !(EVP_CIPHER_flags(cipher) & EVP_CIPH_FLAG_AEAD_CIPHER)
@@ -530,7 +530,7 @@ cipher_kt_mode_cbc(const cipher_kt_t *cipher)
 bool
 cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
 {
-  return (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB ||
+  return cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB ||
 	  cipher_kt_mode(cipher) == OPENVPN_MODE_CFB)
 #ifdef EVP_CIPH_FLAG_AEAD_CIPHER
       /* Exclude AEAD cipher modes, they require a different API */
diff --git a/src/openvpn/crypto_polarssl.c b/src/openvpn/crypto_polarssl.c
index 68e350d..c038f8e 100644
--- a/src/openvpn/crypto_polarssl.c
+++ b/src/openvpn/crypto_polarssl.c
@@ -447,13 +447,13 @@ cipher_kt_mode (const cipher_info_t *cipher_kt)
 bool
 cipher_kt_mode_cbc(const cipher_kt_t *cipher)
 {
-  return cipher_kt_mode(cipher) == OPENVPN_MODE_CBC;
+  return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC;
 }
 
 bool
 cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
 {
-  return (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB ||
+  return cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB ||
 	  cipher_kt_mode(cipher) == OPENVPN_MODE_CFB);
 }
 
-- 
1.9.1


--------------090000010506090703010303--

