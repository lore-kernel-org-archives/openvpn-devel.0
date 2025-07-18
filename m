From: Gert Doering <gert@...1296...>
Date: Fri, 18 Jul 2025 20:55:53 +0200
Message-ID: <20250718185559.4515-1-gert@...1296...>
In-Reply-To: <gerrit.1751893020000.Iecbbcf32c0059f2b16a05333b3794599060d7d6a@...2715...>
References: <gerrit.1751893020000.Iecbbcf32c0059f2b16a05333b3794599060d7d6a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Multi-socket: Fix assert triggered by
 stale peer-id reuse
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Gianmarco De Gregori <gianmarco@...2726...>

Fixed a bug where clients using different transport
protocols (UDP, TCP) could interfere with each other
after a server restart.
The issue occurred when a client reused a previously
assigned peer-id that was now associated with a
different client using a different transport protocol.

For example, a UDP client could send packets with a
peer-id now assigned to a TCP client, which lacks
a valid context->c2.from which is filled by the
recvfrom(), causing an assert to be triggered.

A protocol check has been added to prevent packets
from different protocols from hijacking active
connections.

Github: #773

Change-Id: Iecbbcf32c0059f2b16a05333b3794599060d7d6a
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1078
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 93e65e0..ee8446a 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -216,16 +216,20 @@
 
             if (!peer_id_disabled && (peer_id < m->max_clients) && (m->instances[peer_id]))
             {
-                mi = m->instances[peer_id];
-
-                *floated = !link_socket_actual_match(&mi->context.c2.from, &m->top.c2.from);
-
-                if (*floated)
+                /* Floating on TCP will never be possible, so ensure we only process
+                 * UDP clients */
+                if (m->instances[peer_id]->context.c2.link_sockets[0]->info.proto == sock->info.proto)
                 {
-                    /* reset prefix, since here we are not sure peer is the one it claims to be */
-                    ungenerate_prefix(mi);
-                    msg(D_MULTI_MEDIUM, "Float requested for peer %" PRIu32 " to %s", peer_id,
-                        mroute_addr_print(&real, &gc));
+                    mi = m->instances[peer_id];
+                    *floated = !link_socket_actual_match(&mi->context.c2.from, &m->top.c2.from);
+
+                    if (*floated)
+                    {
+                        /* reset prefix, since here we are not sure peer is the one it claims to be */
+                        ungenerate_prefix(mi);
+                        msg(D_MULTI_MEDIUM, "Float requested for peer %" PRIu32 " to %s", peer_id,
+                            mroute_addr_print(&real, &gc));
+                    }
                 }
             }
         }

