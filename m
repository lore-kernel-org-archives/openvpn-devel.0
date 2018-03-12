From: selva.nair@...277...
Date: Sun, 11 Mar 2018 21:17:59 -0400
Message-Id: <1520817479-17203-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1520817479-17203-1-git-send-email-selva.nair@...277...>
References: <1520817479-17203-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] Allow unicode search string in
 --cryptoapicert option
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

Currently when the certificate is specified as "SUBJ:foo", the
string foo is assumed to be ascii. Change that and interpret
it as utf-8, convert to a wide string, and flag it as unicode
in CertFindCertifcateInStore().

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/cryptoapi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index a579854..ae4a01b 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -50,6 +50,7 @@
 
 #include "buffer.h"
 #include "openssl_compat.h"
+#include "win32.h"
 
 /* MinGW w32api 3.17 is still incomplete when it comes to CryptoAPI while
  * MinGW32-w64 defines all macros used. This is a hack around that problem.
@@ -608,12 +609,13 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
     const void *find_param;
     unsigned char hash[255];
     CRYPT_HASH_BLOB blob = {.cbData = 0, .pbData = hash};
+    struct gc_arena gc = gc_new();
 
     if (!strncmp(cert_prop, "SUBJ:", 5))
     {
         /* skip the tag */
-        find_param = cert_prop + 5;
-        find_type = CERT_FIND_SUBJECT_STR_A;
+        find_param = wide_string(cert_prop + 5, &gc);
+        find_type = CERT_FIND_SUBJECT_STR_W;
     }
     else if (!strncmp(cert_prop, "THUMB:", 6))
     {
@@ -641,8 +643,7 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
             if (!*++p)  /* unexpected end of string */
             {
                 msg(M_WARN, "WARNING: cryptoapicert: error parsing <%s>.", cert_prop);
-                return NULL;
-                break;
+                goto out;
             }
             if (*p >= '0' && *p <= '9')
             {
@@ -682,6 +683,8 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
             validity < 0 ? "not yet valid" : "that has expired");
     }
 
+out:
+    gc_free(&gc);
     return rv;
 }
 
-- 
2.1.4


