From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  2 Mar 2015 19:58:31 +0200
Message-Id: <1425319111-21291-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Fast recovery when host is in unreachable
	network
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

When client connects to the server which is in unreachable network (for
example hostname got resolved into ipv6 address and client has no ipv6),
throw SIGUSR1 and connect to the next server without waiting 60 seconds
for "TLS key negotiation failed".
---
 src/openvpn/forward.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a3323e9..8eb8434 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1090,6 +1090,7 @@ void
 process_outgoing_link (struct context *c)
 {
   struct gc_arena gc = gc_new ();
+  int error_code = 0;
 
   perf_push (PERF_PROC_OUT_LINK);
 
@@ -1177,6 +1178,7 @@ process_outgoing_link (struct context *c)
 	}
 
       /* Check return status */
+      error_code = openvpn_errno();
       check_status (size, "write", c->c2.link_socket, NULL);
 
       if (size > 0)
@@ -1193,6 +1195,14 @@ process_outgoing_link (struct context *c)
       /* if not a ping/control message, indicate activity regarding --inactive parameter */
       if (c->c2.buf.len > 0 )
         register_activity (c, size);
+
+      /* for unreachable network and "connecting" state switch to the next host */
+      if (size < 0 && ENETUNREACH == error_code && !tls_initial_packet_received (c->c2.tls_multi)
+	  && c->options.mode == MODE_POINT_TO_POINT)
+	{
+	  msg (M_INFO, "Network unreachable, restarting");
+	  register_signal (c, SIGUSR1, "network-unreachable");
+	}
     }
   else
     {
-- 
1.9.1


