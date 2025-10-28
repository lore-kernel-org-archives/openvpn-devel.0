From: Gert Doering <gert@...1296...>
Date: Tue, 28 Oct 2025 12:33:05 +0100
Message-ID: <20251028113310.19921-1-gert@...1296...>
In-Reply-To: <gerrit.1761034162000.I92b5f3996f2a2180fa5e94719603078c1fc2f7f6@...2715...>
References: <gerrit.1761034162000.I92b5f3996f2a2180fa5e94719603078c1fc2f7f6@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco-freebsd: fix peer stats storage on
 client instances
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

Commit bf01a96 introduced a bug in the dco-freebsd path by attempting to
store peer statistics in a structure that only exists on server
instances. This leads to a SIGSEGV on non-server instances due to a NULL
multi_context pointer.

Resolve this by checking what mode the current instance is running in
and storing peer stats accordingly.

Fixes: https://github.com/OpenVPN/openvpn/issues/875
Change-Id: I92b5f3996f2a2180fa5e94719603078c1fc2f7f6
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1290
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1290
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index e51f8dd..3521fca 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -634,7 +634,17 @@
 
             if (nvlist_exists_nvlist(nvl, "bytes"))
             {
-                dco_update_peer_stat(dco->c->multi, dco->dco_message_peer_id, nvlist_get_nvlist(nvl, "bytes"));
+                const nvlist_t *bytes = nvlist_get_nvlist(nvl, "bytes");
+
+                if (dco->c->mode == CM_TOP)
+                {
+                    dco_update_peer_stat(dco->c->multi, dco->dco_message_peer_id, bytes);
+                }
+                else
+                {
+                    dco->c->c2.dco_read_bytes = nvlist_get_number(bytes, "in");
+                    dco->c->c2.dco_write_bytes = nvlist_get_number(bytes, "out");
+                }
             }
 
             dco->dco_message_type = OVPN_CMD_DEL_PEER;

