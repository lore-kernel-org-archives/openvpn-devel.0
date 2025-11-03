From: Gert Doering <gert@...1296...>
Date: Mon,  3 Nov 2025 12:55:46 +0100
Message-ID: <20251103115552.6201-1-gert@...1296...>
In-Reply-To: <gerrit.1762170801000.I19373408a82332d7b2e5c634e5509c8be3727b5a@...2715...>
References: <gerrit.1762170801000.I19373408a82332d7b2e5c634e5509c8be3727b5a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] manage: Correctly handle port 65535 in
 man_kill
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

Commit c66d433111c958c42cc98f4ba12d3cfc1bd5b3b4 introduced
an off-by-one when changing a literal to a constant.

Fixes: #887
Change-Id: I19373408a82332d7b2e5c634e5509c8be3727b5a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1341
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1341
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index e46b5f2..6efa100 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -612,7 +612,7 @@
                                       : (streq(p1, "udp")) ? PROTO_UDP
                                                            : PROTO_NONE;
 
-                if ((port > 0 && port < UINT16_MAX) && (proto != PROTO_NONE))
+                if ((port > 0 && port <= UINT16_MAX) && (proto != PROTO_NONE))
                 {
                     n_killed = (*man->persist.callback.kill_by_addr)(man->persist.callback.arg,
                                                                      addr, (uint16_t)port, proto);

