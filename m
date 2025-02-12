From: Gert Doering <gert@...1296...>
Date: Wed, 12 Feb 2025 13:38:20 +0100
Message-ID: <20250212123820.19099-1-gert@...1296...>
In-Reply-To: <gerrit.1739361204000.If6a636b2099d948e249cf92ed2ba91d1698ee42f@...2715...>
References: <gerrit.1739361204000.If6a636b2099d948e249cf92ed2ba91d1698ee42f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix oversight of link socket code change
 in Android code path
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

From: Arne Schwabe <arne@...1227...>

Commit 94b391d7ef5 changed context->link_socket to context->link_sockets
but did not change the Android code path.

Change-Id: If6a636b2099d948e249cf92ed2ba91d1698ee42f
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/888
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4014517..a7f7db4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4381,16 +4381,16 @@
 
     int socketfd = -1;
     struct context *c = (struct context *) arg;
-    if (!c->c2.link_socket)
+    if (!c->c2.link_sockets || !c->c2.link_sockets[0])
     {
         return -1;
     }
-    if (c->c2.link_socket->sd == SOCKET_UNDEFINED)
+    if (c->c2.link_sockets[0]->sd == SOCKET_UNDEFINED)
     {
         return -1;
     }
 
-    socketfd = c->c2.link_socket->sd;
+    socketfd = c->c2.link_sockets[0]->sd;
     if (!c->options.pull || c->c2.tls_multi->use_peer_id || samenetwork)
     {
         return socketfd;

