From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon, 26 Mar 2012 23:26:37 +0200
Message-Id: <1332797200-9295-4-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
Subject: [Openvpn-devel] [PATCH 3/6] cleanup: warnings at
	src/openvpn/httpdigest.c
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/httpdigest.c |   44 ++++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 78b8344..a011e56 100644
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
+  md_ctx_update(&md5_ctx, (uint8_t *)pszUserName, strlen(pszUserName));
+  md_ctx_update(&md5_ctx, (uint8_t *)":", 1);
+  md_ctx_update(&md5_ctx, (uint8_t *)pszRealm, strlen(pszRealm));
+  md_ctx_update(&md5_ctx, (uint8_t *)":", 1);
+  md_ctx_update(&md5_ctx, (uint8_t *)pszPassword, strlen(pszPassword));
   md_ctx_final(&md5_ctx, HA1);
   if (pszAlg && strcasecmp(pszAlg, "md5-sess") == 0)
     {
       md_ctx_init(&md5_ctx, md5_kt);
       md_ctx_update(&md5_ctx, HA1, HASHLEN);
-      md_ctx_update(&md5_ctx, ":", 1);
-      md_ctx_update(&md5_ctx, pszNonce, strlen(pszNonce));
-      md_ctx_update(&md5_ctx, ":", 1);
-      md_ctx_update(&md5_ctx, pszCNonce, strlen(pszCNonce));
+      md_ctx_update(&md5_ctx, (uint8_t *)":", 1);
+      md_ctx_update(&md5_ctx, (uint8_t *)pszNonce, strlen(pszNonce));
+      md_ctx_update(&md5_ctx, (uint8_t *)":", 1);
+      md_ctx_update(&md5_ctx, (uint8_t *)pszCNonce, strlen(pszCNonce));
       md_ctx_final(&md5_ctx, HA1);
     };
   md_ctx_cleanup(&md5_ctx);
@@ -119,12 +119,12 @@ DigestCalcResponse(
 
   /* calculate H(A2) */
   md_ctx_init(&md5_ctx, md5_kt);
-  md_ctx_update(&md5_ctx, pszMethod, strlen(pszMethod));
-  md_ctx_update(&md5_ctx, ":", 1);
-  md_ctx_update(&md5_ctx, pszDigestUri, strlen(pszDigestUri));
+  md_ctx_update(&md5_ctx, (uint8_t *)pszMethod, strlen(pszMethod));
+  md_ctx_update(&md5_ctx, (uint8_t *)":", 1);
+  md_ctx_update(&md5_ctx, (uint8_t *)pszDigestUri, strlen(pszDigestUri));
   if (strcasecmp(pszQop, "auth-int") == 0)
     {
-      md_ctx_update(&md5_ctx, ":", 1);
+      md_ctx_update(&md5_ctx, (uint8_t *)":", 1);
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
+  md_ctx_update(&md5_ctx, (uint8_t *)":", 1);
+  md_ctx_update(&md5_ctx, (uint8_t *)pszNonce, strlen(pszNonce));
+  md_ctx_update(&md5_ctx, (uint8_t *)":", 1);
   if (*pszQop)
     {
-      md_ctx_update(&md5_ctx, pszNonceCount, strlen(pszNonceCount));
-      md_ctx_update(&md5_ctx, ":", 1);
-      md_ctx_update(&md5_ctx, pszCNonce, strlen(pszCNonce));
-      md_ctx_update(&md5_ctx, ":", 1);
-      md_ctx_update(&md5_ctx, pszQop, strlen(pszQop));
-      md_ctx_update(&md5_ctx, ":", 1);
+      md_ctx_update(&md5_ctx, (uint8_t *)pszNonceCount, strlen(pszNonceCount));
+      md_ctx_update(&md5_ctx, (uint8_t *)":", 1);
+      md_ctx_update(&md5_ctx, (uint8_t *)pszCNonce, strlen(pszCNonce));
+      md_ctx_update(&md5_ctx, (uint8_t *)":", 1);
+      md_ctx_update(&md5_ctx, (uint8_t *)pszQop, strlen(pszQop));
+      md_ctx_update(&md5_ctx, (uint8_t *)":", 1);
     };
   md_ctx_update(&md5_ctx, HA2Hex, HASHHEXLEN);
   md_ctx_final(&md5_ctx, RespHash);
-- 
1.7.3.4


