Message-ID: <a6075e08-01ae-9868-4d7e-cd7b99557946@...2704...>
Date: Wed, 7 Dec 2022 02:10:42 +0100
MIME-Version: 1.0
Content-Language: de-DE, en-US
From: Marc Becker <marc.becker@...2704...>
References: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
In-Reply-To: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
Subject: [Openvpn-devel] [PATCH 3/3] special handling for PKCS11 providers
 on win32
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

in case of absolute library path, search origin for dependencies

---
  src/openvpn/pkcs11.c | 16 ++++++++++++++--
  1 file changed, 14 insertions(+), 2 deletions(-)

  needs https://github.com/OpenSC/pkcs11-helper/pull/59

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 6ef26eb0..65693aed 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -406,7 +406,13 @@ pkcs11_addProvider(
      {
          PKCS11H_BOOL allow_protected_auth = protected_auth;
          PKCS11H_BOOL cert_is_private = cert_private;
-
+        unsigned loader_flags = 0;
+#if defined(_WIN32)
+        if (platform_absolute_pathname(provider))
+        {
+            loader_flags = LOAD_LIBRARY_SEARCH_DEFAULT_DIRS | 
LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR;
+        }
+#endif
          if (allow_protected_auth
              && (rv = pkcs11h_setProviderProperty(provider, 
PKCS11H_PROVIDER_PROPERTY_ALLOW_PROTECTED_AUTH, &allow_protected_auth, 
sizeof(allow_protected_auth))) != CKR_OK)
          {
@@ -422,7 +428,13 @@ pkcs11_addProvider(
          {
              msg(M_WARN, "PKCS#11: Cannot set provider properties '%s' 
%ld-'%s'", provider, rv, pkcs11h_getMessage(rv));
          }
-
+#if defined(PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS)
+        if (loader_flags
+            && (rv = pkcs11h_setProviderProperty(provider, 
PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS, &loader_flags, 
sizeof(loader_flags))) != CKR_OK)
+        {
+            msg(M_WARN, "PKCS#11: Cannot set alternative loader flags 
'%s' %ld-'%s'", provider, rv, pkcs11h_getMessage(rv));
+        }
+#endif
          if ((rv = pkcs11h_initializeProvider(provider)) != CKR_OK)
          {
              pkcs11h_removeProvider(provider);
-- 
2.38.1.windows.1

