From: Steffan Karger <steffan@...1856...>
Date: Wed,  2 Jul 2014 23:31:28 +0200
Message-Id: <1404336688-15036-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] cleanup: remove #if 0'ed function
	initiate_untrusted_session() from ssl.c.
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

Has been inside the #if 0 since 'git tree epoch' (sept-2005) and was not
referenced, from either code, nor dead code nor comment.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 95bbb27..3ce1f60 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -996,22 +996,6 @@ reset_session (struct tls_multi *multi, struct tls_session *session)
   tls_session_init (multi, session);
 }
 
-#if 0
-/*
- * Transmit a TLS reset on our untrusted channel.
- */
-static void
-initiate_untrusted_session (struct tls_multi *multi, struct sockaddr_in *to)
-{
-  struct tls_session *session = &multi->session[TM_UNTRUSTED];
-  struct key_state *ks = &session->key[KS_PRIMARY];
-
-  reset_session (multi, session);
-  ks->remote_addr = *to;
-  msg (D_TLS_DEBUG_LOW, "TLS: initiate_untrusted_session: addr=%s", print_sockaddr (to));
-}
-#endif
-
 /*
  * Used to determine in how many seconds we should be
  * called again.
-- 
1.9.1


