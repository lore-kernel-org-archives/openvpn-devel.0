From: <steffan.karger@...1435...>
Date: Mon, 21 Jan 2013 14:13:27 +0100
Message-ID: <1358774007-4881-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1358774007-4881-1-git-send-email-steffan.karger@...1435...>
References: <1358774007-4881-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Improve verify_callback messages
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

From: Steffan Karger <steffan.karger@...1435...>

Print the *flags argument, which - for PolarSSL-1.2 - contains the reasons that
the certificate failed (pre-)verification.

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
---
 src/openvpn/ssl_verify_polarssl.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 653248f..e07f2b3 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -63,10 +63,10 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
       char *subject = x509_get_subject(cert, &gc);
 
       if (subject)
-	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, %s", cert_depth, subject);
+	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, flags=%0x, %s", cert_depth, *flags, subject);
       else
-	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, could not extract X509 "
-	      "subject string from certificate", cert_depth);
+	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, flags=%0x, could not extract X509 "
+	      "subject string from certificate", *flags, cert_depth);
 
       /* Leave flags set to non-zero to indicate that the cert is not ok */
     }
-- 
1.7.9.5


