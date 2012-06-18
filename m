From: Arne Schwabe <arne@...1227...>
Date: Mon, 18 Jun 2012 20:39:09 +0200
Message-Id: <1340044749-10694-7-git-send-email-arne@...1227...>
In-Reply-To: <1340044749-10694-1-git-send-email-arne@...1227...>
References: <1340044749-10694-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 6/6] Fix clang warnings for conversion from
	unsigned<->signed
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


Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/httpdigest.c |   44 ++++++++++++++++++++++----------------------
 src/openvpn/ntlm.c       |    8 ++++----
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 78b8344..61d4280 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -76,20 +76,20 @@ DigestCalcHA1(
   const md_kt_t *md5_kt = md_kt_get("MD5");
 
   md_ctx_init(&md5_ctx, md5_kt);
-  md_ctx_update(&md5_ctx, pszUserName, strlen(pszUserName));
-  md_ctx_update(&md5_ctx, ":", 1);
-  md_ctx_update(&md5_ctx, pszRealm, strlen(pszRealm));
-  md_ctx_update(&md5_ctx, ":", 1);
-  md_ctx_update(&md5_ctx, pszPassword, strlen(pszPassword));
+  md_ctx_update(&md5_ctx, (const uint8_t*) pszUserName, strlen(pszUserName));
+  md_ctx_update(&md5_ctx, (const uint8_t*) ":", 1);
+  md_ctx_update(&md5_ctx, (const uint8_t*) pszRealm, strlen(pszRealm));
+  md_ctx_update(&md5_ctx, (const uint8_t*) ":", 1);
+  md_ctx_update(&md5_ctx, (const uint8_t*) pszPassword, strlen(pszPassword));
   md_ctx_final(&md5_ctx, HA1);
   if (pszAlg && strcasecmp(pszAlg, "md5-sess") == 0)
     {
       md_ctx_init(&md5_ctx, md5_kt);
       md_ctx_update(&md5_ctx, HA1, HASHLEN);
-      md_ctx_update(&md5_ctx, ":", 1);
-      md_ctx_update(&md5_ctx, pszNonce, strlen(pszNonce));
-      md_ctx_update(&md5_ctx, ":", 1);
-      md_ctx_update(&md5_ctx, pszCNonce, strlen(pszCNonce));
+      md_ctx_update(&md5_ctx, (const uint8_t*) ":", 1);
+      md_ctx_update(&md5_ctx, (const uint8_t*) pszNonce, strlen(pszNonce));
+      md_ctx_update(&md5_ctx, (const uint8_t*) ":", 1);
+      md_ctx_update(&md5_ctx, (const uint8_t*) pszCNonce, strlen(pszCNonce));
       md_ctx_final(&md5_ctx, HA1);
     };
   md_ctx_cleanup(&md5_ctx);
@@ -119,12 +119,12 @@ DigestCalcResponse(
 
   /* calculate H(A2) */
   md_ctx_init(&md5_ctx, md5_kt);
-  md_ctx_update(&md5_ctx, pszMethod, strlen(pszMethod));
-  md_ctx_update(&md5_ctx, ":", 1);
-  md_ctx_update(&md5_ctx, pszDigestUri, strlen(pszDigestUri));
+  md_ctx_update(&md5_ctx, (const uint8_t*) pszMethod, strlen(pszMethod));
+  md_ctx_update(&md5_ctx, (const uint8_t*) ":", 1);
+  md_ctx_update(&md5_ctx, (const uint8_t*) pszDigestUri, strlen(pszDigestUri));
   if (strcasecmp(pszQop, "auth-int") == 0)
     {
-      md_ctx_update(&md5_ctx, ":", 1);
+      md_ctx_update(&md5_ctx, (const uint8_t*) ":", 1);
       md_ctx_update(&md5_ctx, HEntity, HASHHEXLEN);
     };
   md_ctx_final(&md5_ctx, HA2);
@@ -133,17 +133,17 @@ DigestCalcResponse(
   /* calculate response */
   md_ctx_init(&md5_ctx, md5_kt);
   md_ctx_update(&md5_ctx, HA1, HASHHEXLEN);
-  md_ctx_update(&md5_ctx, ":", 1);
-  md_ctx_update(&md5_ctx, pszNonce, strlen(pszNonce));
-  md_ctx_update(&md5_ctx, ":", 1);
+  md_ctx_update(&md5_ctx, (const uint8_t*) ":", 1);
+  md_ctx_update(&md5_ctx, (const uint8_t*) pszNonce, strlen(pszNonce));
+  md_ctx_update(&md5_ctx, (const uint8_t*) ":", 1);
   if (*pszQop)
     {
-      md_ctx_update(&md5_ctx, pszNonceCount, strlen(pszNonceCount));
-      md_ctx_update(&md5_ctx, ":", 1);
-      md_ctx_update(&md5_ctx, pszCNonce, strlen(pszCNonce));
-      md_ctx_update(&md5_ctx, ":", 1);
-      md_ctx_update(&md5_ctx, pszQop, strlen(pszQop));
-      md_ctx_update(&md5_ctx, ":", 1);
+      md_ctx_update(&md5_ctx, (const uint8_t*) pszNonceCount, strlen(pszNonceCount));
+      md_ctx_update(&md5_ctx, (const uint8_t*) ":", 1);
+      md_ctx_update(&md5_ctx, (const uint8_t*) pszCNonce, strlen(pszCNonce));
+      md_ctx_update(&md5_ctx, (const uint8_t*) ":", 1);
+      md_ctx_update(&md5_ctx, (const uint8_t*) pszQop, strlen(pszQop));
+      md_ctx_update(&md5_ctx, (const uint8_t*) ":", 1);
     };
   md_ctx_update(&md5_ctx, HA2Hex, HASHHEXLEN);
   md_ctx_final(&md5_ctx, RespHash);
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 3390bdd..c7cf3d4 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -77,9 +77,9 @@ gen_md4_hash (const char* data, int data_len, char *result)
 {
   /* result is 16 byte md4 hash */
   const md_kt_t *md4_kt = md_kt_get("MD4");
-  char md[MD4_DIGEST_LENGTH];
+  unsigned char md[MD4_DIGEST_LENGTH];
 
-  md_full(md4_kt, data, data_len, md);
+  md_full(md4_kt, (const uint8_t*) data, data_len, md);
   memcpy (result, md, MD4_DIGEST_LENGTH);
 }
 
@@ -90,7 +90,7 @@ gen_hmac_md5 (const char* data, int data_len, const char* key, int key_len,char
 	hmac_ctx_t hmac_ctx;
 	CLEAR(hmac_ctx);
 
-	hmac_ctx_init(&hmac_ctx, key, key_len, md5_kt);
+	hmac_ctx_init(&hmac_ctx, (const uint8_t*) key, key_len, md5_kt);
 	hmac_ctx_update(&hmac_ctx, (const unsigned char *)data, data_len);
 	hmac_ctx_final(&hmac_ctx, (unsigned char *)result);
 	hmac_ctx_cleanup(&hmac_ctx);
@@ -197,7 +197,7 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
   unsigned char phase3[464];
 
   char md4_hash[MD4_DIGEST_LENGTH+5];
-  char challenge[8], ntlm_response[24];
+  unsigned char challenge[8], ntlm_response[24];
   int i, ret_val;
 
 	char ntlmv2_response[144];
-- 
1.7.7.5 (Apple Git-26)


