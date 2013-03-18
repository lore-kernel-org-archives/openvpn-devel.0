From: <steffan.karger@...1435...>
Date: Mon, 18 Mar 2013 17:37:29 +0100
Message-ID: <1363624652-7001-3-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/5] Improve PolarSSL key_state_read_{cipher,
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

Instead of logging the fact that an error occured, log the error code and
description (when available in the PolarSSL build).

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
---
 src/openvpn/ssl_polarssl.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 4d00ad6..c787374 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -643,6 +643,7 @@ key_state_read_ciphertext (struct key_state_ssl *ks, struct buffer *buf,
 {
   int retval = 0;
   int len = 0;
+  char error_message[1024];
 
   perf_push (PERF_BIO_READ_CIPHERTEXT);
 
@@ -668,7 +669,8 @@ key_state_read_ciphertext (struct key_state_ssl *ks, struct buffer *buf,
       perf_pop ();
       if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
 	return 0;
-      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_plaintext error");
+      error_strerror(retval, error_message, sizeof(error_message));
+      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_ciphertext error: %d %s", retval, error_message);
       buf->len = 0;
       return -1;
     }
@@ -740,6 +742,7 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
 {
   int retval = 0;
   int len = 0;
+  char error_message[1024];
 
   perf_push (PERF_BIO_READ_PLAINTEXT);
 
@@ -764,7 +767,8 @@ key_state_read_plaintext (struct key_state_ssl *ks, struct buffer *buf,
     {
       if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
 	return 0;
-      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_plaintext error");
+      error_strerror(retval, error_message, sizeof(error_message));
+      msg (D_TLS_ERRORS, "TLS_ERROR: read tls_read_plaintext error: %d %s", retval, error_message);
       buf->len = 0;
       perf_pop ();
       return -1;
-- 
1.7.9.5


