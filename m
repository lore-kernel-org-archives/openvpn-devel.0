From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 10 Oct 2015 13:14:29 +0300
Message-Id: <1444472069-32036-1-git-send-email-lstipakov@...277...>
In-Reply-To: <20151010093902.GU22054@...1296...>
References: <20151010093902.GU22054@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix compilcation error with --disable-crypto
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

Also disable behavior for static key setup.
---
 src/openvpn/forward.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 513fbae..c17be35 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1199,13 +1199,16 @@ process_outgoing_link (struct context *c)
       if (c->c2.buf.len > 0 )
         register_activity (c, size);
 
+
+#ifdef ENABLE_CRYPTO
       /* for unreachable network and "connecting" state switch to the next host */
-      if (size < 0 && ENETUNREACH == error_code && !tls_initial_packet_received (c->c2.tls_multi)
-	  && c->options.mode == MODE_POINT_TO_POINT)
+      if (size < 0 && ENETUNREACH == error_code && c->c2.tls_multi &&
+          !tls_initial_packet_received (c->c2.tls_multi) && c->options.mode == MODE_POINT_TO_POINT)
 	{
 	  msg (M_INFO, "Network unreachable, restarting");
 	  register_signal (c, SIGUSR1, "network-unreachable");
 	}
+#endif
     }
   else
     {
-- 
1.9.1


