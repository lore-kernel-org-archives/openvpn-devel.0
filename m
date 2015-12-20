From: Steffan Karger <steffan@...1856...>
Date: Sun, 20 Dec 2015 11:49:33 +0100
Message-Id: <1450608573-12164-1-git-send-email-steffan@...1856...>
In-Reply-To: <1450539694-20262-1-git-send-email-steffan@...1856...>
References: <1450539694-20262-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v2] cleanup: get rid of httpdigest.c type
	warnings
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

When I compile with --enable-strict, I only want to see warnings that are
relevant.  So, change httpdigest.c to use the correct type when possible
and make any remaining casts explicit.

This commit should not change behaviour.

v2: as discussed on #openvpn-devel, make colon a const uint8_t *, instead
    of uint8_t.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/httpdigest.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 78b8344..908d259 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -74,22 +74,23 @@ DigestCalcHA1(
   HASH HA1;
   md_ctx_t md5_ctx;
   const md_kt_t *md5_kt = md_kt_get("MD5");
+  const uint8_t *colon = (const uint8_t *) ":";
 
   md_ctx_init(&md5_ctx, md5_kt);
-  md_ctx_update(&md5_ctx, pszUserName, strlen(pszUserName));
-  md_ctx_update(&md5_ctx, ":", 1);
-  md_ctx_update(&md5_ctx, pszRealm, strlen(pszRealm));
-  md_ctx_update(&md5_ctx, ":", 1);
-  md_ctx_update(&md5_ctx, pszPassword, strlen(pszPassword));
+  md_ctx_update(&md5_ctx, (const uint8_t *) pszUserName, strlen(pszUserName));
+  md_ctx_update(&md5_ctx, colon, 1);
+  md_ctx_update(&md5_ctx, (const uint8_t *) pszRealm, strlen(pszRealm));
+  md_ctx_update(&md5_ctx, colon, 1);
+  md_ctx_update(&md5_ctx, (const uint8_t *) pszPassword, strlen(pszPassword));
   md_ctx_final(&md5_ctx, HA1);
   if (pszAlg && strcasecmp(pszAlg, "md5-sess") == 0)
     {
       md_ctx_init(&md5_ctx, md5_kt);
       md_ctx_update(&md5_ctx, HA1, HASHLEN);
-      md_ctx_update(&md5_ctx, ":", 1);
-      md_ctx_update(&md5_ctx, pszNonce, strlen(pszNonce));
-      md_ctx_update(&md5_ctx, ":", 1);
-      md_ctx_update(&md5_ctx, pszCNonce, strlen(pszCNonce));
+      md_ctx_update(&md5_ctx, colon, 1);
+      md_ctx_update(&md5_ctx, (const uint8_t *) pszNonce, strlen(pszNonce));
+      md_ctx_update(&md5_ctx, colon, 1);
+      md_ctx_update(&md5_ctx, (const uint8_t *) pszCNonce, strlen(pszCNonce));
       md_ctx_final(&md5_ctx, HA1);
     };
   md_ctx_cleanup(&md5_ctx);
@@ -116,15 +117,16 @@ DigestCalcResponse(
 
   md_ctx_t md5_ctx;
   const md_kt_t *md5_kt = md_kt_get("MD5");
+  const uint8_t *colon = (const uint8_t *) ":";
 
   /* calculate H(A2) */
   md_ctx_init(&md5_ctx, md5_kt);
-  md_ctx_update(&md5_ctx, pszMethod, strlen(pszMethod));
-  md_ctx_update(&md5_ctx, ":", 1);
-  md_ctx_update(&md5_ctx, pszDigestUri, strlen(pszDigestUri));
+  md_ctx_update(&md5_ctx, (const uint8_t *) pszMethod, strlen(pszMethod));
+  md_ctx_update(&md5_ctx, colon, 1);
+  md_ctx_update(&md5_ctx, (const uint8_t *) pszDigestUri, strlen(pszDigestUri));
   if (strcasecmp(pszQop, "auth-int") == 0)
     {
-      md_ctx_update(&md5_ctx, ":", 1);
+      md_ctx_update(&md5_ctx, colon, 1);
       md_ctx_update(&md5_ctx, HEntity, HASHHEXLEN);
     };
   md_ctx_final(&md5_ctx, HA2);
@@ -133,17 +135,17 @@ DigestCalcResponse(
   /* calculate response */
   md_ctx_init(&md5_ctx, md5_kt);
   md_ctx_update(&md5_ctx, HA1, HASHHEXLEN);
-  md_ctx_update(&md5_ctx, ":", 1);
-  md_ctx_update(&md5_ctx, pszNonce, strlen(pszNonce));
-  md_ctx_update(&md5_ctx, ":", 1);
+  md_ctx_update(&md5_ctx, colon, 1);
+  md_ctx_update(&md5_ctx, (const uint8_t *) pszNonce, strlen(pszNonce));
+  md_ctx_update(&md5_ctx, colon, 1);
   if (*pszQop)
     {
-      md_ctx_update(&md5_ctx, pszNonceCount, strlen(pszNonceCount));
-      md_ctx_update(&md5_ctx, ":", 1);
-      md_ctx_update(&md5_ctx, pszCNonce, strlen(pszCNonce));
-      md_ctx_update(&md5_ctx, ":", 1);
-      md_ctx_update(&md5_ctx, pszQop, strlen(pszQop));
-      md_ctx_update(&md5_ctx, ":", 1);
+      md_ctx_update(&md5_ctx, (const uint8_t *) pszNonceCount, strlen(pszNonceCount));
+      md_ctx_update(&md5_ctx, colon, 1);
+      md_ctx_update(&md5_ctx, (const uint8_t *) pszCNonce, strlen(pszCNonce));
+      md_ctx_update(&md5_ctx, colon, 1);
+      md_ctx_update(&md5_ctx, (const uint8_t *) pszQop, strlen(pszQop));
+      md_ctx_update(&md5_ctx, colon, 1);
     };
   md_ctx_update(&md5_ctx, HA2Hex, HASHHEXLEN);
   md_ctx_final(&md5_ctx, RespHash);
-- 
2.5.0


