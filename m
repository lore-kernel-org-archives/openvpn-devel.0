From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 12 Sep 2025 15:10:56 +0200
Message-Id: <20250912131056.42342-1-frank@...2641...>
In-Reply-To: <gerrit.1757406065000.I74e2b6aed3c7454e897db57f777e6a191be3d87f@...2715...>
References: <gerrit.1757406065000.I74e2b6aed3c7454e897db57f777e6a191be3d87f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix multi-socket and dco-win interaction
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

The dco_check_option_ce(), for dco_win, checked only
the global protocol of the current connection entry,
but now it should be extended to the local_list
and since dco_win does not support more than 1
socket, checking the first entry of the local_list
will be enough.

Change-Id: I74e2b6aed3c7454e897db57f777e6a191be3d87f
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1173
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 1abebbb..70a8c0a 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -268,7 +268,7 @@
 #endif
 
 #if defined(_WIN32)
-    if (!proto_is_udp(ce->proto) && mode == MODE_SERVER)
+    if (!proto_is_udp(ce->local_list->array[0]->proto) && mode == MODE_SERVER)
     {
         msg(msglevel,
             "NOTE: TCP transport disables data channel offload on Windows in server mode.");

