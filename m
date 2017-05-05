From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 5 May 2017 22:14:46 +0200
Message-ID: <1494015286-20368-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix Changes.rst layout
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

The extra space before each line made the 2.4.1 section stand out from the
other sections.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 Changes.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 2a94990..c1583b3 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -306,15 +306,15 @@ Maintainer-visible changes
 
 Version 2.4.1
 =============
- - ``--remote-cert-ku`` now only requires the certificate to have at least the
-   bits set of one of the values in the supplied list, instead of requiring an
-   exact match to one of the values in the list.
- - ``--remote-cert-tls`` now only requires that a keyUsage is present in the
-   certificate, and leaves the verification of the value up to the crypto
-   library, which has more information (i.e. the key exchange method in use)
-   to verify that the keyUsage is correct.
- - ``--ns-cert-type`` is deprecated.  Use ``--remote-cert-tls`` instead.
-   The nsCertType x509 extension is very old, and barely used.
-   ``--remote-cert-tls`` uses the far more common keyUsage and extendedKeyUsage
-   extension instead.  Make sure your certificates carry these to be able to
-   use ``--remote-cert-tls``.
+- ``--remote-cert-ku`` now only requires the certificate to have at least the
+  bits set of one of the values in the supplied list, instead of requiring an
+  exact match to one of the values in the list.
+- ``--remote-cert-tls`` now only requires that a keyUsage is present in the
+  certificate, and leaves the verification of the value up to the crypto
+  library, which has more information (i.e. the key exchange method in use)
+  to verify that the keyUsage is correct.
+- ``--ns-cert-type`` is deprecated.  Use ``--remote-cert-tls`` instead.
+  The nsCertType x509 extension is very old, and barely used.
+  ``--remote-cert-tls`` uses the far more common keyUsage and extendedKeyUsage
+  extension instead.  Make sure your certificates carry these to be able to
+  use ``--remote-cert-tls``.
-- 
2.7.4


