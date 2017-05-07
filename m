From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 May 2017 13:01:18 +0200
Message-Id: <1494154878-18403-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix memory leak in x509_verify_cert_ku()
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

If keyUsage was only required to be present, but no specific value was
required, we would omit to free the extracted string.  This happens as of
2.4.1, if --remote-cert-tls is used.  In that case we leak a bit of
memory on each TLS (re)negotiation.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst                      | 9 +++++++++
 src/openvpn/ssl_verify_openssl.c | 1 +
 2 files changed, 10 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index c1583b3..3dba7e0 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -318,3 +318,12 @@ Version 2.4.1
   ``--remote-cert-tls`` uses the far more common keyUsage and extendedKeyUsage
   extension instead.  Make sure your certificates carry these to be able to
   use ``--remote-cert-tls``.
+
+
+Version 2.4.2
+=============
+
+Bugfixes
+--------
+- Fix memory leak introduced in 2.4.1: if --remote-cert-tls is used, we leaked
+  some memory on each TLS (re)negotiation.
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 54eadbd..337729c 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -599,6 +599,7 @@ x509_verify_cert_ku(X509 *x509, const unsigned *const expected_ku,
     if (expected_ku[0] == OPENVPN_KU_REQUIRED)
     {
         /* Extension required, value checked by TLS library */
+        ASN1_BIT_STRING_free(ku);
         return SUCCESS;
     }
 
-- 
2.7.4


