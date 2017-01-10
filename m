From: David Sommerseth <davids@...515...>
Date: Tue, 10 Jan 2017 21:34:32 +0100
Message-Id: <1484080473-10415-1-git-send-email-davids@...515...>
In-Reply-To: <04b17e24-74d9-193b-ff8d-575efbf4d63a@...2080...>
References: <04b17e24-74d9-193b-ff8d-575efbf4d63a@...2080...>
Subject: [Openvpn-devel] [PATCH 1/2] management: >REMOTE operation would
	overwrite ce change indicator
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

If the management interface on a client received a signal while waiting
for input on the management channel, the "connection entry changed" status
would be overwritten even though nothing was changed.  Which could lead into
connecting to the wrong server.

This patch improves this by adding a check if a bool value was changed to
false.  This change happens only on signals.

Further, the former 'ret' value have been renamed to 'ce_changed', to
clarify what the expected return value contains.  Plus adding some comments
related to this.

And finally do some code style cleanup, breaking up too long lines, adding
some air here and there to improve the readability.

Signed-off-by: David Sommerseth <davids@...515...>
Cc: Selva Nair <selva.nair@...277...>
---
 src/openvpn/init.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9a3e29d..4786232 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -252,31 +252,42 @@ ce_management_query_remote(struct context *c)
 {
     struct gc_arena gc = gc_new();
     volatile struct connection_entry *ce = &c->options.ce;
-    int ret = true;
+    int ce_changed = true; /* presume the connection entry will be changed */
+
     update_time();
     if (management)
     {
         struct buffer out = alloc_buf_gc(256, &gc);
-        buf_printf(&out, ">REMOTE:%s,%s,%s", np(ce->remote), ce->remote_port, proto2ascii(ce->proto, ce->af, false));
+
+        buf_printf(&out, ">REMOTE:%s,%s,%s", np(ce->remote), ce->remote_port,
+                   proto2ascii(ce->proto, ce->af, false));
         management_notify_generic(management, BSTR(&out));
-        ce->flags &= ~(CE_MAN_QUERY_REMOTE_MASK<<CE_MAN_QUERY_REMOTE_SHIFT);
-        ce->flags |= (CE_MAN_QUERY_REMOTE_QUERY<<CE_MAN_QUERY_REMOTE_SHIFT);
-        while (((ce->flags>>CE_MAN_QUERY_REMOTE_SHIFT) & CE_MAN_QUERY_REMOTE_MASK) == CE_MAN_QUERY_REMOTE_QUERY)
+
+        ce->flags &= ~(CE_MAN_QUERY_REMOTE_MASK << CE_MAN_QUERY_REMOTE_SHIFT);
+        ce->flags |= (CE_MAN_QUERY_REMOTE_QUERY << CE_MAN_QUERY_REMOTE_SHIFT);
+        while (((ce->flags >> CE_MAN_QUERY_REMOTE_SHIFT)
+                & CE_MAN_QUERY_REMOTE_MASK) == CE_MAN_QUERY_REMOTE_QUERY)
         {
             management_event_loop_n_seconds(management, 1);
             if (IS_SIG(c))
             {
-                ret = false;
+                ce_changed = false; /* connection entry have not been set */
                 break;
             }
         }
     }
-    {
-        const int flags = ((ce->flags>>CE_MAN_QUERY_REMOTE_SHIFT) & CE_MAN_QUERY_REMOTE_MASK);
-        ret = (flags != CE_MAN_QUERY_REMOTE_SKIP);
-    }
     gc_free(&gc);
-    return ret;
+
+    if (ce_changed)
+    {
+        /* If it is likely a connection entry was modified,
+         * check what changed in the flags and that it was not skipped
+         */
+        const int flags = ((ce->flags >> CE_MAN_QUERY_REMOTE_SHIFT)
+                           & CE_MAN_QUERY_REMOTE_MASK);
+        ce_changed = (flags != CE_MAN_QUERY_REMOTE_SKIP);
+    }
+    return ce_changed;
 }
 #endif /* ENABLE_MANAGEMENT */
 
-- 
1.8.3.1


