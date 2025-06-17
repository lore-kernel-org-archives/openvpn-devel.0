From: Gert Doering <gert@...1296...>
Date: Tue, 17 Jun 2025 10:41:28 +0200
Message-ID: <20250617084136.10215-1-gert@...1296...>
In-Reply-To: <gerrit.1750145305000.I0e17d9aea32eab7f44ed95037f077ae6dec52053@...2715...>
References: <gerrit.1750145305000.I0e17d9aea32eab7f44ed95037f077ae6dec52053@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Preserve socket protocol during float
 processing
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

During a float operation, we remove the old `mroute` object
corresponding to the current multi instance from the hash table and
insert a new one. With the introduction of the multi-socket feature, the
`mroute` structure gained a `proto` field, which must also be set in the
new instance, otherwise, hash table lookups will fail.

This commit ensures that the `proto` field is propagated from the
original to the new `mroute` object during float processing.

Change-Id: I0e17d9aea32eab7f44ed95037f077ae6dec52053
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gianmarco De Gregori <gianmarco@...2726...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1063
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gianmarco De Gregori <gianmarco@...2726...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 169af43..a760e07 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3217,6 +3217,12 @@
     struct hash *hash = m->hash;
     struct gc_arena gc = gc_new();
 
+    if (mi->real.type & MR_WITH_PROTO)
+    {
+        real.type |= MR_WITH_PROTO;
+        real.proto = sock->info.proto;
+    }
+
     if (!mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true))
     {
         goto done;

