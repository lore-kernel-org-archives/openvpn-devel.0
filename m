From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 12 Dec 2022 13:56:42 +0200
Message-Id: <20221212115642.2139-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] management: add timer to push BYTECOUNT
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

At the moment BYTECOUNT in,out is pushed if there is traffic.
With DCO, userspace process doesn't see the traffic, so we need
to add a timer which periodically fetches stats from DCO and
pushes to management client. The timer interval is set by existing
"bytecount n" management command.

This commit only adds a timer, stats fetching from DCO will be added
later.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/forward.c | 11 ++++++++--
 src/openvpn/manage.c  | 51 ++++++++++++++++++++++++++++++++++++-------
 src/openvpn/manage.h  | 10 +++++++--
 3 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 1cd20a0b..830843c0 100644
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
@@ -949,7 +956,7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
         if (management)
         {
             management_bytes_client(management, c->c2.buf.len, 0);
-            management_bytes_server(management, &c->c2.link_read_bytes, &c->c2.link_write_bytes, &c->c2.mda_context);
+            management_bytes_server(management, c->c2.link_read_bytes, c->c2.link_write_bytes, &c->c2.mda_context);
         }
 #endif
     }
@@ -1789,7 +1796,7 @@ process_outgoing_link(struct context *c)
                 if (management)
                 {
                     management_bytes_client(management, 0, size);
-                    management_bytes_server(management, &c->c2.link_read_bytes, &c->c2.link_write_bytes, &c->c2.mda_context);
+                    management_bytes_server(management, c->c2.link_read_bytes, c->c2.link_write_bytes, &c->c2.mda_context);
                 }
 #endif
             }
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1f76a23d..ce952d52 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -42,6 +42,7 @@
 #include "ssl.h"
 #include "common.h"
 #include "manage.h"
+#include "openvpn.h"
 
 #include "memdbg.h"
 
@@ -463,16 +464,22 @@ man_bytecount(struct management *man, const int update_seconds)
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
 
 static void
-man_bytecount_output_client(struct management *man)
+man_bytecount_output_client(struct management *man,
+                            counter_type dco_read_bytes,
+                            counter_type dco_write_bytes)
 {
     if (man->connection.bytecount_update_seconds > 0
         && now >= man->connection.bytecount_last_update
@@ -482,8 +489,8 @@ man_bytecount_output_client(struct management *man)
         char out[32];
 
         /* do in a roundabout way to work around possible mingw or mingw-glibc bug */
-        openvpn_snprintf(in, sizeof(in), counter_format, man->persist.bytes_in);
-        openvpn_snprintf(out, sizeof(out), counter_format, man->persist.bytes_out);
+        openvpn_snprintf(in, sizeof(in), counter_format, man->persist.bytes_in + dco_read_bytes);
+        openvpn_snprintf(out, sizeof(out), counter_format, man->persist.bytes_out + dco_write_bytes);
         msg(M_CLIENT, ">BYTECOUNT:%s,%s", in, out);
         man->connection.bytecount_last_update = now;
     }
@@ -498,14 +505,14 @@ management_bytes_client(struct management *man,
     {
         man->persist.bytes_in += size_in;
         man->persist.bytes_out += size_out;
-        man_bytecount_output_client(man);
+        man_bytecount_output_client(man, 0, 0);
     }
 }
 
 void
 management_bytes_server(struct management *man,
-                        const counter_type *bytes_in_total,
-                        const counter_type *bytes_out_total,
+                        const counter_type bytes_in_total,
+                        const counter_type bytes_out_total,
                         struct man_def_auth_context *mdac)
 {
     if (man->connection.bytecount_update_seconds > 0
@@ -515,8 +522,8 @@ management_bytes_server(struct management *man,
         char in[32];
         char out[32];
         /* do in a roundabout way to work around possible mingw or mingw-glibc bug */
-        openvpn_snprintf(in, sizeof(in), counter_format, *bytes_in_total);
-        openvpn_snprintf(out, sizeof(out), counter_format, *bytes_out_total);
+        openvpn_snprintf(in, sizeof(in), counter_format, bytes_in_total);
+        openvpn_snprintf(out, sizeof(out), counter_format, bytes_out_total);
         msg(M_CLIENT, ">BYTECOUNT_CLI:%lu,%s,%s", mdac->cid, in, out);
         mdac->bytecount_last_update = now;
     }
@@ -2566,6 +2573,8 @@ man_connection_close(struct management *man)
     command_line_free(mc->in);
     buffer_list_free(mc->out);
 
+    event_timeout_clear(&mc->bytecount_update_interval);
+
     in_extra_reset(&man->connection, IER_RESET);
     buffer_list_free(mc->ext_key_input);
     man_connection_clear(mc);
@@ -4061,6 +4070,32 @@ management_sleep(const int n)
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
+
+        management_bytes_server(man,
+                                c->c2.link_read_bytes + dco_read_bytes,
+                                c->c2.link_write_bytes + dco_write_bytes,
+                                &c->c2.mda_context);
+
+        event_timeout_modify_wakeup(&man->connection.bytecount_update_interval,
+                                    man->connection.bytecount_update_seconds);
+    }
+}
+
 #else  /* ifdef ENABLE_MANAGEMENT */
 
 void
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 621440be..5a7aafa4 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -296,6 +296,7 @@ struct man_connection {
     bool echo_realtime;
     int bytecount_update_seconds;
     time_t bytecount_last_update;
+    struct event_timeout bytecount_update_interval;
 
     const char *up_query_type;
     int up_query_mode;
@@ -518,10 +519,15 @@ management_bytes_client(struct management *man,
 
 void
 management_bytes_server(struct management *man,
-                        const counter_type *bytes_in_total,
-                        const counter_type *bytes_out_total,
+                        const counter_type bytes_in_total,
+                        const counter_type bytes_out_total,
                         struct man_def_auth_context *mdac);
 
+void
+management_check_bytecount(struct context *c,
+                           struct management *man,
+                           struct timeval *timeval);
+
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
-- 
2.38.1.windows.1


