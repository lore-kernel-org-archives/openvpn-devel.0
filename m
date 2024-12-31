From: Gert Doering <gert@...1296...>
Date: Tue, 31 Dec 2024 15:54:17 +0100
Message-ID: <20241231145417.12128-1-gert@...1296...>
In-Reply-To: <gerrit.1732212459000.I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4@...2715...>
References: <gerrit.1732212459000.I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] dco-win: simplify do_close_link_socket()
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

From: Lev Stipakov <lev@...515...>

c->c2.link_socket_owned is true in client mode
and for the global context in the server mode -
those are exactly the cases when we want to
set sd to undefined when using dco-win.

Change-Id: I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/813
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 850cd12..2bd5518 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4018,21 +4018,18 @@
 static void
 do_close_link_socket(struct context *c)
 {
-    /* in dco-win case, link socket is a tun handle which is
-     * closed in do_close_tun(). Set it to UNDEFINED so
-     * we won't use WinSock API to close it. */
-    if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_sockets)
-    {
-        for (int i = 0; i < c->c1.link_sockets_num; i++)
-        {
-            c->c2.link_sockets[i]->sd = SOCKET_UNDEFINED;
-        }
-    }
-
     if (c->c2.link_sockets && c->c2.link_socket_owned)
     {
         for (int i = 0; i < c->c1.link_sockets_num; i++)
         {
+            /* in dco-win case, link socket is a tun handle which is
+             * closed in do_close_tun(). Set it to UNDEFINED so
+             * we won't use WinSock API to close it. */
+            if (tuntap_is_dco_win(c->c1.tuntap))
+            {
+                c->c2.link_sockets[i]->sd = SOCKET_UNDEFINED;
+            }
+
             link_socket_close(c->c2.link_sockets[i]);
         }
         c->c2.link_sockets = NULL;

