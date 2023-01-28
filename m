From: selva.nair@...277...
Date: Sat, 28 Jan 2023 16:59:01 -0500
Message-Id: <20230128215901.2207208-2-selva.nair@...277...>
In-Reply-To: <20230128215901.2207208-1-selva.nair@...277...>
References: <20230128215901.2207208-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] signal_reset(): combine check and reset
 operations
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

From: Selva Nair <selva.nair@...277...>

- "if (sig == X) signal_reset(sig)" now becomes
  "signal_reset(sig, X)" so that the check and assignment
  can be done in one place where signals are masked.
  This is required to avoid change of signal state between
  check and reset operations.

- Avoid resetting the signal except when absolutely necessary
  (resetting has the potential of losing signals)

- In 'pre_init_signal_catch()', when certain low priority signals
  are set to SIG_IGN, clear any pending signals of the same
  type. Also, reset signal at the end of the SIGUSR1 and
  SIGHUP loops where their values are checked instead of later. This
  avoids the need for 'signal_reset()' after SIGHUP or in 'init_instance()'
  which could cause a signal like SIGTERM to be lost.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/init.c    |  3 ---
 src/openvpn/multi.c   |  5 ++---
 src/openvpn/openvpn.c |  5 ++---
 src/openvpn/sig.c     | 40 +++++++++++++++++++++++++++++++++-------
 src/openvpn/sig.h     |  7 ++++++-
 src/openvpn/socket.c  |  5 ++---
 src/openvpn/win32.c   |  2 +-
 7 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b500d354..76a7be7b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4299,9 +4299,6 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
         do_inherit_env(c, env);
     }
 
-    /* signals caught here will abort */
-    signal_reset(c->sig);
-
     if (c->mode == CM_P2P)
     {
         init_management_callback_p2p(c);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f2559016..c52c8f14 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3868,7 +3868,7 @@ multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
                        &m->deferred_shutdown_signal.wakeup,
                        compute_wakeup_sigma(&m->deferred_shutdown_signal.wakeup));
 
-    signal_reset(m->top.sig);
+    signal_reset(m->top.sig, 0);
 }
 
 /*
@@ -3878,12 +3878,11 @@ multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
 bool
 multi_process_signal(struct multi_context *m)
 {
-    if (m->top.sig->signal_received == SIGUSR2)
+    if (signal_reset(m->top.sig, SIGUSR2) == SIGUSR2)
     {
         struct status_output *so = status_open(NULL, 0, M_INFO, NULL, 0);
         multi_print_status(m, so, m->status_file_version);
         status_close(so);
-        signal_reset(m->top.sig);
         return false;
     }
     else if (proto_is_dgram(m->top.options.ce.proto)
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index cba58276..ad0aa8a2 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -194,7 +194,6 @@ openvpn_main(int argc, char *argv[])
             context_clear_all_except_first_time(&c);
 
             /* static signal info object */
-            CLEAR(siginfo_static);
             c.sig = &siginfo_static;
 
             /* initialize garbage collector scoped to context object */
@@ -333,14 +332,14 @@ openvpn_main(int argc, char *argv[])
                 /* pass restart status to management subsystem */
                 signal_restart_status(c.sig);
             }
-            while (c.sig->signal_received == SIGUSR1);
+            while (signal_reset(c.sig, SIGUSR1) == SIGUSR1);
 
             env_set_destroy(c.es);
             uninit_options(&c.options);
             gc_reset(&c.gc);
             uninit_early(&c);
         }
-        while (c.sig->signal_received == SIGHUP);
+        while (signal_reset(c.sig, SIGHUP) == SIGHUP);
     }
 
     context_gc_free(&c);
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 559ca35d..4eead996 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -259,15 +259,37 @@ register_signal(struct signal_info *si, int signum, const char *signal_text)
     }
 }
 
-void
-signal_reset(struct signal_info *si)
+/**
+ * Clear the signal if its current value equals signum. If
+ * signum is zero the signal is cleared independent of its current
+ * value. Returns the current value of the signal.
+ */
+int
+signal_reset(struct signal_info *si, int signum)
 {
+    int sig_saved = 0;
     if (si)
     {
-        si->signal_received = 0;
-        si->signal_text = NULL;
-        si->source = SIG_SOURCE_SOFT;
+        if (si == &siginfo_static) /* attempting to alter the global signal */
+        {
+            block_async_signals();
+        }
+
+        sig_saved = si->signal_received;
+        if (!signum || sig_saved == signum)
+        {
+            si->signal_received = 0;
+            si->signal_text = NULL;
+            si->source = SIG_SOURCE_SOFT;
+            msg(D_SIGNAL_DEBUG, "signal_reset: signal %s is cleared", signal_name(signum, true));
+        }
+
+        if (si == &siginfo_static)
+        {
+            unblock_async_signals();
+        }
     }
+    return sig_saved;
 }
 
 void
@@ -397,6 +419,10 @@ pre_init_signal_catch(void)
     sigaction(SIGUSR2, &sa, NULL);
     sigaction(SIGPIPE, &sa, NULL);
 #endif /* _WIN32 */
+    /* clear any pending signals of the ignored type */
+    signal_reset(&siginfo_static, SIGUSR1);
+    signal_reset(&siginfo_static, SIGUSR2);
+    signal_reset(&siginfo_static, SIGHUP);
 }
 
 void
@@ -534,7 +560,7 @@ process_explicit_exit_notification_init(struct context *c)
      * will be ignored during the exit notification period.
      */
     halt_low_priority_signals(); /* Set hard SIGUSR1/SIGHUP/SIGUSR2 to be ignored */
-    signal_reset(c->sig);
+    signal_reset(c->sig, 0);
 
     c->c2.explicit_exit_notification_time_wait = now;
 
@@ -585,7 +611,7 @@ process_sigusr2(const struct context *c)
     struct status_output *so = status_open(NULL, 0, M_INFO, NULL, 0);
     print_status(c, so);
     status_close(so);
-    signal_reset(c->sig);
+    signal_reset(c->sig, SIGUSR2);
 }
 
 static bool
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 4858eb93..7d76389a 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -81,7 +81,12 @@ void register_signal(struct signal_info *si, int sig, const char *text);
 
 void process_explicit_exit_notification_timer_wakeup(struct context *c);
 
-void signal_reset(struct signal_info *si);
+/**
+ * Clear the signal if its current value equals signum. If signum is
+ * zero the signal is cleared independent of its current value.
+ * @returns the current value of the signal.
+ */
+int signal_reset(struct signal_info *si, int signum);
 
 static inline void
 halt_non_edge_triggered_signals(void)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index baafe1e6..a2af2498 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -567,12 +567,11 @@ openvpn_getaddrinfo(unsigned int flags,
                 if (sig_info->signal_received) /* were we interrupted by a signal? */
                 {
                     /* why are we overwriting SIGUSR1 ? */
-                    if (sig_info->signal_received == SIGUSR1) /* ignore SIGUSR1 */
+                    if (signal_reset(sig_info, SIGUSR1) == SIGUSR1) /* ignore SIGUSR1 */
                     {
                         msg(level,
                             "RESOLVE: Ignored SIGUSR1 signal received during "
                             "DNS resolution attempt");
-                        signal_reset(sig_info);
                     }
                     else
                     {
@@ -2176,7 +2175,7 @@ link_socket_init_phase2(struct context *c)
     if (sig_info->signal_received)
     {
         sig_save = *sig_info;
-        signal_reset(sig_info);
+        sig_save.signal_received = signal_reset(sig_info, 0);
     }
 
     /* initialize buffers */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 44176936..60e6c9fd 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -677,7 +677,7 @@ win32_signal_get(struct win32_signal *ws)
     }
     if (ret)
     {
-        throw_signal(ret); /* this will update signinfo_static.signal received */
+        throw_signal(ret); /* this will update siginfo_static.signal received */
     }
     return (siginfo_static.signal_received);
 }
-- 
2.34.1


