From: Gert Doering <gert@...1296...>
Date: Fri, 10 Oct 2025 08:39:27 +0200
Message-ID: <20251010063934.18197-1-gert@...1296...>
In-Reply-To: <gerrit.1760062834000.Ic6fd6ba676b4741da7811ffc7c9688d4673465f8@...2715...>
References: <gerrit.1760062834000.Ic6fd6ba676b4741da7811ffc7c9688d4673465f8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix PIN cache time in test_pkcs11.c
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

Github: closes OpenVPN/openvpn#861

Change-Id: Ic6fd6ba676b4741da7811ffc7c9688d4673465f8
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1263
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1263
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index a4ba088..01cbf96 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -320,7 +320,7 @@
     /* set default propq as we do in ssl_openssl.c */
     EVP_set_default_properties(tls_libctx, "?provider!=ovpn.xkey");
 #endif
-    pkcs11_initialize(true, 0); /* protected auth enabled, pin-cache = 0 */
+    pkcs11_initialize(true, 60); /* protected auth enabled, pin-cache = 60s */
     pkcs11_addProvider(SOFTHSM2_MODULE_PATH, false, 0, false);
     return 0;
 }

