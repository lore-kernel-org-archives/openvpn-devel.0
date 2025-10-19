From: Gert Doering <gert@...1296...>
Date: Sun, 19 Oct 2025 19:02:42 +0200
Message-ID: <20251019170249.30942-1-gert@...1296...>
In-Reply-To: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
References: <gerrit.1760513121000.I53dd40fabdeacb9dca843e28fdd3b357711c5a84@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] dco-freebsd: store peer stats directly
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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1275
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1275
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 947a769..e51f8dd 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -564,6 +564,21 @@
     return ret;
 }
 
+static void
+dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nvl)
+{
+    if (peerid >= m->max_clients || !m->instances[peerid])
+    {
+        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %d returned by kernel", peerid);
+        return;
+    }
+
+    struct multi_instance *mi = m->instances[peerid];
+
+    mi->context.c2.dco_read_bytes = nvlist_get_number(nvl, "in");
+    mi->context.c2.dco_write_bytes = nvlist_get_number(nvl, "out");
+}
+
 int
 dco_do_read(dco_context_t *dco)
 {
@@ -619,10 +634,7 @@
 
             if (nvlist_exists_nvlist(nvl, "bytes"))
             {
-                const nvlist_t *bytes = nvlist_get_nvlist(nvl, "bytes");
-
-                dco->dco_read_bytes = nvlist_get_number(bytes, "in");
-                dco->dco_write_bytes = nvlist_get_number(bytes, "out");
+                dco_update_peer_stat(dco->c->multi, dco->dco_message_peer_id, nvlist_get_nvlist(nvl, "bytes"));
             }
 
             dco->dco_message_type = OVPN_CMD_DEL_PEER;
@@ -777,21 +789,6 @@
     nvlist_destroy(nvl);
 }
 
-static void
-dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *nvl)
-{
-    if (peerid >= m->max_clients || !m->instances[peerid])
-    {
-        msg(M_WARN, "dco_update_peer_stat: invalid peer ID %d returned by kernel", peerid);
-        return;
-    }
-
-    struct multi_instance *mi = m->instances[peerid];
-
-    mi->context.c2.dco_read_bytes = nvlist_get_number(nvl, "in");
-    mi->context.c2.dco_write_bytes = nvlist_get_number(nvl, "out");
-}
-
 int
 dco_get_peer_stats_multi(dco_context_t *dco, const bool raise_sigusr1_on_err)
 {

