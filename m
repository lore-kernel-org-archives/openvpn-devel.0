From: Marc Becker <marc.becker@...2704...>
Date: Sun, 11 Dec 2022 21:01:08 +0100
Message-Id: <20221211200108.1402-1-marc.becker@...2704...>
In-Reply-To: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
References: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 3/3] special handling for PKCS11
 providers on win32
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

Change win32 dynamic loader behavior when supplying an absolute path.
The DLL location is considered/preferred to resolve dependencies.
Support in pkcs11-helper for loader flag is detected at compile time.

3rd party DLLs and additional dependencies do no longer need to be moved
to the OpenVPN directory or require changes to %PATH% configuration.

Signed-off-by: Marc Becker <marc.becker@...2704...>
---
 src/openvpn/pkcs11.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index b74ac8f4..aa027337 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -420,6 +420,13 @@ pkcs11_addProvider(
         {
             rv = pkcs11h_setProviderProperty(provider, PKCS11H_PROVIDER_PROPERTY_CERT_IS_PRIVATE, &cert_is_private, sizeof(cert_is_private));
         }
+#if defined(WIN32) && defined(PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS)
+        if (rv == CKR_OK && platform_absolute_pathname(provider))
+        {
+            unsigned loader_flags = LOAD_LIBRARY_SEARCH_DEFAULT_DIRS | LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR;
+            rv = pkcs11h_setProviderProperty(provider, PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS, &loader_flags, sizeof(loader_flags));
+        }
+#endif
 
         if (rv != CKR_OK || (rv = pkcs11h_initializeProvider(provider)) != CKR_OK)
         {
-- 
2.38.1.windows.1


