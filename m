From: Steffan Karger <steffan@...1856...>
Date: Tue, 22 Nov 2016 21:41:26 +0100
Message-Id: <1479847286-17518-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] --tls-crypt fixes
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

* Check return value of buf_init()  (found by coverity)

* Use the TLS frame to determine the buffer size, as is done for the
  reliability buffers used for tls-auth.  (We previously incorrectly used
  the TLS *plaintext* buffer size, which is bigger for typical setups
  with tun-mtu <= 1500.  Using the frame to calculate the size saves some
  bytes for typical setups, and doesn't break setups with big tun-mtu.)

* More carefully handle errors in tls_crypt_wrap() - just drop the packet
  instead of ASSERT()ing out (should not happen in the first place, but
  this is a bit more friendly if it happens somehow anyway).

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4198741..1ae1547 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -975,7 +975,7 @@ tls_session_init (struct tls_multi *multi, struct tls_session *session)
 
   /* Initialize control channel authentication parameters */
   session->tls_wrap = session->opt->tls_wrap;
-  session->tls_wrap.work = alloc_buf (TLS_CHANNEL_BUF_SIZE);
+  session->tls_wrap.work = alloc_buf (BUF_SIZE (&session->opt->frame));
 
   /* initialize packet ID replay window for --tls-auth */
   packet_id_init (&session->tls_wrap.opt.packet_id,
@@ -1322,13 +1322,20 @@ write_control_auth (struct tls_session *session,
     }
   else if (session->tls_wrap.mode == TLS_WRAP_CRYPT)
     {
-      buf_init (&session->tls_wrap.work, buf->offset);
+      ASSERT (buf_init (&session->tls_wrap.work, buf->offset));
       ASSERT (buf_write (&session->tls_wrap.work, &header, sizeof(header)));
       ASSERT (session_id_write (&session->session_id, &session->tls_wrap.work));
-      ASSERT (tls_crypt_wrap (buf, &session->tls_wrap.work, &session->tls_wrap.opt));
-      /* Don't change the original data in buf, it's used by the reliability
-       * layer to resend on failure. */
-      *buf = session->tls_wrap.work;
+      if (tls_crypt_wrap (buf, &session->tls_wrap.work, &session->tls_wrap.opt))
+	{
+	  /* Don't change the original data in buf, it's used by the reliability
+	   * layer to resend on failure. */
+	  *buf = session->tls_wrap.work;
+	}
+      else
+	{
+	  buf->len = 0;
+	  return;
+	}
     }
   *to_link_addr = &ks->remote_addr;
 }
-- 
2.7.4


