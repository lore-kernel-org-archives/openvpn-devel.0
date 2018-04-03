From: selva.nair@...277...
Date: Tue,  3 Apr 2018 00:30:43 -0400
Message-Id: <1522729843-28878-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1522729843-28878-1-git-send-email-selva.nair@...277...>
References: <1520817479-17203-1-git-send-email-selva.nair@...277...>
 <1522729843-28878-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2 2/2] Allow unicode search string in
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
v2: rebased to v2 1/2 -- no code changes

 src/openvpn/cryptoapi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index ec7569a..c78e608 100644
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
@@ -641,7 +643,7 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
             if (!*++p)  /* unexpected end of string */
             {
                 msg(M_WARN, "WARNING: cryptoapicert: error parsing <THUMB:%s>.", cert_prop);
-                return NULL;
+                goto out;
             }
             if (*p >= '0' && *p <= '9')
             {
@@ -681,6 +683,8 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
             validity < 0 ? "not yet valid" : "that has expired");
     }
 
+out:
+    gc_free(&gc);
     return rv;
 }
 
-- 
2.1.4


