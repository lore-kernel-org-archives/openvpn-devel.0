From: Marc Becker <marc.becker@...2704...>
Date: Sun, 11 Dec 2022 20:14:03 +0100
Message-Id: <20221211191403.805-1-marc.becker@...2704...>
In-Reply-To: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
References: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/3] use new pkcs11-helper interface to
 add providers
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

The new interface in  pkcs11-helper 1.28 allows decoupling of provider
registration and initialization.
This allows modifying more (and future) properties apart from the
6 fixed ones supported as arguments to pkcs11h_addProvider().

With the new interface it is easier to see (from a code perspective)
which option is set to which value.
It's also not necessary to supply values for built-in defaults:
- slot_event_method=PKCS11H_SLOTEVENT_METHOD_AUTO
- slot_poll_interval=0

Signed-off-by: Marc Becker <marc.becker@...2704...>
---
v2: improved code and description, no (essentially) duplicated log output
---
 src/openvpn/pkcs11.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index fbc4c472..b74ac8f4 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -396,6 +396,38 @@ pkcs11_addProvider(
         provider
         );
 
+#if PKCS11H_VERSION >= ((1<<16) | (28<<8) | (0<<0))
+    if ((rv = pkcs11h_registerProvider(provider)) != CKR_OK)
+    {
+        msg(M_WARN, "PKCS#11: Cannot register provider '%s' %ld-'%s'", provider, rv, pkcs11h_getMessage(rv));
+    }
+    else
+    {
+        PKCS11H_BOOL allow_protected_auth = protected_auth;
+        PKCS11H_BOOL cert_is_private = cert_private;
+
+        rv = pkcs11h_setProviderProperty(provider, PKCS11H_PROVIDER_PROPERTY_LOCATION, provider, strlen(provider) + 1);
+
+        if (rv == CKR_OK)
+        {
+            rv = pkcs11h_setProviderProperty(provider, PKCS11H_PROVIDER_PROPERTY_ALLOW_PROTECTED_AUTH, &allow_protected_auth, sizeof(allow_protected_auth));
+        }
+        if (rv == CKR_OK)
+        {
+            rv = pkcs11h_setProviderProperty(provider, PKCS11H_PROVIDER_PROPERTY_MASK_PRIVATE_MODE, &private_mode, sizeof(private_mode));
+        }
+        if (rv == CKR_OK)
+        {
+            rv = pkcs11h_setProviderProperty(provider, PKCS11H_PROVIDER_PROPERTY_CERT_IS_PRIVATE, &cert_is_private, sizeof(cert_is_private));
+        }
+
+        if (rv != CKR_OK || (rv = pkcs11h_initializeProvider(provider)) != CKR_OK)
+        {
+            msg(M_WARN, "PKCS#11: Cannot initialize provider '%s' %ld-'%s'", provider, rv, pkcs11h_getMessage(rv));
+            pkcs11h_removeProvider(provider);
+        }
+    }
+#else  /* if PKCS11H_VERSION >= ((1<<16) | (28<<8) | (0<<0)) */
     if (
         (rv = pkcs11h_addProvider(
              provider,
@@ -410,6 +442,7 @@ pkcs11_addProvider(
     {
         msg(M_WARN, "PKCS#11: Cannot initialize provider '%s' %ld-'%s'", provider, rv, pkcs11h_getMessage(rv));
     }
+#endif /* if PKCS11H_VERSION >= ((1<<16) | (28<<8) | (0<<0)) */
 
     dmsg(
         D_PKCS11_DEBUG,
-- 
2.38.1.windows.1


