From: Gert Doering <gert@...1296...>
Date: Mon,  3 Nov 2025 22:25:17 +0100
Message-ID: <20251103212523.31409-1-gert@...1296...>
In-Reply-To: <gerrit.1762200393000.Iafac2b8f319457de8e36b427f26ebc27c040c6f7@...2715...>
References: <gerrit.1762200393000.Iafac2b8f319457de8e36b427f26ebc27c040c6f7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Use correct undo_list when clearing DNS
 addresses
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

From: Selva Nair <selva.nair@...277...>

Reported by: <aarnav@...2953...>

Change-Id: Iafac2b8f319457de8e36b427f26ebc27c040c6f7
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1344
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1344
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 58f1e02..0712986 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1797,7 +1797,7 @@
 HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
 {
     DWORD err = 0;
-    undo_type_t undo_type = (msg->family == AF_INET6) ? undo_dns4 : undo_dns6;
+    undo_type_t undo_type = (msg->family == AF_INET6) ? undo_dns6 : undo_dns4;
     int addr_len = msg->addr_len;
 
     /* sanity check */

