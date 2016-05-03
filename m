From: Steffan Karger <steffan@...1856...>
Date: Tue,  3 May 2016 22:14:38 +0200
Message-Id: <1462306478-21059-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] mbedtls: improve error reporting in tls
	verify callback
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

Instead of just printing the contents of the flags variable, try to
convert it to a human-readable error string and print that instead.

This will for example print "The certificate is signed with an
unacceptable key (eg bad curve, RSA too short).", instead of
"flags=10000".

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst                      |  5 ++++-
 src/openvpn/ssl_verify_mbedtls.c | 20 +++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 5034b15..dc9131b 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -91,10 +91,13 @@ User-visible Changes
   * Non-ephemeral key exchange using static (EC)DH keys
   * DSS private keys
 
-- PolarSSL builds: changed the tls_digest_N values exported to the script
+- mbed TLS builds: changed the tls_digest_N values exported to the script
   environment to be equal to the ones exported by OpenSSL builds, namely
   the certificate fingerprint (was the hash of the 'to be signed' data).
 
+- mbed TLS builds: minimum RSA key size is now 2048 bits.  Shorter keys will
+  not be accepted, both local and from the peer.
+
 
 Maintainer-visible changes
 --------------------------
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index ffe196e..e59dedb 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -65,13 +65,27 @@ verify_callback (void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
   /* did peer present cert which was signed by our root cert? */
   if (*flags != 0)
     {
+      int ret = 0;
+      char errstr[512] = { 0 };
       char *subject = x509_get_subject(cert, &gc);
 
+      ret = mbedtls_x509_crt_verify_info (errstr, sizeof(errstr)-1, "", *flags);
+      if (ret <= 0 && !openvpn_snprintf(errstr, sizeof(errstr),
+	    "Could not retrieve error string, flags=%"PRIx32, *flags))
+	{
+	  errstr[0] = '\0';
+	}
+
       if (subject)
-	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, flags=%x, %s", cert_depth, *flags, subject);
+	{
+	  msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, subject=%s: %s",
+	      cert_depth, subject, errstr);
+	}
       else
-	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, flags=%x, could not extract X509 "
-	      "subject string from certificate", *flags, cert_depth);
+	{
+	  msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, (could not extract X509 "
+	      "subject string from certificate): %s", cert_depth, errstr);
+	}
 
       /* Leave flags set to non-zero to indicate that the cert is not ok */
     }
-- 
2.7.4


