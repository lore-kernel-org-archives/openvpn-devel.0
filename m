From: Gert Doering <gert@...1296...>
Date: Mon, 16 Mar 2026 14:48:36 +0100
Message-ID: <20260316134841.28362-1-gert@...1296...>
In-Reply-To: <gerrit.1772625635000.I7cf5d5ef7e2531f397ad97baf4663e3763072f6b@...2715...>
References: <gerrit.1772625635000.I7cf5d5ef7e2531f397ad97baf4663e3763072f6b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] socket: restore per-connection lport
 override over global default
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

OpenVPN 2.7.x introduced a regression where --lport specified
inside a <connection> block did not override a globally defined
local port. As a result, the socket was bound to the global
default port instead of the per-connection value.

Adjust the socket local_port selection logic to honour
local_port_defined when set for the active connection profile.

This change restores the documented and previously working
behaviour from 2.6.x, where connection-level lport takes
precedence over global defaults.

Github: #995

Change-Id: I7cf5d5ef7e2531f397ad97baf4663e3763072f6b
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1555
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1555
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8d2d110..3c1d734 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1357,6 +1357,13 @@
         proto = o->ce.proto;
     }
 
+    /* If --lport is specified in a client connection block,
+     * it takes precedence over the global setting. */
+    if (o->mode == MODE_POINT_TO_POINT && o->ce.local_port_defined)
+    {
+        port = o->ce.local_port;
+    }
+
     if (c->mode == CM_CHILD_TCP || c->mode == CM_CHILD_UDP)
     {
         struct link_socket *tmp_sock = NULL;

