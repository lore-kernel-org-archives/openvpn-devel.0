From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 12 Dec 2022 11:58:31 +0200
Message-Id: <20221212095832.2123-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] management: refactor bytecount routines
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

In preparation of DCO stats support, simplify
call chains of bytecount routines. No functional changes.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/forward.c |  4 +--
 src/openvpn/manage.c  | 64 ++++++++++++++++++++++++++++-------------
 src/openvpn/manage.h  | 66 ++++---------------------------------------
 3 files changed, 52 insertions(+), 82 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5cd7eaa6..1cd20a0b 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -948,7 +948,7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
 #ifdef ENABLE_MANAGEMENT
         if (management)
         {
-            management_bytes_in(management, c->c2.buf.len);
+            management_bytes_client(management, c->c2.buf.len, 0);
             management_bytes_server(management, &c->c2.link_read_bytes, &c->c2.link_write_bytes, &c->c2.mda_context);
         }
 #endif
@@ -1788,7 +1788,7 @@ process_outgoing_link(struct context *c)
 #ifdef ENABLE_MANAGEMENT
                 if (management)
                 {
-                    management_bytes_out(management, size);
+                    management_bytes_client(management, 0, size);
                     management_bytes_server(management, &c->c2.link_read_bytes, &c->c2.link_write_bytes, &c->c2.mda_context);
                 }
 #endif
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 5b288eab..1f76a23d 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -471,31 +471,55 @@ man_bytecount(struct management *man, const int update_seconds)
     msg(M_CLIENT, "SUCCESS: bytecount interval changed");
 }
 
-void
+static void
 man_bytecount_output_client(struct management *man)
 {
-    char in[32];
-    char out[32];
-    /* do in a roundabout way to work around possible mingw or mingw-glibc bug */
-    openvpn_snprintf(in, sizeof(in), counter_format, man->persist.bytes_in);
-    openvpn_snprintf(out, sizeof(out), counter_format, man->persist.bytes_out);
-    msg(M_CLIENT, ">BYTECOUNT:%s,%s", in, out);
-    man->connection.bytecount_last_update = now;
+    if (man->connection.bytecount_update_seconds > 0
+        && now >= man->connection.bytecount_last_update
+        + man->connection.bytecount_update_seconds)
+    {
+        char in[32];
+        char out[32];
+
+        /* do in a roundabout way to work around possible mingw or mingw-glibc bug */
+        openvpn_snprintf(in, sizeof(in), counter_format, man->persist.bytes_in);
+        openvpn_snprintf(out, sizeof(out), counter_format, man->persist.bytes_out);
+        msg(M_CLIENT, ">BYTECOUNT:%s,%s", in, out);
+        man->connection.bytecount_last_update = now;
+    }
+}
+
+void
+management_bytes_client(struct management *man,
+                        const int size_in,
+                        const int size_out)
+{
+    if (!(man->persist.callback.flags & MCF_SERVER))
+    {
+        man->persist.bytes_in += size_in;
+        man->persist.bytes_out += size_out;
+        man_bytecount_output_client(man);
+    }
 }
 
 void
-man_bytecount_output_server(struct management *man,
-                            const counter_type *bytes_in_total,
-                            const counter_type *bytes_out_total,
-                            struct man_def_auth_context *mdac)
-{
-    char in[32];
-    char out[32];
-    /* do in a roundabout way to work around possible mingw or mingw-glibc bug */
-    openvpn_snprintf(in, sizeof(in), counter_format, *bytes_in_total);
-    openvpn_snprintf(out, sizeof(out), counter_format, *bytes_out_total);
-    msg(M_CLIENT, ">BYTECOUNT_CLI:%lu,%s,%s", mdac->cid, in, out);
-    mdac->bytecount_last_update = now;
+management_bytes_server(struct management *man,
+                        const counter_type *bytes_in_total,
+                        const counter_type *bytes_out_total,
+                        struct man_def_auth_context *mdac)
+{
+    if (man->connection.bytecount_update_seconds > 0
+        && now >= mdac->bytecount_last_update + man->connection.bytecount_update_seconds
+        && (mdac->flags & (DAF_CONNECTION_ESTABLISHED | DAF_CONNECTION_CLOSED)) == DAF_CONNECTION_ESTABLISHED)
+    {
+        char in[32];
+        char out[32];
+        /* do in a roundabout way to work around possible mingw or mingw-glibc bug */
+        openvpn_snprintf(in, sizeof(in), counter_format, *bytes_in_total);
+        openvpn_snprintf(out, sizeof(out), counter_format, *bytes_out_total);
+        msg(M_CLIENT, ">BYTECOUNT_CLI:%lu,%s,%s", mdac->cid, in, out);
+        mdac->bytecount_last_update = now;
+    }
 }
 
 static void
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index f46274e6..621440be 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -511,70 +511,16 @@ void management_auth_token(struct management *man, const char *token);
 /*
  * These functions drive the bytecount in/out counters.
  */
+void
+management_bytes_client(struct management *man,
+                        const int size_in,
+                        const int size_out);
 
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
-
-static inline void
-management_bytes_in(struct management *man, const int size)
-{
-    if (!(man->persist.callback.flags & MCF_SERVER))
-    {
-        management_bytes_in_client(man, size);
-    }
-}
-
-void man_bytecount_output_server(struct management *man,
-                                 const counter_type *bytes_in_total,
-                                 const counter_type *bytes_out_total,
-                                 struct man_def_auth_context *mdac);
-
-static inline void
+void
 management_bytes_server(struct management *man,
                         const counter_type *bytes_in_total,
                         const counter_type *bytes_out_total,
-                        struct man_def_auth_context *mdac)
-{
-    if (man->connection.bytecount_update_seconds > 0
-        && now >= mdac->bytecount_last_update + man->connection.bytecount_update_seconds
-        && (mdac->flags & (DAF_CONNECTION_ESTABLISHED|DAF_CONNECTION_CLOSED)) == DAF_CONNECTION_ESTABLISHED)
-    {
-        man_bytecount_output_server(man, bytes_in_total, bytes_out_total, mdac);
-    }
-}
+                        struct man_def_auth_context *mdac);
 
 #endif /* ifdef ENABLE_MANAGEMENT */
 
-- 
2.38.1.windows.1


