From: Antonio Quartulli <a@...2181...>
Date: Mon,  5 Apr 2021 10:00:06 +0200
Message-Id: <20210405080007.1665-2-a@...2181...>
In-Reply-To: <20210405080007.1665-1-a@...2181...>
References: <20210405080007.1665-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] openssl: avoid NULL pointer dereference
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

EVP_PKEY_CTX_new_id() may return NULL and for this reason we must check
its return value and bail out in case of failure.

Failing to do so, may result in NULL pointer dereferece when we
pass the returned pointer (NULL) to other functions.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/crypto_openssl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index d54ca6d2..dc6b0fa7 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1125,8 +1125,13 @@ bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)
 {
-    bool ret = false;
     EVP_PKEY_CTX *pctx = EVP_PKEY_CTX_new_id(EVP_PKEY_TLS1_PRF, NULL);
+    if (!pctx)
+    {
+        return false;
+    }
+
+    bool ret = false;
     if (!EVP_PKEY_derive_init(pctx))
     {
         goto out;
-- 
2.26.3


