From: Antonio Quartulli <a@...2181...>
Date: Sat,  2 Dec 2017 21:45:41 +0800
Message-Id: <20171202134541.7688-7-a@...2181...>
In-Reply-To: <20171202134541.7688-1-a@...2181...>
References: <20171202134541.7688-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 7/7] Remove TLS_MODE
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
Cc: Antonio Quartulli <a@...2181...>

Now that ENABLE_CRYPTO has been removed, TLS_MODE is basically
a useless shortcut which does not really help the readability of the
code.

Remove it and use its expanded expression instead.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/forward.c | 2 +-
 src/openvpn/init.c    | 2 +-
 src/openvpn/occ.c     | 3 ++-
 src/openvpn/openvpn.h | 1 -
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 9bf9483e..85ec71ae 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -948,7 +948,7 @@ process_incoming_link_part2(struct context *c, struct link_socket_info *lsi, con
          *
          * Also, update the persisted version of our packet-id.
          */
-        if (!TLS_MODE(c))
+        if (!c->c2.tls_multi)
         {
             link_socket_set_outgoing_addr(&c->c2.buf, lsi, &c->c2.from, NULL, c->c2.es);
         }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f8034ec7..7fe50628 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1306,7 +1306,7 @@ do_init_timers(struct context *c, bool deferred)
         /* initialize occ timers */
 
         if (c->options.occ
-            && !TLS_MODE(c)
+            && !c->c2.tls_multi
             && c->c2.options_string_local && c->c2.options_string_remote)
         {
             event_timeout_init(&c->c2.occ_interval, OCC_INTERVAL_SECONDS, now);
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 40f7e768..8434920c 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -378,7 +378,8 @@ process_received_occ_msg(struct context *c)
 
         case OCC_REPLY:
             dmsg(D_PACKET_CONTENT, "RECEIVED OCC_REPLY");
-            if (c->options.occ && !TLS_MODE(c) && c->c2.options_string_remote)
+            if (c->options.occ && !c->c2.tls_multi
+                && c->c2.options_string_remote)
             {
                 if (!options_cmp_equal_safe((char *) BPTR(&c->c2.buf),
                                             c->c2.options_string_remote,
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index fe8324ab..b36ca319 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -556,7 +556,6 @@ struct context
  * have been compiled in.
  */
 
-#define TLS_MODE(c) ((c)->c2.tls_multi != NULL)
 #define PROTO_DUMP_FLAGS (check_debug_level(D_LINK_RW_VERBOSE) ? (PD_SHOW_DATA|PD_VERBOSE) : 0)
 #define PROTO_DUMP(buf, gc) protocol_dump((buf), \
                                           PROTO_DUMP_FLAGS   \
-- 
2.15.1


