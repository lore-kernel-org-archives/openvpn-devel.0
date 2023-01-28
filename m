From: selva.nair@...277...
Date: Sat, 28 Jan 2023 17:34:18 -0500
Message-Id: <20230128223421.2207802-2-selva.nair@...277...>
In-Reply-To: <20230128223421.2207802-1-selva.nair@...277...>
References: <20230128223421.2207802-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] Option --cryptoapicert: support issuer
 name as a selector
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

- Certificate selection string can now specify a partial
  issuer name string as "--cryptoapicert ISSUER:<string>" where
  <string> is matched as a substring of the issuer (CA) name in
  the certificate.

  Partial case-insensitive matching against the "issuer name" is
  used. Here "issuer name" is a text representation of the RDN's
  separated by commas.

  E.g., "CA, Ontario, Toronto, Acme Inc., IT, Acme Root CA".

  See MSDN docs on CertFindCertificateInStore() with CERT_FIND_ISSUER_STR
  as "FindType" for more details.

  As the order of RDN's is not well-defined[*] and type names like "OU"
  or "CN" are not included, its best to match against a single attribute
  like the CN of the issuer:

  E.g., --cryptoapicert "ISSUER:Acme Root"

[*] Windows appears to order RDN's in the reverse order to which
its written in the certificate but do not rely on this.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/man-sections/windows-options.rst | 13 +++++++++++--
 src/openvpn/cryptoapi.c              |  5 +++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/windows-options.rst
index 368f7b19..e87291f4 100644
--- a/doc/man-sections/windows-options.rst
+++ b/doc/man-sections/windows-options.rst
@@ -41,13 +41,22 @@ Windows-Specific Options
 
      cryptoapicert "SUBJ:Peter Runestig"
 
-  To select a certificate, based on certificate's thumbprint:
+  To select a certificate, based on certificate's thumbprint (SHA1 hash):
   ::
 
      cryptoapicert "THUMB:f6 49 24 41 01 b4 ..."
 
   The thumbprint hex string can easily be copy-and-pasted from the Windows
-  Certificate Store GUI.
+  Certificate Store GUI. The embedded spaces in the hex string are optional.
+
+  To select a certificate based on a substring in certificate's
+  issuer name:
+  ::
+
+     cryptoapicert "ISSUER:Sample CA"
+
+  The first non-expired certificate found in the user's store or the
+  machine store that matches the select-string is used.
 
 --dhcp-release
   Ask Windows to release the TAP adapter lease on shutdown. This option
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 661a9a6d..39eeec1b 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -459,6 +459,11 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
         find_param = wide_string(cert_prop + 5, &gc);
         find_type = CERT_FIND_SUBJECT_STR_W;
     }
+    else if (!strncmp(cert_prop, "ISSUER:", 7))
+    {
+        find_param = wide_string(cert_prop + 7, &gc);
+        find_type = CERT_FIND_ISSUER_STR_W;
+    }
     else if (!strncmp(cert_prop, "THUMB:", 6))
     {
         const char *p;
-- 
2.34.1


