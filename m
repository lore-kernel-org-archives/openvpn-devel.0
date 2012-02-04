From: Adriaan de Jong <dejong@...1435...>
Date: Sat, 4 Feb 2012 14:16:13 +0100
Message-ID: <1328361373-18901-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Minor code cleanup: cleaned up error
	handling in verify_cert.
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

Removed done label and cleaned up return values.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 ssl_verify.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ssl_verify.c b/ssl_verify.c
index 326b005..feee124 100644
--- a/ssl_verify.c
+++ b/ssl_verify.c
@@ -684,14 +684,14 @@ verify_cert(struct tls_session *session, x509_cert_t *cert, int cert_depth)
   msg (D_HANDSHAKE, "VERIFY OK: depth=%d, %s", cert_depth, subject);
   session->verified = true;
 
- done:
   x509_free_subject (subject);
-  return (session->verified == true) ? SUCCESS : FAILURE;
+  return SUCCESS;
 
  err:
   tls_clear_error();
   session->verified = false;
-  goto done;
+  x509_free_subject (subject);
+  return FAILURE;
 }
 
 /* ***************************************************************************
-- 
1.7.5.4


