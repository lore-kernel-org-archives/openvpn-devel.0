From: Juliusz Sosinowicz <juliusz@...2525...>
Date: Fri, 12 Mar 2021 16:06:29 +0100
Message-Id: <20210312150629.57302-1-juliusz@...2525...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] EVP_DigestSignFinal siglen parameter
 correction
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

In the EVP_DigestSignFinal API, "before the call the siglen parameter should contain the length of the sig buffer".

Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
---
 src/openvpn/crypto_openssl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 49698e4b3..4486d246d 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1195,7 +1195,7 @@ tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
     EVP_MD_CTX ctx, ctx_tmp, ctx_init;
     EVP_PKEY *mac_key;
     unsigned char A1[EVP_MAX_MD_SIZE];
-    size_t A1_len;
+    size_t A1_len = EVP_MAX_MD_SIZE;
     int ret = false;
 
     chunk = EVP_MD_size(md);
@@ -1249,6 +1249,7 @@ tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
 
         if (olen > chunk)
         {
+            j = olen;
             if (!EVP_DigestSignFinal(&ctx, out, &j))
             {
                 goto err;
@@ -1263,6 +1264,7 @@ tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
         }
         else
         {
+            A1_len = EVP_MAX_MD_SIZE;
             /* last one */
             if (!EVP_DigestSignFinal(&ctx, A1, &A1_len))
             {
-- 
2.25.1


