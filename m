From: <steffan.karger@...1435...>
Date: Thu, 17 Jan 2013 09:23:27 +0100
Message-ID: <1358411009-2350-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>
References: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Improve PolarSSL key_state_read_{cipher,
	plain}text messages
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

Instead of logging the fact that an error occured, log the error string or (if
the PolarSSL build does not include this feature) the error code.

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
---
 src/openvpn/ssl_polarssl.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 12318b3..210bbab 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -666,6 +666,9 @@ key_state_read_ciphertext (struct key_state_ssl *ks, struct buffer *buf,
 {
   int retval = 0;
   int len = 0;
+#ifdef POLARSSL_ERROR_C
+  char error_message[1024];
+#endif
 
   perf_push (PERF_BIO_READ_CIPHERTEXT);
 
@@ -691,7 +694,12 @@ key_state_read_ciphertext (struct key_state_ssl *ks, struct buffer *buf,
       perf_pop ();
       if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
 	return 0;
-      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_plaintext error");
+#ifdef POLARSSL_ERROR_C
+      error_strerror(retval, error_message, sizeof(error_message));
+      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_ciphertext error: %s", error_message);
+#else
+      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_ciphertext error: %d", retval);
+#endif
       buf->len = 0;
       return -1;
     }
@@ -763,6 +771,9 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
 {
   int retval = 0;
   int len = 0;
+#ifdef POLARSSL_ERROR_C
+  char error_message[1024];
+#endif
 
   perf_push (PERF_BIO_READ_PLAINTEXT);
 
@@ -787,7 +798,12 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
     {
       if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
 	return 0;
-      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_plaintext error");
+#ifdef POLARSSL_ERROR_C
+      error_strerror(retval, error_message, sizeof(error_message));
+      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_plaintext error: %s", error_message);
+#else
+      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_plaintext error: %d", retval);
+#endif
       buf->len = 0;
       perf_pop ();
       return -1;
-- 
1.7.9.5


