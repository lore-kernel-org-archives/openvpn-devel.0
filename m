From: selva.nair@...277...
Date: Tue,  9 May 2023 13:05:17 -0400
Message-Id: <20230509170517.2637245-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Bugfix: dangling pointer passed to
 pkcs11-helper
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

Github: Fixes OpenVPN/openvpn#323

Signed-off-by: Selva Nair <selva.nair@...277...>
---
This will fix #323 is my best guess, untested as yet..
This is a bug that needs fixing, regardless.
 
 src/openvpn/pkcs11_openssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index eee86e17..9b0ab39f 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -165,6 +165,7 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
 {
     pkcs11h_certificate_t cert = handle;
     CK_MECHANISM mech = {CKM_RSA_PKCS, NULL, 0}; /* default value */
+    CK_RSA_PKCS_PSS_PARAMS pss_params = {0};
 
     unsigned char buf[EVP_MAX_MD_SIZE];
     size_t buflen;
@@ -203,7 +204,6 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
         }
         else if (!strcmp(sigalg.padmode, "pss"))
         {
-            CK_RSA_PKCS_PSS_PARAMS pss_params = {0};
             mech.mechanism = CKM_RSA_PKCS_PSS;
 
             if (!set_pss_params(&pss_params, sigalg, cert))
-- 
2.34.1


