Message-ID: <707e6961-f15f-5500-3a6c-c6d0b5c8f051@...2704...>
Date: Wed, 7 Dec 2022 02:08:11 +0100
MIME-Version: 1.0
Content-Language: de-DE, en-US
From: Marc Becker <marc.becker@...2704...>
References: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
In-Reply-To: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
Subject: [Openvpn-devel] [PATCH 2/3] use new pkcs11-helper provider interface
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

split provider creation, property modifications and initialization.
new interface available since pkcs11-helper v1.28

---
  src/openvpn/pkcs11.c | 35 +++++++++++++++++++++++++++++++++++
  1 file changed, 35 insertions(+)

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index b6ceb582..6ef26eb0 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -396,6 +396,40 @@ pkcs11_addProvider(
          provider
          );

+#if PKCS11H_VERSION >= ((1<<16) | (28<<8) | (0<<0))
+    if ((rv = pkcs11h_registerProvider(provider)) != CKR_OK
+        || (rv = pkcs11h_setProviderProperty(provider, 
PKCS11H_PROVIDER_PROPERTY_LOCATION, provider, strlen(provider) + 1)) != 
CKR_OK)
+    {
+        msg(M_WARN, "PKCS#11: Cannot create provider '%s' %ld-'%s'", 
provider, rv, pkcs11h_getMessage(rv));
+    }
+    else
+    {
+        PKCS11H_BOOL allow_protected_auth = protected_auth;
+        PKCS11H_BOOL cert_is_private = cert_private;
+
+        if (allow_protected_auth
+            && (rv = pkcs11h_setProviderProperty(provider, 
PKCS11H_PROVIDER_PROPERTY_ALLOW_PROTECTED_AUTH, &allow_protected_auth, 
sizeof(allow_protected_auth))) != CKR_OK)
+        {
+            msg(M_WARN, "PKCS#11: Cannot enable protected 
authentication '%s' %ld-'%s'", provider, rv, pkcs11h_getMessage(rv));
+        }
+        if (private_mode != PKCS11H_PRIVATEMODE_MASK_AUTO
+            && (rv = pkcs11h_setProviderProperty(provider, 
PKCS11H_PROVIDER_PROPERTY_MASK_PRIVATE_MODE, &private_mode, 
sizeof(private_mode))) != CKR_OK)
+        {
+            msg(M_WARN, "PKCS#11: Cannot private mode '%s' %ld-'%s'", 
provider, rv, pkcs11h_getMessage(rv));
+        }
+        if (cert_is_private
+            && (rv = pkcs11h_setProviderProperty(provider, 
PKCS11H_PROVIDER_PROPERTY_CERT_IS_PRIVATE, &cert_is_private, 
sizeof(cert_is_private))) != CKR_OK)
+        {
+            msg(M_WARN, "PKCS#11: Cannot set provider properties '%s' 
%ld-'%s'", provider, rv, pkcs11h_getMessage(rv));
+        }
+
+        if ((rv = pkcs11h_initializeProvider(provider)) != CKR_OK)
+        {
+            pkcs11h_removeProvider(provider);
+        }
+    }
+    if (rv != CKR_OK)
+#else
      if (
          (rv = pkcs11h_addProvider(
               provider,
@@ -407,6 +441,7 @@ pkcs11_addProvider(
               cert_private
               )) != CKR_OK
          )
+#endif
      {
          msg(M_WARN, "PKCS#11: Cannot initialize provider '%s' 
%ld-'%s'", provider, rv, pkcs11h_getMessage(rv));
      }
-- 
2.38.1.windows.1

