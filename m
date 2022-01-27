From: selva.nair@...277...
Date: Wed, 26 Jan 2022 19:14:10 -0500
Message-Id: <20220127001410.7587-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] pkcs11_openssl.c: check
 EVP_get_digestbyname() != NULL
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

Reported-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/pkcs11_openssl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index a82b4b32..c4f88816 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -89,7 +89,14 @@ set_pss_params(CK_RSA_PKCS_PSS_PARAMS *pss_params, XKEY_SIGALG sigalg,
     pss_params->mgf = mdtypes[i].mgf_id;
 
     /* determine salt length */
-    int mdsize = EVP_MD_size(EVP_get_digestbyname(sigalg.mdname));
+    const EVP_MD *md = EVP_get_digestbyname(sigalg.mdname);
+    if (!md)
+    {
+        msg(M_WARN, "WARN: set_pss_params: EVP_get_digestbyname returned NULL "
+                    "for mdname = <%s>", sigalg.mdname);
+        goto cleanup;
+    }
+    int mdsize = EVP_MD_get_size(md);
 
     int saltlen = -1;
     if (!strcmp(sigalg.saltlen, "digest")) /* same as digest size */
-- 
2.30.2


