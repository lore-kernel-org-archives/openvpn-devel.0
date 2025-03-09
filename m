From: Gert Doering <gert@...1296...>
Date: Sun,  9 Mar 2025 16:30:17 +0100
Message-ID: <20250309153017.5163-1-gert@...1296...>
In-Reply-To: <gerrit.1734109769000.I76e2e616c6ffe436a9627fa71aaace74030b2f4a@...2715...>
References: <gerrit.1734109769000.I76e2e616c6ffe436a9627fa71aaace74030b2f4a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco: pass remoteaddr only for UDP peers
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

TCP connected sockets do not need any remote addr
because the destination is fixed.
For this reason we can avoid sending the remote addr
along the peer-new dco call.

This change is important on Linux because the new 'ovpn'
kernel module is stricter when it comes to accepting
netlink messages and will reject calls with TCP sockets
if a remote address is specified.

Change-Id: I76e2e616c6ffe436a9627fa71aaace74030b2f4a
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/842
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 02fae81..973c848 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -515,8 +515,9 @@
         c->c2.tls_multi->dco_peer_id = -1;
     }
 #endif
-    int ret = dco_new_peer(&c->c1.tuntap->dco, multi->peer_id,
-                           c->c2.link_sockets[0]->sd, NULL, remoteaddr, NULL, NULL);
+    int ret = dco_new_peer(&c->c1.tuntap->dco, multi->peer_id, sock->sd, NULL,
+                           proto_is_dgram(sock->info.proto) ? remoteaddr : NULL,
+                           NULL, NULL);
     if (ret < 0)
     {
         return ret;

