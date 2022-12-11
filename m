From: Marc Becker <marc.becker@...2704...>
Date: Sun, 11 Dec 2022 20:09:13 +0100
Message-Id: <20221211190913.190-1-marc.becker@...2704...>
In-Reply-To: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
References: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
 <afaffee7-1c3a-79ad-9eca-ec7e3e5941b9@...2704...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/3] unify code path for adding PKCS#11
 providers
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

Use existing wrapper for pkcs11h_addProvider to have arguments with
"magic values" for pkcs11-helper call in a central place.

Slot event argument to pkcs11h_addProvider has NOT been a boolean for
at least 15 years.
Luckily the default is PKCS11H_SLOTEVENT_METHOD_AUTO=0=FALSE.

Signed-off-by: Marc Becker <marc.becker@...2704...>
---
v2: propper commit message, error message without error code reference
---
 src/openvpn/pkcs11.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 507af17c..fbc4c472 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -853,19 +853,9 @@ show_pkcs11_ids(
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
+    if (!pkcs11_addProvider(provider, TRUE, 0, cert_private ? TRUE : FALSE))
     {
-        msg(M_FATAL, "PKCS#11: Cannot add provider '%s' %ld-'%s'", provider, rv, pkcs11h_getMessage(rv));
+        msg(M_FATAL, "Failed to add PKCS#11 provider '%s", provider);
         goto cleanup;
     }
 
-- 
2.38.1.windows.1


