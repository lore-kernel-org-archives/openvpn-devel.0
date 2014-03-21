From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Mar 2014 14:18:39 +0100
Message-Id: <1395407925-25518-7-git-send-email-arne@...1227...>
In-Reply-To: <1395407925-25518-1-git-send-email-arne@...1227...>
References: <1395407925-25518-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 06/12] Fix for server selecting address
	family
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

---
 src/openvpn/socket.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index bf793f4..97f6756 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1509,21 +1509,10 @@ create_new_socket (struct link_socket* sock)
       /* clear destination set by set_actual_address */
       CLEAR(sock->info.lsa->actual.dest);
     }
-
-  /*
-   * Create the socket early if socket should be bound
-   */
-  if (sock->bind_local)
-    {
-      create_socket (sock);
-
-      if (sock->bind_local)
-          bind_local(sock);
-    }
-
 }
 
 
+
 /* bind socket if necessary */
 void
 link_socket_init_phase1 (struct link_socket *sock,
@@ -1946,6 +1935,17 @@ link_socket_init_phase2 (struct link_socket *sock,
       /* If socket has not already been created create it now */
       if (sock->sd == SOCKET_UNDEFINED)
 	{
+          /* If we have no --remote and have still not figured out the
+           * protocol family to use we will use the first of the bind */
+          if (sock->bind_local && sock->info.lsa->bind_local
+              && !sock->info.lsa->actual.ai_family && !sock->remote_host)
+          {
+            msg (M_WARN, "Could not determine IPv4/IPv6 protocol. Using %s",
+                 addr_family_name(sock->info.lsa->bind_local->ai_family));
+            set_actual_address(&sock->info.lsa->actual, sock->info.lsa->bind_local);
+
+          }
+
 	  if (sock->info.lsa->actual.ai_family)
 	    {
 	      create_socket (sock);
-- 
1.8.5.2 (Apple Git-48)


