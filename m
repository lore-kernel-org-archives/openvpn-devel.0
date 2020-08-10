From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:36:58 +0200
Message-Id: <20200810143707.5834-9-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 08/17] Rename check_ping_restart_dowork to
 trigger_ping_timeout_signal
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

Rename the function to better capture its actual function.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ping.c |  6 +-----
 src/openvpn/ping.h | 13 +++++++------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index 358d54b0..aa176fdb 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -46,12 +46,8 @@ const uint8_t ping_string[] = {
     0x07, 0xed, 0x2d, 0x0a, 0x98, 0x1f, 0xc7, 0x48
 };
 
-/*
- * Should we exit or restart due to ping (or other authenticated packet)
- * not received in n seconds?
- */
 void
-check_ping_restart_dowork(struct context *c)
+trigger_ping_timeout_signal(struct context *c)
 {
     struct gc_arena gc = gc_new();
     switch (c->options.ping_rec_timeout_action)
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index b51f082a..6feaa878 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -43,7 +43,12 @@ is_ping_msg(const struct buffer *buf)
     return buf_string_match(buf, ping_string, PING_STRING_SIZE);
 }
 
-void check_ping_restart_dowork(struct context *c);
+/**
+ * Trigger the correct signal on a --ping timeout
+ * depending if --ping-exit is set (SIGTERM) or not
+ * (SIGUSR1)
+ */
+void trigger_ping_timeout_signal(struct context *c);
 
 void check_ping_send_dowork(struct context *c);
 
@@ -54,8 +59,6 @@ void check_ping_send_dowork(struct context *c);
 static inline void
 check_ping_restart(struct context *c)
 {
-    void check_ping_restart_dowork(struct context *c);
-
     if (c->options.ping_rec_timeout
         && event_timeout_trigger(&c->c2.ping_rec_interval,
                                  &c->c2.timeval,
@@ -63,7 +66,7 @@ check_ping_restart(struct context *c)
                                   || link_socket_actual_defined(&c->c1.link_socket_addr.actual))
                                  ? ETT_DEFAULT : 15))
     {
-        check_ping_restart_dowork(c);
+        trigger_ping_timeout_signal(c);
     }
 }
 
@@ -73,8 +76,6 @@ check_ping_restart(struct context *c)
 static inline void
 check_ping_send(struct context *c)
 {
-    void check_ping_send_dowork(struct context *c);
-
     if (c->options.ping_send_timeout
         && event_timeout_trigger(&c->c2.ping_send_interval,
                                  &c->c2.timeval,
-- 
2.26.2


