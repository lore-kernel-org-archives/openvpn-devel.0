From: selva.nair@...277...
Date: Sun,  1 Jan 2023 16:51:09 -0500
Message-Id: <20230101215109.1521549-6-selva.nair@...277...>
In-Reply-To: <20230101215109.1521549-1-selva.nair@...277...>
References: <20230101215109.1521549-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/5] Improve signal handling using POSIX
 sigaction
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

Currently we use the old signal API which follows system-V or
BSD semantics depending on the platform and/or feature-set macros.
Further, signal has many weaknesses which makes proper masking
(blocking) of signals during update not possible.

Improve this:

- Use sigaction to properly mask signals when modifying.

- Change signal_reset() to read the current value and reset in one
  operation.  This is required to avoid change of signal state between
  check and reset-operations.
  This also allows us to eliminate resetting signal to 0 in
  init_instance() which can potentially lose signals. Instead, the signal
  is reset at the end of the SIGUSR1 and SIGHUP loops where their
  values are checked.

Notes:

SIG_SOURCE_CONNECTION_FAILED is retained in a hackish way. This value
has the same meaning as SIG_SOURCE_SOFT everywhere except where the
signal is printed. Looks cosmetic --- could be eliminated?

SIGUSR1 during dns resolution is ignored and reset to zero in the original
and that behaviour is retained. Not sure why this is needed.
Special handling of signals in openvpn_getaddrinfo() as if it is a syscall
is retained but looks superfluous.

In pre_init_signal_catch() we ignore some unix signals, but the same signals
from management are not ignored though both are treated as "HARD" signals.
For example, during auth-user-pass query, "kill -SIGUSR1 <pid>" will be ignored,
but "signal SIGUSR1" from management interface will cause M_FATAL and exit.
This is the current behaviour, but could be improved?

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/init.c    |   3 -
 src/openvpn/multi.c   |   5 +-
 src/openvpn/openvpn.c |   4 +-
 src/openvpn/sig.c     | 294 ++++++++++++++++++++++++++++++++----------
 src/openvpn/sig.h     |   7 +-
 src/openvpn/socket.c  |  12 +-
 6 files changed, 239 insertions(+), 86 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index eec25acf..eabc8ea1 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4228,9 +4228,6 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
         do_inherit_env(c, env);
     }
 
-    /* signals caught here will abort */
-    signal_reset(c->sig);
-
     if (c->mode == CM_P2P)
     {
         init_management_callback_p2p(c);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c2254399..1e7e76f2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3828,7 +3828,7 @@ multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
                        &m->deferred_shutdown_signal.wakeup,
                        compute_wakeup_sigma(&m->deferred_shutdown_signal.wakeup));
 
-    signal_reset(m->top.sig);
+    signal_reset(m->top.sig, 0);
 }
 
 /*
@@ -3838,12 +3838,11 @@ multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
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
index 413a750b..d590b166 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -333,14 +333,14 @@ openvpn_main(int argc, char *argv[])
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
index d6b18cb1..87063913 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -6,6 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2016-2022 Selva Nair <selva.nair@...277...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -60,6 +61,9 @@ static const struct signame signames[] = {
     { SIGUSR2, 1, "SIGUSR2", "sigusr2" }
 };
 
+/* mask for hard signals from management or windows */
+static unsigned long long ignored_hard_signals_mask;
+
 int
 parse_signal(const char *signame)
 {
@@ -114,36 +118,174 @@ signal_description(const int signum, const char *sigtext)
     }
 }
 
+/**
+ * Block (i.e., defer) all unix signals.
+ * Used while directly modifying the volatile elements of
+ * siginfo_static.
+ */
+static inline void
+block_async_signals(void)
+{
+#ifndef _WIN32
+    sigset_t all;
+    sigfillset(&all); /* all signals */
+
+    sigprocmask(SIG_BLOCK, &all, NULL);
+#endif
+}
+
+/**
+ * Unblock all unix signals.
+ */
+static inline void
+unblock_async_signals(void)
+{
+#ifndef _WIN32
+    sigset_t none;
+    sigemptyset(&none);
+    sigprocmask(SIG_SETMASK, &none, NULL);
+#endif
+}
+
+/**
+ * Private function for registering a signal in the specified
+ * signal_info struct. This could be the global siginfo_static
+ * or a context specific signinfo struct.
+ *
+ * A signal is allowed to override an already registered
+ * one only if it has a higher priority.
+ * Returns true if the signal is set, false otherwise.
+ *
+ * Do not call any "AS-unsafe" functions such as printf from here
+ * as this may be called from signal_handler().
+ */
+static bool
+try_throw_signal(struct signal_info *si, int signum, int source)
+{
+    bool ret = false;
+    if (signal_priority(signum) >= signal_priority(si->signal_received))
+    {
+        si->signal_received = signum;
+        si->source = source;
+        ret = true;
+    }
+    return ret;
+}
+
+/**
+ * Throw a hard signal. Called from management and when windows
+ * signals are received through ctrl-c, exit event etc.
+ */
 void
 throw_signal(const int signum)
 {
-    if (signal_priority(signum) >= signal_priority(siginfo_static.signal_received))
+    if (ignored_hard_signals_mask & (1LL << signum))
+    {
+        dmsg(D_LOW, "Signal %s is currently ignored", signal_name(signum, true));
+        return;
+    }
+    block_async_signals();
+
+    if (!try_throw_signal(&siginfo_static, signum, SIG_SOURCE_HARD))
+    {
+        dmsg(D_LOW, "Ignoring %s when %s has been received", signal_name(signum, true),
+             signal_name(siginfo_static.signal_received, true));
+    }
+    else
     {
-        siginfo_static.signal_received = signum;
-        siginfo_static.source = SIG_SOURCE_HARD;
+        dmsg(D_LOW, "Throw signal: %s ", signal_name(signum, true));
     }
+
+    unblock_async_signals();
 }
 
+/**
+ * Throw a soft global signal. Used to register internally generated signals
+ * due to errors that require a restart or exit, or restart requests
+ * received from the server. A textual description of the signal may
+ * be provided.
+ */
 void
 throw_signal_soft(const int signum, const char *signal_text)
 {
-    if (signal_priority(signum) >= signal_priority(siginfo_static.signal_received))
+    block_async_signals();
+
+    if (try_throw_signal(&siginfo_static, signum, SIG_SOURCE_SOFT))
     {
-        siginfo_static.signal_received = signum;
-        siginfo_static.source = SIG_SOURCE_SOFT;
         siginfo_static.signal_text = signal_text;
     }
+    else
+    {
+        dmsg(D_LOW, "Ignoring %s when %s has been received", signal_name(signum, true),
+             signal_name(siginfo_static.signal_received, true));
+    }
+
+    unblock_async_signals();
 }
 
+/**
+ * Register a soft signal in the signal_info struct si respecting priority.
+ * si may be a pointer to the global siginfo_static or a context-specific
+ * signal in a multi-instance or a temporary variable.
+ */
 void
-signal_reset(struct signal_info *si)
+register_signal(struct signal_info *si, int signum, const char *signal_text)
 {
+    if (si == &siginfo_static) /* attempting to alter the global signal */
+    {
+        block_async_signals();
+    }
+
+    if (try_throw_signal(si, signum, SIG_SOURCE_SOFT))
+    {
+        si->signal_text = signal_text;
+        if (signal_text && strcmp(signal_text, "connection-failed") == 0)
+        {
+            si->source = SIG_SOURCE_CONNECTION_FAILED;
+        }
+    }
+    else
+    {
+        dmsg(D_LOW, "Ignoring %s when %s has been received", signal_name(signum, true),
+             signal_name(si->signal_received, true));
+    }
+
+    if (si == &siginfo_static)
+    {
+        unblock_async_signals();
+    }
+}
+
+/**
+ * Clear the signal if its current value equals signum. If
+ * signum is zero the signal is cleared independent of its current
+ * value. Returns the current value of the signal.
+ */
+int
+signal_reset(struct signal_info *si, int signum)
+{
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
@@ -239,12 +381,10 @@ signal_restart_status(const struct signal_info *si)
 static void
 signal_handler(const int signum)
 {
-    throw_signal(signum);
-    signal(signum, signal_handler);
+    try_throw_signal(&siginfo_static, signum, SIG_SOURCE_HARD);
 }
 #endif
 
-
 /* set handlers for unix signals */
 
 #define SM_UNDEF     0
@@ -256,28 +396,65 @@ void
 pre_init_signal_catch(void)
 {
 #ifndef _WIN32
+    sigset_t block_mask;
+    struct sigaction sa;
+    CLEAR(sa);
+
+    sigfillset(&block_mask); /* all signals */
+    sa.sa_handler = signal_handler;
+    sa.sa_mask = block_mask;  /* signals blocked inside the handler */
+    sa.sa_flags = SA_RESTART; /* match with the behaviour of signal() on Linux and BSD */
+
     signal_mode = SM_PRE_INIT;
-    signal(SIGINT, signal_handler);
-    signal(SIGTERM, signal_handler);
-    signal(SIGHUP, SIG_IGN);
-    signal(SIGUSR1, SIG_IGN);
-    signal(SIGUSR2, SIG_IGN);
-    signal(SIGPIPE, SIG_IGN);
+    sigaction(SIGINT, &sa, NULL);
+    sigaction(SIGTERM, &sa, NULL);
+
+    sa.sa_handler = SIG_IGN;
+    sigaction(SIGHUP, &sa, NULL);
+    sigaction(SIGUSR1, &sa, NULL);
+    sigaction(SIGUSR2, &sa, NULL);
+    sigaction(SIGPIPE, &sa, NULL);
 #endif /* _WIN32 */
+
+    /* similar "hard" signals from management not masked -- why ? */
 }
 
 void
 post_init_signal_catch(void)
 {
 #ifndef _WIN32
+    sigset_t block_mask;
+    struct sigaction sa;
+    CLEAR(sa);
+
+    sigfillset(&block_mask); /* all signals */
+    sa.sa_handler = signal_handler;
+    sa.sa_mask = block_mask; /* signals blocked inside the handler */
+    sa.sa_flags = SA_RESTART; /* match with the behaviour of signal() on Linux and BSD */
+
     signal_mode = SM_POST_INIT;
-    signal(SIGINT, signal_handler);
-    signal(SIGTERM, signal_handler);
-    signal(SIGHUP, signal_handler);
-    signal(SIGUSR1, signal_handler);
-    signal(SIGUSR2, signal_handler);
-    signal(SIGPIPE, SIG_IGN);
-#endif
+    sigaction(SIGINT, &sa, NULL);
+    sigaction(SIGTERM, &sa, NULL);
+    sigaction(SIGHUP, &sa, NULL);
+    sigaction(SIGUSR1, &sa, NULL);
+    sigaction(SIGUSR2, &sa, NULL);
+    sa.sa_handler = SIG_IGN;
+    sigaction(SIGPIPE, &sa, NULL);
+#endif /* _WIN32 */
+}
+
+void
+halt_low_priority_signals()
+{
+#ifndef _WIN32
+    struct sigaction sa;
+    CLEAR(sa);
+    sa.sa_handler = SIG_IGN;
+    sigaction(SIGHUP, &sa, NULL);
+    sigaction(SIGUSR1, &sa, NULL);
+    sigaction(SIGUSR2, &sa, NULL);
+#endif /* _WIN32 */
+    ignored_hard_signals_mask = (1LL << SIGHUP) | (1LL << SIGUSR1) | (1LL << SIGUSR2);
 }
 
 /* called after daemonization to retain signal settings */
@@ -341,7 +518,6 @@ print_status(const struct context *c, struct status_output *so)
     gc_free(&gc);
 }
 
-
 /* Small helper function to determine if we should send the exit notification
  * via control channel */
 static inline bool
@@ -371,8 +547,15 @@ process_explicit_exit_notification_init(struct context *c)
     event_timeout_init(&c->c2.explicit_exit_notification_interval, 1, 0);
     reset_coarse_timers(c);
 
-    signal_reset(c->sig);
+    /* Windows exit event will continue trigering SIGTERM -- halt it */
     halt_non_edge_triggered_signals();
+
+    /* Before resetting the signal, ensure hard low priority signals
+     * will be ignored during the exit notification period.
+     */
+    halt_low_priority_signals(); /* Set hard SIGUSR1/SIGHUP/SIGUSR2 to be ignored */
+    signal_reset(c->sig, 0);
+
     c->c2.explicit_exit_notification_time_wait = now;
 
     /* Check if we are in TLS mode and should send the notification via data
@@ -422,7 +605,7 @@ process_sigusr2(const struct context *c)
     struct status_output *so = status_open(NULL, 0, M_INFO, NULL, 0);
     print_status(c, so);
     status_close(so);
-    signal_reset(c->sig);
+    signal_reset(c->sig, SIGUSR2);
 }
 
 static bool
@@ -439,33 +622,21 @@ process_sigterm(struct context *c)
 }
 
 /**
- * If a restart signal is received during exit-notification, reset the
- * signal and return true. If its a soft restart signal from the event loop
- * which implies the loop cannot continue, remap to SIGTERM to exit promptly.
+ * If a soft restart signal is received during exit-notification, it
+ * implies the event loop cannot continue: remap to SIGTERM to exit promptly.
+ * Hard restart signals are ignored during exit notification wait.
  */
-static bool
-ignore_restart_signals(struct context *c)
+static void
+remap_restart_signals(struct context *c)
 {
-    bool ret = false;
-    if ( (c->sig->signal_received == SIGUSR1 || c->sig->signal_received == SIGHUP)
-         && event_timeout_defined(&c->c2.explicit_exit_notification_interval) )
+    if ((c->sig->signal_received == SIGUSR1 || c->sig->signal_received == SIGHUP)
+        && event_timeout_defined(&c->c2.explicit_exit_notification_interval)
+        && c->sig->source != SIG_SOURCE_HARD)
     {
-        if (c->sig->source == SIG_SOURCE_HARD)
-        {
-            msg(M_INFO, "Ignoring %s received during exit notification",
-                signal_name(c->sig->signal_received, true));
-            signal_reset(c->sig);
-            ret = true;
-        }
-        else
-        {
-            msg(M_INFO, "Converting soft %s received during exit notification to SIGTERM",
-                signal_name(c->sig->signal_received, true));
-            register_signal(c->sig, SIGTERM, "exit-with-notification");
-            ret = false;
-        }
+        msg(M_INFO, "Converting soft %s received during exit notification to SIGTERM",
+            signal_name(c->sig->signal_received, true));
+        register_signal(c->sig, SIGTERM, "exit-with-notification");
     }
-    return ret;
 }
 
 bool
@@ -473,11 +644,9 @@ process_signal(struct context *c)
 {
     bool ret = true;
 
-    if (ignore_restart_signals(c))
-    {
-        ret = false;
-    }
-    else if (c->sig->signal_received == SIGTERM || c->sig->signal_received == SIGINT)
+    remap_restart_signals(c);
+
+    if (c->sig->signal_received == SIGTERM || c->sig->signal_received == SIGINT)
     {
         ret = process_sigterm(c);
     }
@@ -488,14 +657,3 @@ process_signal(struct context *c)
     }
     return ret;
 }
-
-void
-register_signal(struct signal_info *si, int sig, const char *text)
-{
-    if (signal_priority(sig) >= signal_priority(si->signal_received))
-    {
-        si->signal_received = sig;
-        si->signal_text = text;
-        si->source = SIG_SOURCE_SOFT;
-    }
-}
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 83adc543..b2845d97 100644
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
index 59d89352..61971906 100644
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
@@ -1588,7 +1587,6 @@ socket_connect(socket_descriptor_t *sd,
         openvpn_close_socket(*sd);
         *sd = SOCKET_UNDEFINED;
         register_signal(sig_info, SIGUSR1, "connection-failed");
-        sig_info->source = SIG_SOURCE_CONNECTION_FAILED;
     }
     else
     {
@@ -1782,11 +1780,7 @@ resolve_remote(struct link_socket *sock,
             }
             if (status!=0)
             {
-                if (signal_received)
-                {
-                    /* potential overwrite of signal */
-                    register_signal(sig_info, SIGUSR1, "socks-resolve-failure");
-                }
+                register_signal(sig_info, SIGUSR1, "socks-resolve-failure");
                 goto done;
             }
         }
@@ -2177,7 +2171,7 @@ link_socket_init_phase2(struct context *c)
     if (sig_info->signal_received)
     {
         sig_save = *sig_info;
-        signal_reset(sig_info);
+        sig_save.signal_received = signal_reset(sig_info, 0);
     }
 
     /* initialize buffers */
-- 
2.34.1


