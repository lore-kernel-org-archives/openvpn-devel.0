From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 9 May 2017 10:12:43 +0200
Message-ID: <1494317563-6303-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] mbedtls: correctly check return value in
	pkcs11_certificate_dn()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

mbedtls_x509_dn_gets() would not always return -1 error, which could cause
us to incorrectly continue after the function call failed.  To fix this,
just call our own x509_get_subject(), which does all the neccesary error
checking correctly.

pkcs11_certificate_dn() is only called by show_pkcs11_ids(), to list the
certificates on the pkcs11 token.  Therefor, this mistake did not have a
security impact.

This issue was found by Quarkslab during the OSTIF-founded security audit
(issue 5.3).

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/pkcs11_mbedtls.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index bdca893..dee97bc 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -39,6 +39,7 @@
 
 #include "errlevel.h"
 #include "pkcs11_backend.h"
+#include "ssl_verify_backend.h"
 #include <mbedtls/pkcs11.h>
 #include <mbedtls/x509.h>
 
@@ -82,8 +83,6 @@ char *
 pkcs11_certificate_dn(pkcs11h_certificate_t cert, struct gc_arena *gc)
 {
     char *ret = NULL;
-    char dn[1024] = {0};
-
     mbedtls_x509_crt mbed_crt = {0};
 
     if (mbedtls_pkcs11_x509_cert_bind(&mbed_crt, cert))
@@ -92,14 +91,12 @@ pkcs11_certificate_dn(pkcs11h_certificate_t cert, struct gc_arena *gc)
         goto cleanup;
     }
 
-    if (-1 == mbedtls_x509_dn_gets(dn, sizeof(dn), &mbed_crt.subject))
+    if (!(ret = x509_get_subject(&mbed_crt, gc)))
     {
         msg(M_FATAL, "PKCS#11: mbed TLS cannot parse subject");
         goto cleanup;
     }
 
-    ret = string_alloc(dn, gc);
-
 cleanup:
     mbedtls_x509_crt_free(&mbed_crt);
 
-- 
2.7.4


