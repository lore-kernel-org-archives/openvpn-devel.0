From: Steffan Karger <steffan@...1856...>
Date: Sun,  3 May 2015 11:23:38 +0200
Message-Id: <1430645018-21324-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] polarssl: remove code duplication in
	key_state_write_plaintext{, _const}()
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

Both functions had almost exactly the same code.  Instead of the code
duplication, have key_state_write_plaintext() call
key_state_write_plaintext_const() to do the actual work.  This is just
a bit of cleanup, it should not change any behaviour.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_polarssl.c | 39 +++++----------------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index d024e13..1a40304 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -828,47 +828,18 @@ int
 key_state_write_plaintext (struct key_state_ssl *ks, struct buffer *buf)
 {
   int retval = 0;
-  perf_push (PERF_BIO_WRITE_PLAINTEXT);
 
-  ASSERT (NULL != ks);
   ASSERT (buf);
-  ASSERT (buf->len >= 0);
-
-  if (0 == buf->len)
-    {
-      perf_pop ();
-      return 0;
-    }
 
-  retval = ssl_write(ks->ctx, BPTR(buf), buf->len);
+  retval = key_state_write_plaintext_const(ks, BPTR(buf), BLEN(buf));
 
-  if (retval < 0)
+  if (1 == retval)
     {
-      perf_pop ();
-      if (POLARSSL_ERR_NET_WANT_WRITE == retval || POLARSSL_ERR_NET_WANT_READ == retval)
-	return 0;
-      polar_log_err (D_TLS_ERRORS, retval,
-	  "TLS ERROR: write tls_write_plaintext error");
-      return -1;
-    }
-
-  if (retval != buf->len)
-    {
-      msg (D_TLS_ERRORS,
-	  "TLS ERROR: write tls_write_plaintext incomplete %d/%d",
-	  retval, buf->len);
-      perf_pop ();
-      return -1;
+      memset (BPTR (buf), 0, BLEN (buf)); /* erase data just written */
+      buf->len = 0;
     }
 
-  /* successful write */
-  dmsg (D_HANDSHAKE_VERBOSE, "write tls_write_plaintext %d bytes", retval);
-
-  memset (BPTR (buf), 0, BLEN (buf)); /* erase data just written */
-  buf->len = 0;
-
-  perf_pop ();
-  return 1;
+  return retval;
 }
 
 int
-- 
2.1.4


