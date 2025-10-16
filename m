From: Gert Doering <gert@...1296...>
Date: Thu, 16 Oct 2025 12:33:03 +0200
Message-ID: <20251016103308.4685-1-gert@...1296...>
In-Reply-To: <gerrit.1760441637000.Ia713a2ecfcad7032863867630a0c306ff9f90385@...2715...>
References: <gerrit.1760441637000.Ia713a2ecfcad7032863867630a0c306ff9f90385@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] init: Fix datav2_enabled check in
 options import
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

From: Frank Lichtenheld <frank@...2641...>

peer_id is unsigned, so the previous check was partly
useless. Instead check use_peer_id.

Change-Id: Ia713a2ecfcad7032863867630a0c306ff9f90385
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1273
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1273
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index aaa0573..aa2611d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2728,8 +2728,8 @@
 
     /* Ensure that for epoch data format is only enabled if also data v2
      * is enabled */
-    bool epoch_data = (c->options.imported_protocol_flags & CO_EPOCH_DATA_KEY_FORMAT);
-    bool datav2_enabled = (c->options.peer_id >= 0 && c->options.peer_id < MAX_PEER_ID);
+    bool epoch_data = c->options.imported_protocol_flags & CO_EPOCH_DATA_KEY_FORMAT;
+    bool datav2_enabled = c->options.use_peer_id && c->options.peer_id < MAX_PEER_ID;
 
     if (epoch_data && !datav2_enabled)
     {

