From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 13 Feb 2020 11:55:39 +0200
Message-Id: <20200213095539.11157-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] cryptoapi.c: fix run-time check failure in
 msvc debugger
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

When using certificate without RSA_PKCS1_PSS_PADDING padding,
"saltlen" is passed unitialized to priv_enc_CNG(), which causes

 > Run-Time Check Failure #3 - The variable 'saltlen' is being used without being initialized.

in VS debugger.

Initialize saltlen (and other variable for the sake of consistence) to zero
to avoid above failure.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/cryptoapi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 1bf74fcd..30eba7b2 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -882,9 +882,9 @@ pkey_rsa_sign(EVP_PKEY_CTX *ctx, unsigned char *sig, size_t *siglen,
     EVP_MD *md = NULL;
     const wchar_t *alg = NULL;
 
-    int padding;
-    int hashlen;
-    int saltlen;
+    int padding = 0;
+    int hashlen = 0;
+    int saltlen = 0;
 
     pkey = EVP_PKEY_CTX_get0_pkey(ctx);
     if (pkey)
-- 
2.17.1


