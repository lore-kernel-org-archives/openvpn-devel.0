From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  2 Mar 2015 16:51:32 +0200
Message-Id: <1425307892-14258-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Client-side handling of OCC_SERVER_EXIT
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

When client receives OCC_SERVER_EXIT, it fires SIGUSR1 and switches to
the next server. Next server is defined as same remote with different IP
address if remote resolves into multiple addresses or next remote
otherwise.

This is a client-side only verion of "Notify clients about server's
exit/restart" patch.
---
 src/openvpn/occ.c | 7 +++++++
 src/openvpn/occ.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index ff48706..e8652de 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -390,6 +390,13 @@ process_received_occ_msg (struct context *c)
       c->sig->signal_received = SIGTERM;
       c->sig->signal_text = "remote-exit";
       break;
+
+    case OCC_SERVER_EXIT:
+      msg (D_LOW, "RECEIVED OCC_SERVER_EXIT");
+      c->sig->signal_received = SIGUSR1;
+      c->sig->signal_text = "remote-server-exit";
+      c->options.no_advance = false;
+      break;
     }
   c->c2.buf.len = 0; /* don't pass packet on */
 }
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 5d88cc9..8856c55 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -70,6 +70,11 @@
 #define OCC_EXIT               6
 
 /*
+ * Notifies clients that server is exiting/restarting
+ */
+#define OCC_SERVER_EXIT        7
+
+/*
  * Used to conduct a load test command sequence
  * of UDP connection for empirical MTU measurement.
  */
-- 
1.9.1


