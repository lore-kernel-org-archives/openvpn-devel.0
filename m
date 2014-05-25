From: Steffan Karger <steffan@...1856...>
Date: Sun, 25 May 2014 21:18:19 +0200
Message-Id: <1401045501-12343-2-git-send-email-steffan@...1856...>
In-Reply-To: <1401045501-12343-1-git-send-email-steffan@...1856...>
References: <1401045501-12343-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/3] Remove function without effect
	(cipher_ok() always returned true).
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

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_openssl.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 6199e61..f471eee 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -69,12 +69,6 @@ EVP_CipherUpdate_ov (EVP_CIPHER_CTX *ctx, uint8_t *out, int *outl, uint8_t *in,
   return EVP_CipherUpdate (ctx, out, outl, in, inl);
 }
 
-static inline bool
-cipher_ok (const char* name)
-{
-  return true;
-}
-
 #ifndef EVP_CIPHER_name
 #define EVP_CIPHER_name(e)		OBJ_nid2sn(EVP_CIPHER_nid(e))
 #endif
@@ -285,7 +279,7 @@ show_available_ciphers ()
   for (nid = 0; nid < 10000; ++nid)	/* is there a better way to get the size of the nid list? */
     {
       const EVP_CIPHER *cipher = EVP_get_cipherbynid (nid);
-      if (cipher && cipher_ok (OBJ_nid2sn (nid)))
+      if (cipher)
 	{
 	  const unsigned int mode = EVP_CIPHER_mode (cipher);
 	  if (mode == EVP_CIPH_CBC_MODE
@@ -464,7 +458,7 @@ cipher_kt_get (const char *ciphername)
 
   cipher = EVP_get_cipherbyname (ciphername);
 
-  if ((NULL == cipher) || !cipher_ok (OBJ_nid2sn (EVP_CIPHER_nid (cipher))))
+  if (NULL == cipher)
     msg (M_SSLERR, "Cipher algorithm '%s' not found", ciphername);
 
   if (EVP_CIPHER_key_length (cipher) > MAX_CIPHER_KEY_LENGTH)
-- 
1.9.1


