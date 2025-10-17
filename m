From: Gert Doering <gert@...1296...>
Date: Fri, 17 Oct 2025 22:56:12 +0200
Message-ID: <20251017205618.8273-1-gert@...1296...>
In-Reply-To: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
References: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco-freebsd: store peer stats directly
 in c2
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

From: Ralf Lici <ralf@...2726...>

The dco_context_t structure includes a reference to the general context
structure c, which allows us to store dco_read_bytes and dco_write_bytes
directly as c2 fields. This aligns the FreeBSD implementation with how
we handle DCO peer stats on Linux and Windows.

Change-Id: I53dd40fabdeacb9dca843e28fdd3b357711c5a84
Signed-off-by: Ralf Lici <ralf@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1275
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1275
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 947a769..f7ed02f 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -621,8 +621,8 @@
             {
                 const nvlist_t *bytes = nvlist_get_nvlist(nvl, "bytes");
 
-                dco->dco_read_bytes = nvlist_get_number(bytes, "in");
-                dco->dco_write_bytes = nvlist_get_number(bytes, "out");
+                dco->c->c2.dco_read_bytes = nvlist_get_number(bytes, "in");
+                dco->c->c2.dco_write_bytes = nvlist_get_number(bytes, "out");
             }
 
             dco->dco_message_type = OVPN_CMD_DEL_PEER;

