From: selva.nair@...277...
Date: Sat, 28 Jan 2023 16:59:00 -0500
Message-Id: <20230128215901.2207208-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Improve signal handling using POSIX
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
(deferring) of signals during update not possible.

Improve this:

- Use sigaction to properly mask signals when modifying.

Notes:

Updating signal_reset() is handled in a follow up patch

SIG_SOURCE_CONNECTION_FAILED is retained in a hackish way. This value
has the same meaning as SIG_SOURCE_SOFT everywhere except where the
signal is printed. Looks cosmetic --- could be eliminated?

In pre_init_signal_catch() we ignore some unix signals, but the same signals
from management are not ignored though both are treated as "HARD" signals.
For example, during auth-user-pass query, "kill -SIGUSR1 <pid>" will be ignored,
but "signal SIGUSR1" from management interface will cause M_FATAL and exit.
This is the current behaviour, but could be improved?

This patch was originally submitted as 5/5 of the signals series. Now this is
1/2 of a new series with signal_reset changes moved to 2/2

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/errlevel.h |   1 +
 src/openvpn/sig.c      | 264 +++++++++++++++++++++++++++++++----------
 src/openvpn/socket.c   |   1 -
 3 files changed, 202 insertions(+), 64 deletions(-)

diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index c69ea91d..dedc0790 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -115,6 +115,7 @@
 #define D_CLIENT_NAT         LOGLEV(6, 69, M_DEBUG)  /* show client NAT debug info */
 #define D_XKEY               LOGLEV(6, 69, M_DEBUG)  /* show xkey-provider debug info */
 #define D_DCO_DEBUG          LOGLEV(6, 69, M_DEBUG)  /* show DCO related lowlevel debug messages */
+#define D_SIGNAL_DEBUG       LOGLEV(6, 69, M_DEBUG)  /* show signal related debug messages */
 
 #define D_SHOW_KEYS          LOGLEV(7, 70, M_DEBUG)  /* show data channel encryption keys */
 #define D_SHOW_KEY_SOURCE    LOGLEV(7, 70, M_DEBUG)  /* show data channel key source entropy */
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 0d534601..559ca35d 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -6,6 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2016-2023 Selva Nair <selva.nair@...277...>
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
@@ -114,24 +118,144 @@ signal_description(const int signum, const char *sigtext)
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
+        msg(D_SIGNAL_DEBUG, "Signal %s is currently ignored", signal_name(signum, true));
+        return;
+    }
+    block_async_signals();
+
+    if (!try_throw_signal(&siginfo_static, signum, SIG_SOURCE_HARD))
     {
-        siginfo_static.signal_received = signum;
-        siginfo_static.source = SIG_SOURCE_HARD;
+        msg(D_SIGNAL_DEBUG, "Ignoring %s when %s has been received", signal_name(signum, true),
+            signal_name(siginfo_static.signal_received, true));
     }
+    else
+    {
+        msg(D_SIGNAL_DEBUG, "Throw signal (hard): %s ", signal_name(signum, true));
+    }
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
+        msg(D_SIGNAL_DEBUG, "Throw signal (soft): %s (%s)", signal_name(signum, true),
+            signal_text);
+    }
+    else
+    {
+        msg(D_SIGNAL_DEBUG, "Ignoring %s when %s has been received", signal_name(signum, true),
+            signal_name(siginfo_static.signal_received, true));
+    }
+
+    unblock_async_signals();
+}
+
+/**
+ * Register a soft signal in the signal_info struct si respecting priority.
+ * si may be a pointer to the global siginfo_static or a context-specific
+ * signal in a multi-instance or a temporary variable.
+ */
+void
+register_signal(struct signal_info *si, int signum, const char *signal_text)
+{
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
+        msg(D_SIGNAL_DEBUG, "register signal: %s (%s)", signal_name(signum, true),
+            signal_text);
+    }
+    else
+    {
+        msg(D_SIGNAL_DEBUG, "Ignoring %s when %s has been received", signal_name(signum, true),
+            signal_name(si->signal_received, true));
+    }
+
+    if (si == &siginfo_static)
+    {
+        unblock_async_signals();
     }
 }
 
@@ -239,12 +363,10 @@ signal_restart_status(const struct signal_info *si)
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
@@ -256,13 +378,24 @@ void
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
 }
 
@@ -270,14 +403,38 @@ void
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
@@ -341,7 +498,6 @@ print_status(const struct context *c, struct status_output *so)
     gc_free(&gc);
 }
 
-
 /* Small helper function to determine if we should send the exit notification
  * via control channel */
 static inline bool
@@ -371,8 +527,15 @@ process_explicit_exit_notification_init(struct context *c)
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
+    signal_reset(c->sig);
+
     c->c2.explicit_exit_notification_time_wait = now;
 
     /* Check if we are in TLS mode and should send the notification via data
@@ -439,33 +602,21 @@ process_sigterm(struct context *c)
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
@@ -473,11 +624,9 @@ process_signal(struct context *c)
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
@@ -488,14 +637,3 @@ process_signal(struct context *c)
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
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index a883ac4a..baafe1e6 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1588,7 +1588,6 @@ socket_connect(socket_descriptor_t *sd,
         openvpn_close_socket(*sd);
         *sd = SOCKET_UNDEFINED;
         register_signal(sig_info, SIGUSR1, "connection-failed");
-        sig_info->source = SIG_SOURCE_CONNECTION_FAILED;
     }
     else
     {
-- 
2.34.1


