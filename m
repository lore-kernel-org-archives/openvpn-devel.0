From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 15:40:31 +0200
Message-Id: <20220422134038.3801239-3-arne@...1227...>
In-Reply-To: <20220422134038.3801239-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 02/28] Remove dead PID_TEST code
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

Enabling this test produces compile errors and by the looks of it the
test has been broken for many years.
---
 src/openvpn/init.c      |  5 ----
 src/openvpn/packet_id.c | 56 -----------------------------------------
 src/openvpn/packet_id.h | 10 --------
 3 files changed, 71 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d5be3cf9f..e41bb9d4b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -791,11 +791,6 @@ init_static(void)
 
     init_ssl_lib();
 
-#ifdef PID_TEST
-    packet_id_interactive_test();       /* test the sequence number code */
-    return false;
-#endif
-
 #ifdef SCHEDULE_TEST
     schedule_test();
     return false;
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 494320309..e357909d7 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -634,59 +634,3 @@ packet_id_debug_print(int msglevel,
 }
 
 #endif /* ifdef ENABLE_DEBUG */
-
-#ifdef PID_TEST
-
-void
-packet_id_interactive_test(void)
-{
-    struct packet_id pid;
-    struct packet_id_net pin;
-    bool long_form;
-    bool count = 0;
-    bool test;
-
-    const int seq_backtrack = 10;
-    const int time_backtrack = 10;
-
-    packet_id_init(&pid, seq_backtrack, time_backtrack);
-
-    while (true)
-    {
-        char buf[80];
-        if (!fgets(buf, sizeof(buf), stdin))
-        {
-            break;
-        }
-        update_time();
-        if (sscanf(buf, "%lu,%u", &pin.time, &pin.id) == 2)
-        {
-            packet_id_reap_test(&pid.rec);
-            test = packet_id_test(&pid.rec, &pin);
-            printf("packet_id_test (%" PRIi64 ", " packet_id_format ") returned %d\n",
-                   (int64_t)pin.time,
-                   (packet_id_print_type)pin.id,
-                   test);
-            if (test)
-            {
-                packet_id_add(&pid.rec, &pin);
-            }
-        }
-        else
-        {
-            long_form = (count < 20);
-            packet_id_alloc_outgoing(&pid.send, &pin, long_form);
-            printf("(%" PRIi64 "(" packet_id_format "), %d)\n",
-                   (int64_t)pin.time,
-                   (packet_id_print_type)pin.id,
-                   long_form);
-            if (pid.send.id == 10)
-            {
-                pid.send.id = 0xFFFFFFF8;
-            }
-            ++count;
-        }
-    }
-    packet_id_free(&pid);
-}
-#endif /* ifdef PID_TEST */
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index bb613282e..410071e26 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -35,11 +35,6 @@
 #include "error.h"
 #include "otime.h"
 
-/*
- * Enables OpenVPN to be compiled in special packet_id test mode.
- */
-/*#define PID_TEST*/
-
 #if 1
 /*
  * These are the types that members of
@@ -296,11 +291,6 @@ packet_id_persist_save_obj(struct packet_id_persist *p, const struct packet_id *
 
 const char *packet_id_net_print(const struct packet_id_net *pin, bool print_timestamp, struct gc_arena *gc);
 
-#ifdef PID_TEST
-void packet_id_interactive_test(void);
-
-#endif
-
 static inline int
 packet_id_size(bool long_form)
 {
-- 
2.32.0 (Apple Git-132)


