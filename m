From: Gert Doering <gert@...1296...>
Date: Sat, 15 Feb 2025 16:24:56 +0100
Message-ID: <20250215152456.5691-1-gert@...1296...>
In-Reply-To: <gerrit.1739361204000.Id4febcceecab33ee5189cd67b249a15d12b84799@...2715...>
References: <gerrit.1739361204000.Id4febcceecab33ee5189cd67b249a15d12b84799@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Reconnect when TCP is on use on
 network-change management command
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

On some newer Android handsets, changing to a different network
often does not trigger a TCP reset but continues using the old
connection (e.g. using mobile connection when WiFi becomes available)

Force a reconnect in these situation to have a more expected beheaviour.

Change-Id: Id4febcceecab33ee5189cd67b249a15d12b84799
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/891
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a7f7db4..b5eeeb8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4390,6 +4390,15 @@
         return -1;
     }
 
+    /* On some newer Android handsets, changing to a different network
+     * often does not trigger a TCP reset but continue using the old
+     * connection (e.g. using mobile connection when WiFi becomes available */
+    struct link_socket_info *lsi = get_link_socket_info(c);
+    if (lsi && proto_is_tcp(lsi->proto) && !samenetwork)
+    {
+        return -2;
+    }
+
     socketfd = c->c2.link_sockets[0]->sd;
     if (!c->options.pull || c->c2.tls_multi->use_peer_id || samenetwork)
     {

