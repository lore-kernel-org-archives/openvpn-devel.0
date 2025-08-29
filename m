From: Gert Doering <gert@...1296...>
Date: Fri, 29 Aug 2025 16:43:23 +0200
Message-ID: <20250829144331.24487-1-gert@...1296...>
In-Reply-To: <gerrit.1756460812000.I43a93f0d84f01fd808a64115e1b8c3b806706491@...2715...>
References: <gerrit.1756460812000.I43a93f0d84f01fd808a64115e1b8c3b806706491@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Refactor management bytecount tracking
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

From: Lev Stipakov <lev@...515...>

There are few issues with it:

 - when using DCO, the server part doesn't output BYTECOUNT_CLI
 since process_incoming_link_part1/process_outgoing_link are not called

 - when using DCO, the server part applies bytecount timer to the each
 connection, unneccessary making too many calls to the kernel and also
 uses incorect BYTECOUNT output.

 - client part outputs counters using timer, server part utilizes
 traffic activity -> inconsistency

Following changes have been made:

 - Use timer to output counters in client and server mode. Code which
 deals with bytecount on traffic activity has been removed. This unifies
 DCO and non-DCO, as well as client and server mode

 - In server mode, peers stats are fetched with the single ioctl call

 - Per-packet stats are not persisted anymore in the client mode during
   traffic activity. Instead cumulative stats (including DCO stats) are
   persisted when the session closes.

GitHub: https://github.com/OpenVPN/openvpn/issues/820

Change-Id: I43a93f0d84f01fd808a64115e1b8c3b806706491
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Ralf Lici <ralf@...2726...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1162
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Ralf Lici <ralf@...2726...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 75ca9d5..03b6a0c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -818,7 +818,7 @@
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
-        management_check_bytecount(c, management, &c->c2.timeval);
+        management_check_bytecount_client(c, management, &c->c2.timeval);
     }
 #endif /* ENABLE_MANAGEMENT */
 }
@@ -998,14 +998,6 @@
         }
 #endif
         c->c2.original_recv_size = c->c2.buf.len;
-#ifdef ENABLE_MANAGEMENT
-        if (management)
-        {
-            management_bytes_client(management, c->c2.buf.len, 0);
-            management_bytes_server(management, &c->c2.link_read_bytes, &c->c2.link_write_bytes,
-                                    &c->c2.mda_context);
-        }
-#endif
     }
     else
     {
@@ -1823,14 +1815,6 @@
                     mmap_stats->link_write_bytes = link_write_bytes_global;
                 }
 #endif
-#ifdef ENABLE_MANAGEMENT
-                if (management)
-                {
-                    management_bytes_client(management, 0, size);
-                    management_bytes_server(management, &c->c2.link_read_bytes,
-                                            &c->c2.link_write_bytes, &c->c2.mda_context);
-                }
-#endif
             }
         }
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index aed04f5..bcc7250 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -41,6 +41,7 @@
 #include "manage.h"
 #include "openvpn.h"
 #include "dco.h"
+#include "multi.h"
 
 #include "memdbg.h"
 
@@ -517,29 +518,27 @@
 }
 
 static void
-man_bytecount_output_client(struct management *man, counter_type dco_read_bytes,
-                            counter_type dco_write_bytes)
+man_bytecount_output_client(counter_type bytes_in_total, counter_type bytes_out_total)
 {
     char in[32];
     char out[32];
 
     /* do in a roundabout way to work around possible mingw or mingw-glibc bug */
-    snprintf(in, sizeof(in), counter_format, man->persist.bytes_in + dco_read_bytes);
-    snprintf(out, sizeof(out), counter_format, man->persist.bytes_out + dco_write_bytes);
+    snprintf(in, sizeof(in), counter_format, bytes_in_total);
+    snprintf(out, sizeof(out), counter_format, bytes_out_total);
     msg(M_CLIENT, ">BYTECOUNT:%s,%s", in, out);
 }
 
-void
-man_bytecount_output_server(const counter_type *bytes_in_total, const counter_type *bytes_out_total,
+static void
+man_bytecount_output_server(const counter_type bytes_in_total, const counter_type bytes_out_total,
                             struct man_def_auth_context *mdac)
 {
     char in[32];
     char out[32];
     /* do in a roundabout way to work around possible mingw or mingw-glibc bug */
-    snprintf(in, sizeof(in), counter_format, *bytes_in_total);
-    snprintf(out, sizeof(out), counter_format, *bytes_out_total);
+    snprintf(in, sizeof(in), counter_format, bytes_in_total);
+    snprintf(out, sizeof(out), counter_format, bytes_out_total);
     msg(M_CLIENT, ">BYTECOUNT_CLI:%lu,%s,%s", mdac->cid, in, out);
-    mdac->bytecount_last_update = now;
 }
 
 static void
@@ -4065,42 +4064,70 @@
 }
 
 void
-management_check_bytecount(struct context *c, struct management *man, struct timeval *timeval)
+management_check_bytecount_client(struct context *c, struct management *man, struct timeval *timeval)
 {
-    if (event_timeout_trigger(&man->connection.bytecount_update_interval, timeval, ETT_DEFAULT))
+    if (!(man->persist.callback.flags & MCF_SERVER) && event_timeout_trigger(&man->connection.bytecount_update_interval, timeval, ETT_DEFAULT))
     {
-        counter_type dco_read_bytes = 0;
-        counter_type dco_write_bytes = 0;
-
         if (dco_enabled(&c->options))
         {
             if (dco_get_peer_stats(c, true) < 0)
             {
                 return;
             }
-
-            dco_read_bytes = c->c2.dco_read_bytes;
-            dco_write_bytes = c->c2.dco_write_bytes;
         }
 
-        if (!(man->persist.callback.flags & MCF_SERVER))
-        {
-            man_bytecount_output_client(man, dco_read_bytes, dco_write_bytes);
-        }
+        man_bytecount_output_client(c->c2.dco_read_bytes + man->persist.bytes_in + c->c2.link_read_bytes,
+                                    c->c2.dco_write_bytes + man->persist.bytes_out + c->c2.link_write_bytes);
     }
 }
 
-/* DCO resets stats on reconnect. Since client expects stats
- * to be preserved across reconnects, we need to save DCO
+void
+management_check_bytecount_server(struct multi_context *multi)
+{
+    struct timeval null;
+    CLEAR(null);
+
+    if ((management->persist.callback.flags & MCF_SERVER) && event_timeout_trigger(&management->connection.bytecount_update_interval, &null, ETT_DEFAULT))
+    {
+        /* fetch counters from dco */
+        if (dco_enabled(&multi->top.options))
+        {
+            if (dco_get_peer_stats_multi(&multi->top.c1.tuntap->dco, true) < 0)
+            {
+                return;
+            }
+        }
+
+        /* iterate over peers and report counters for each connected peer */
+        struct hash_iterator hi;
+        struct hash_element *he;
+        hash_iterator_init(multi->hash, &hi);
+        while ((he = hash_iterator_next(&hi)))
+        {
+            struct multi_instance *mi = (struct multi_instance *)he->value;
+            struct context_2 *c2 = &mi->context.c2;
+
+            if ((c2->mda_context.flags & (DAF_CONNECTION_ESTABLISHED | DAF_CONNECTION_CLOSED)) == DAF_CONNECTION_ESTABLISHED)
+            {
+                man_bytecount_output_server(c2->dco_read_bytes + c2->link_read_bytes, c2->dco_write_bytes + c2->link_write_bytes, &c2->mda_context);
+            }
+        }
+        hash_iterator_free(&hi);
+    }
+}
+
+/* context_2 stats are reset on reconnect. Since client expects stats
+ * to be preserved across reconnects, we need to save context_2
  * stats before tearing the tunnel down.
  */
 void
 man_persist_client_stats(struct management *man, struct context *c)
 {
     /* no need to raise SIGUSR1 since we are already closing the instance */
-    if (dco_enabled(&c->options) && (dco_get_peer_stats(c, false) == 0))
+    if (!(man->persist.callback.flags & MCF_SERVER))
     {
-        management_bytes_client(man, c->c2.dco_read_bytes, c->c2.dco_write_bytes);
+        man->persist.bytes_in += (c->c2.link_read_bytes + c->c2.dco_read_bytes);
+        man->persist.bytes_out += (c->c2.link_write_bytes + c->c2.dco_write_bytes);
     }
 }
 
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 083caf5..bbf0630 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -70,8 +70,6 @@
     unsigned int flags;
 
     unsigned int mda_key_id_counter;
-
-    time_t bytecount_last_update;
 };
 
 /*
@@ -492,34 +490,9 @@
  * These functions drive the bytecount in/out counters.
  */
 
-void management_check_bytecount(struct context *c, struct management *man, struct timeval *timeval);
+void management_check_bytecount_client(struct context *c, struct management *man, struct timeval *timeval);
 
-static inline void
-management_bytes_client(struct management *man, const int size_in, const int size_out)
-{
-    if (!(man->persist.callback.flags & MCF_SERVER))
-    {
-        man->persist.bytes_in += size_in;
-        man->persist.bytes_out += size_out;
-    }
-}
-
-void man_bytecount_output_server(const counter_type *bytes_in_total,
-                                 const counter_type *bytes_out_total,
-                                 struct man_def_auth_context *mdac);
-
-static inline void
-management_bytes_server(struct management *man, const counter_type *bytes_in_total,
-                        const counter_type *bytes_out_total, struct man_def_auth_context *mdac)
-{
-    if (man->connection.bytecount_update_seconds > 0
-        && now >= mdac->bytecount_last_update + man->connection.bytecount_update_seconds
-        && (mdac->flags & (DAF_CONNECTION_ESTABLISHED | DAF_CONNECTION_CLOSED))
-               == DAF_CONNECTION_ESTABLISHED)
-    {
-        man_bytecount_output_server(bytes_in_total, bytes_out_total, mdac);
-    }
-}
+void management_check_bytecount_server(struct multi_context *multi);
 
 void man_persist_client_stats(struct management *man, struct context *c);
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e1ce32a..f1abdbe 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3812,6 +3812,13 @@
     {
         check_stale_routes(m);
     }
+
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        management_check_bytecount_server(m);
+    }
+#endif /* ENABLE_MANAGEMENT */
 }
 
 static void

