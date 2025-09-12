From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 12 Sep 2025 15:12:07 +0200
Message-Id: <20250912131207.42597-1-frank@...2641...>
In-Reply-To: <gerrit.1757408812000.Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b@...2715...>
References: <gerrit.1757408812000.Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Multi-socket win: avoid repeated
 socket_set()
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

On Windows, multi-socket support failed with
mixed protocols due to repeated socket_set()
calls, which caused accept() to be triggered
before having an event to process.
This fix skips socket_set() calls for
non-UDP sockets in MODE_SERVER inside
multi_io_process_flags().

Change-Id: Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1174
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 03b6a0c..5d22fa3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2121,10 +2121,15 @@
 
     /*
      * Configure event wait based on socket, tuntap flags.
+     * (for TCP server sockets this happens in
+     *  socket_set_listen_persistent()).
      */
     for (int i = 0; i < c->c1.link_sockets_num; i++)
     {
-        socket_set(c->c2.link_sockets[i], es, socket, &c->c2.link_sockets[i]->ev_arg, NULL);
+        if ((c->options.mode != MODE_SERVER) || (proto_is_dgram(c->c2.link_sockets[i]->info.proto)))
+        {
+            socket_set(c->c2.link_sockets[i], es, socket, &c->c2.link_sockets[i]->ev_arg, NULL);
+        }
     }
 
     tun_set(c->c1.tuntap, es, tuntap, (void *)tun_shift, NULL);

