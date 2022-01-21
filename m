From: selva.nair@...277...
Date: Fri, 21 Jan 2022 13:57:52 -0500
Message-Id: <20220121185752.14138-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Do not error when md_kt_size() is called
 with mdname="none"
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

From: Selva Nair <selva.nair@...277...>

An easy way to trigger this error is to run an otherwise working setup
(at say verb = 4) with increased verbosity of verb >= 7 and using a GCM 
cipher (e.g., AES-256-GCM). It will cause a fatal exit while printing the 
cipher and hmac in key2_print().

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Its actually md_get("none") called by md_kt_size("none") that
causes the error and I'm not entirely sure whether we should
instead make md_get("none") to return NULL. But that would
require all its callers to check for NULL.

 src/openvpn/crypto_openssl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 35fb0052..b93c680a 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1073,6 +1073,10 @@ md_kt_name(const char *mdname)
 unsigned char
 md_kt_size(const char *mdname)
 {
+    if (!strcmp("none", mdname))
+    {
+        return 0;
+    }
     evp_md_type *kt = md_get(mdname);
     unsigned char size =  (unsigned char)EVP_MD_size(kt);
     EVP_MD_free(kt);
-- 
2.30.2


