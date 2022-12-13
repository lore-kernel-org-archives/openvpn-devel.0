From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 13 Dec 2022 12:31:42 +0200
Message-Id: <20221213103142.1960-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] management: add timer to output BYTECOUNT
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

BYTECOUNT on management interface is used to display client stats,
for example by openvpn-gui. At the moment BYTECOUNT is sent if
there is a traffic. With DCO, userspace process doesn't see data
channel traffic, BYTECOUNT is not sent and therefore stats
are not updated.

Fix displaying DCO client stats by adding a timer, which is triggerd
every n seconds, where n is set by existing management command
bytecount <n>. Output stats, taking into account stats from DCO,
when timer is triggered.

While on it, simplify bytecount routines call chains - inlining
functions which are used only once.

DCO stats fetching is not yet implemented.

Stats for the server mode (BYTECOUNT_CLI) are unaffected
by this change - to output those in timer callback we would need to
enumerate all peers, and I am not sure we want to output stats
for all peers every <n> seconds.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/forward.c | 11 ++++++--
 src/openvpn/manage.c  | 40 ++++++++++++++++++++++++-----
 src/openvpn/manage.h  | 60 ++++++++++++-------------------------------
 3 files changed, 58 insertions(+), 53 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5cd7eaa6..3c424cc1 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -766,6 +766,13 @@ process_coarse_timers(struct context *c)
 
     /* Should we ping the remote? */
     check_ping_send(c);
+
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        management_check_bytecount(c, management, &c->c2.timeval);
+    }
+#endif /* ENABLE_MANAGEMENT */
 }
 
 static void
@@ -948,7 +955,7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
 #ifdef ENABLE_MANAGEMENT
         if (management)
         {
-            management_bytes_in(management, c->c2.buf.len);
+            management_bytes_client(management, c->c2.buf.len, 0);
             management_bytes_server(management, &c->c2.link_read_bytes, &c->c2.link_write_bytes, &c->c2.mda_context);
         }
 #endif
@@ -1788,7 +1795,7 @@ process_outgoing_link(struct context *c)
 #ifdef ENABLE_MANAGEMENT
                 if (management)
                 {
-                    management_bytes_out(management, size);
+                    management_bytes_client(management, 0, size);
                     management_bytes_server(management, &c->c2.link_read_bytes, &c->c2.link_write_bytes, &c->c2.mda_context);
                 }
 #endif
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 5b288eab..435efaf8 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -42,6 +42,7 @@
 #include "ssl.h"
 #include "common.h"
 #include "manage.h"
+#include "openvpn.h"
 
 #include "memdbg.h"
 
@@ -463,29 +464,34 @@ man_bytecount(struct management *man, const int update_seconds)
     if (update_seconds >= 0)
     {
         man->connection.bytecount_update_seconds = update_seconds;
+        event_timeout_init(&man->connection.bytecount_update_interval,
+                           man->connection.bytecount_update_seconds,
+                           now);
     }
     else
     {
         man->connection.bytecount_update_seconds = 0;
+        event_timeout_clear(&man->connection.bytecount_update_interval);
     }
     msg(M_CLIENT, "SUCCESS: bytecount interval changed");
 }
 
-void
-man_bytecount_output_client(struct management *man)
+static void
+man_bytecount_output_client(struct management *man,
+                            counter_type dco_read_bytes,
+                            counter_type dco_write_bytes)
 {
     char in[32];
     char out[32];
+
     /* do in a roundabout way to work around possible mingw or mingw-glibc bug */
-    openvpn_snprintf(in, sizeof(in), counter_format, man->persist.bytes_in);
-    openvpn_snprintf(out, sizeof(out), counter_format, man->persist.bytes_out);
+    openvpn_snprintf(in, sizeof(in), counter_format, man->persist.bytes_in + dco_read_bytes);
+    openvpn_snprintf(out, sizeof(out), counter_format, man->persist.bytes_out + dco_write_bytes);
     msg(M_CLIENT, ">BYTECOUNT:%s,%s", in, out);
-    man->connection.bytecount_last_update = now;
 }
 
 void
-man_bytecount_output_server(struct management *man,
-                            const counter_type *bytes_in_total,
+man_bytecount_output_server(const counter_type *bytes_in_total,
                             const counter_type *bytes_out_total,
                             struct man_def_auth_context *mdac)
 {
@@ -2542,6 +2548,8 @@ man_connection_close(struct management *man)
     command_line_free(mc->in);
     buffer_list_free(mc->out);
 
+    event_timeout_clear(&mc->bytecount_update_interval);
+
     in_extra_reset(&man->connection, IER_RESET);
     buffer_list_free(mc->ext_key_input);
     man_connection_clear(mc);
@@ -4037,6 +4045,24 @@ management_sleep(const int n)
     }
 }
 
+void
+management_check_bytecount(struct context *c, struct management *man, struct timeval *timeval)
+{
+    if (event_timeout_trigger(&man->connection.bytecount_update_interval,
+                              timeval, ETT_DEFAULT))
+    {
+        /* TODO: get stats from DCO */
+
+        counter_type dco_read_bytes = 0;
+        counter_type dco_write_bytes = 0;
+
+        if (!(man->persist.callback.flags & MCF_SERVER))
+        {
+            man_bytecount_output_client(man, dco_read_bytes, dco_write_bytes);
+        }
+    }
+}
+
 #else  /* ifdef ENABLE_MANAGEMENT */
 
 void
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index f46274e6..700b15cf 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -295,7 +295,7 @@ struct man_connection {
     bool log_realtime;
     bool echo_realtime;
     int bytecount_update_seconds;
-    time_t bytecount_last_update;
+    struct event_timeout bytecount_update_interval;
 
     const char *up_query_type;
     int up_query_mode;
@@ -512,55 +512,27 @@ void management_auth_token(struct management *man, const char *token);
  * These functions drive the bytecount in/out counters.
  */
 
-void man_bytecount_output_client(struct management *man);
-
-static inline void
-man_bytecount_possible_output_client(struct management *man)
-{
-    if (man->connection.bytecount_update_seconds > 0
-        && now >= man->connection.bytecount_last_update
-        + man->connection.bytecount_update_seconds)
-    {
-        man_bytecount_output_client(man);
-    }
-}
-
-static inline void
-management_bytes_out_client(struct management *man, const int size)
-{
-    man->persist.bytes_out += size;
-    man_bytecount_possible_output_client(man);
-}
-
-static inline void
-management_bytes_in_client(struct management *man, const int size)
-{
-    man->persist.bytes_in += size;
-    man_bytecount_possible_output_client(man);
-}
-
-static inline void
-management_bytes_out(struct management *man, const int size)
-{
-    if (!(man->persist.callback.flags & MCF_SERVER))
-    {
-        management_bytes_out_client(man, size);
-    }
-}
+void
+management_check_bytecount(struct context *c,
+                           struct management *man,
+                           struct timeval *timeval);
 
 static inline void
-management_bytes_in(struct management *man, const int size)
+management_bytes_client(struct management *man,
+                        const int size_in,
+                        const int size_out)
 {
     if (!(man->persist.callback.flags & MCF_SERVER))
     {
-        management_bytes_in_client(man, size);
+        man->persist.bytes_in += size_in;
+        man->persist.bytes_out += size_out;
     }
 }
 
-void man_bytecount_output_server(struct management *man,
-                                 const counter_type *bytes_in_total,
-                                 const counter_type *bytes_out_total,
-                                 struct man_def_auth_context *mdac);
+void
+man_bytecount_output_server(const counter_type *bytes_in_total,
+                            const counter_type *bytes_out_total,
+                            struct man_def_auth_context *mdac);
 
 static inline void
 management_bytes_server(struct management *man,
@@ -570,9 +542,9 @@ management_bytes_server(struct management *man,
 {
     if (man->connection.bytecount_update_seconds > 0
         && now >= mdac->bytecount_last_update + man->connection.bytecount_update_seconds
-        && (mdac->flags & (DAF_CONNECTION_ESTABLISHED|DAF_CONNECTION_CLOSED)) == DAF_CONNECTION_ESTABLISHED)
+        && (mdac->flags & (DAF_CONNECTION_ESTABLISHED | DAF_CONNECTION_CLOSED)) == DAF_CONNECTION_ESTABLISHED)
     {
-        man_bytecount_output_server(man, bytes_in_total, bytes_out_total, mdac);
+        man_bytecount_output_server(bytes_in_total, bytes_out_total, mdac);
     }
 }
 
-- 
2.38.1.windows.1


