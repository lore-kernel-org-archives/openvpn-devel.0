From: Gert Doering <gert@...1296...>
Date: Fri, 24 Jan 2025 14:00:00 +0100
Message-ID: <20250124130000.20067-1-gert@...1296...>
In-Reply-To: <gerrit.1737722584000.I0542df021ae0ba9c982335fed7bbd10ed326dd0f@...2715...>
References: <gerrit.1737722584000.I0542df021ae0ba9c982335fed7bbd10ed326dd0f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix PASS_BY_VALUE issue in
 options_postprocess_mutate_le()
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

Fix issue reported by Coverity:
CID 1641424: Performance inefficiencies (PASS_BY_VALUE)
    Passing parameter ce of type "struct connection_entry"
    (size 208 bytes) by value, which exceeds the low
    threshold of 128 bytes.

Commit 8466c2ca unintentionally introduced a performance
penalty due to passing struct connection_entry 'ce'
by value to options_postprocess_mutate_le().
fix this by passing 'ce' by address.

Change-Id: I0542df021ae0ba9c982335fed7bbd10ed326dd0f
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/875
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c938999..bd5c056 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3323,12 +3323,12 @@
 }
 
 static void
-options_postprocess_mutate_le(struct connection_entry ce, struct local_entry *le)
+options_postprocess_mutate_le(struct connection_entry *ce, struct local_entry *le)
 {
     /* use the global port if none is specified */
     if (!le->port)
     {
-        le->port = ce.local_port;
+        le->port = ce->local_port;
     }
 }
 
@@ -3777,7 +3777,7 @@
     {
         for (i = 0; i < o->ce.local_list->len; i++)
         {
-            options_postprocess_mutate_le(o->ce, o->ce.local_list->array[i]);
+            options_postprocess_mutate_le(&o->ce, o->ce.local_list->array[i]);
         }
     }
     else

