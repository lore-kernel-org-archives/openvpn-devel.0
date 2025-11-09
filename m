From: Gert Doering <gert@...1296...>
Date: Sun,  9 Nov 2025 09:41:23 +0100
Message-ID: <20251109084130.11463-1-gert@...1296...>
In-Reply-To: <gerrit.1762292654000.I38a040a9bdcb44933d4ca538f746af5c61011d7c@...2715...>
References: <gerrit.1762292654000.I38a040a9bdcb44933d4ca538f746af5c61011d7c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dco_freebsd: implement
 dco_get_peer_stats()
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

This is "fetch read/write statistics for a single peer", complementing
dco_get_peer_stats_multi() "... for all peers", and it is called in
--client mode, and (!) in p2mp mode to check if --inactive thresholds
are reached.

The FreeBSD DCO module has no "give me stats for a single peer" call, so
we just call dco_get_peer_stats_multi() to get all of them - and that
function is modified to handle p2p or p2mp mode by checking mode == CM_TOP.

(dco_linux does about the same in dco_get_peer*() -> ovpn_handle_peer(),
after a few iterations, except that it can query for "just one peer")

"--inactive" still does not work on FreeBSD, because the code in forward.c
looks at counters that are not set by FreeBSD DCO.

v2:
  on AUTH_FAIL, 'dco' struct is not initialized yet -> SIGSEGV crash,
  verify that dco_peer_id is >= 0 before calling dco_get_peer_stats_multi()

Github: OpenVPN/openvpn#898

Change-Id: I38a040a9bdcb44933d4ca538f746af5c61011d7c
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Ralf Lici <ralf@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1350
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1350
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Ralf Lici <ralf@...2726...>

        
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index f80b6df..21f0ac0 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -870,8 +870,20 @@
     {
         const nvlist_t *peer = nvpeers[i];
         uint32_t peerid = nvlist_get_number(peer, "peerid");
+        const nvlist_t *bytes = nvlist_get_nvlist(peer, "bytes");
 
-        dco_update_peer_stat(dco->c->multi, peerid, nvlist_get_nvlist(peer, "bytes"));
+        /* we can end here in p2mp mode, or in p2p mode via
+         * the call to "dco_get_peer_stat()"
+         */
+        if (dco->c->mode == CM_TOP)
+        {
+            dco_update_peer_stat(dco->c->multi, peerid, bytes);
+        }
+        else
+        {
+            dco->c->c2.dco_read_bytes = nvlist_get_number(bytes, "in");
+            dco->c->c2.dco_write_bytes = nvlist_get_number(bytes, "out");
+        }
     }
 
     nvlist_destroy(nvl);
@@ -882,12 +894,26 @@
 #pragma GCC diagnostic pop
 #endif
 
+/* get stats for a single peer
+ * we can get here for "the peer stats" in p2p client mode, or by
+ * being queried for a particular peer in p2mp mode, for --inactive
+ */
 int
 dco_get_peer_stats(struct context *c, const bool raise_sigusr1_on_err)
 {
-    msg(D_DCO_DEBUG, __func__);
-    /* Not implemented. */
-    return 0;
+    ASSERT(c->c2.tls_multi);
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, c->c2.tls_multi->dco_peer_id);
+
+    if (c->c2.tls_multi->dco_peer_id < 0)
+    {
+        return -EINVAL; /* DCO not active yet */
+    }
+
+    /* unfortunately, the FreeBSD kernel has no peer-specific query - so
+     * we just get all the stats - and if we're there anyway, we can save it
+     * for all peers, too...
+     */
+    return dco_get_peer_stats_multi(&c->c1.tuntap->dco, raise_sigusr1_on_err);
 }
 
 const char *

