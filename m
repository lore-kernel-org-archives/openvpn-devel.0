From: Gert Doering <gert@...1296...>
Date: Tue, 25 Mar 2025 11:57:24 +0100
Message-ID: <20250325105724.1285-1-gert@...1296...>
In-Reply-To: <gerrit.1742429994000.I6d2ec69ac7a9ef5900d8f1d8541d6a19c9cb7df9@...2715...>
References: <gerrit.1742429994000.I6d2ec69ac7a9ef5900d8f1d8541d6a19c9cb7df9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] socket: use remote proto when creating
 client sockets
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

From: Antonio Quartulli <antonio@...2726...>

When creating a socket to connect to a remote (this happens
in client mode) always use the protocol specified for the
remote.

The listening protocol in this case is just ignored as it
does not make any sense.

Change-Id: I6d2ec69ac7a9ef5900d8f1d8541d6a19c9cb7df9
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/911
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6b32e30..ad97830 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1886,6 +1886,11 @@
     const char *remote_host = o->ce.remote;
     const char *remote_port = o->ce.remote_port;
 
+    if (remote_host)
+    {
+        proto = o->ce.proto;
+    }
+
     if (c->mode == CM_CHILD_TCP || c->mode == CM_CHILD_UDP)
     {
         struct link_socket *tmp_sock = NULL;

