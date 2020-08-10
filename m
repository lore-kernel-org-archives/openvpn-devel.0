From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:37:01 +0200
Message-Id: <20200810143707.5834-12-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 11/17] Eliminate check_tls wrapper function
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

Move check into caller.

Remove two in function forward declarations that are not needed from
check_tls_errors.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 27 ++++++---------------------
 src/openvpn/forward.h |  2 +-
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0e05b08b..36e5c175 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -77,20 +77,6 @@ show_wait_status(struct context *c)
 
 #endif /* ifdef ENABLE_DEBUG */
 
-/*
- * Does TLS session need service?
- */
-static inline void
-check_tls(struct context *c)
-{
-    void check_tls_dowork(struct context *c);
-
-    if (c->c2.tls_multi)
-    {
-        check_tls_dowork(c);
-    }
-}
-
 /*
  * TLS errors are fatal in TCP mode.
  * Also check for --tls-exit trigger.
@@ -98,10 +84,6 @@ check_tls(struct context *c)
 static inline void
 check_tls_errors(struct context *c)
 {
-    void check_tls_errors_co(struct context *c);
-
-    void check_tls_errors_nco(struct context *c);
-
     if (c->c2.tls_multi && c->c2.tls_exit_signal)
     {
         if (link_socket_connection_oriented(c->c2.link_socket))
@@ -157,7 +139,7 @@ context_reschedule_sec(struct context *c, int sec)
  *
  */
 void
-check_tls_dowork(struct context *c)
+check_tls(struct context *c)
 {
     interval_t wakeup = BIG_TIMEOUT;
 
@@ -1852,8 +1834,11 @@ pre_select(struct context *c)
         return;
     }
 
-    /* Does TLS need service? */
-    check_tls(c);
+    /* If tls is enabled, do tls control channel packet processing. */
+    if (c->c2.tls_multi)
+    {
+        check_tls(c);
+    }
 
     /* In certain cases, TLS errors will require a restart */
     check_tls_errors(c);
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 27e7fde7..a8b19f69 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -68,7 +68,7 @@ extern counter_type link_read_bytes_global;
 
 extern counter_type link_write_bytes_global;
 
-void check_tls_dowork(struct context *c);
+void check_tls(struct context *c);
 
 void check_tls_errors_co(struct context *c);
 
-- 
2.26.2


