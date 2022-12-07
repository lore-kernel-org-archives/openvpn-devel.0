Message-ID: <afaffee7-1c3a-79ad-9eca-ec7e3e5941b9@...2704...>
Date: Wed, 7 Dec 2022 01:59:34 +0100
MIME-Version: 1.0
Content-Language: de-DE, en-US
From: Marc Becker <marc.becker@...2704...>
References: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
In-Reply-To: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
Subject: [Openvpn-devel]  [PATCH 1/3] unify code paths for loading PKCS11
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

---
  src/openvpn/pkcs11.c | 12 +-----------
  1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 507af17c..b6ceb582 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -853,17 +853,7 @@ show_pkcs11_ids(
          goto cleanup;
      }

-    if (
-        (rv = pkcs11h_addProvider(
-             provider,
-             provider,
-             TRUE,
-             0,
-             FALSE,
-             0,
-             cert_private ? TRUE : FALSE
-             )) != CKR_OK
-        )
+    if (!pkcs11_addProvider(provider, TRUE, 0, cert_private ? TRUE : 
FALSE))
      {
          msg(M_FATAL, "PKCS#11: Cannot add provider '%s' %ld-'%s'", 
provider, rv, pkcs11h_getMessage(rv));
          goto cleanup;
-- 
2.38.1.windows.1

