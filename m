From: selva.nair@...277...
Date: Sun,  1 Jan 2023 16:51:07 -0500
Message-Id: <20230101215109.1521549-4-selva.nair@...277...>
In-Reply-To: <20230101215109.1521549-1-selva.nair@...277...>
References: <20230101215109.1521549-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/5] Assign and honour signal priority order
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

Signals are ordered as SIGUSR2, SIGUSR1, SIGHUP, SIGTERM, SIGINT
in increasing priority. Lower priority signals are not allowed to
overwrite higher ones.

This should fix Trac #311, #639 -- SIGTER/SIGINT lost during dns resolution.
(except for the Windows-specific bug handled in next commit)

On sending SIGTERM during dns resolution, it still takes several seconds
to terminate as the signal will get processed only after getaddrinfo times out
twice (in phase1 and phase2 inits).

Github: fixes OpenVPN/openvpn#205
Note: one has to still wait for address resolution to time out as getaddrinfo()
is no interruptible. But a single ctrl-C (and some patience) is enough.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/proxy.c  |  5 +----
 src/openvpn/sig.c    | 45 ++++++++++++++++++++++++++++++++------------
 src/openvpn/socket.c |  8 ++++++--
 src/openvpn/socks.c  | 14 ++++----------
 4 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 91121f25..120ba85e 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -1080,10 +1080,7 @@ done:
     return ret;
 
 error:
-    if (!sig_info->signal_received)
-    {
-        register_signal(sig_info, SIGUSR1, "HTTP proxy error"); /* SOFT-SIGUSR1 -- HTTP proxy error */
-    }
+    register_signal(sig_info, SIGUSR1, "HTTP proxy error"); /* SOFT-SIGUSR1 -- HTTP proxy error */
     gc_free(&gc);
     return ret;
 }
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index e462b93e..d6b18cb1 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -47,16 +47,17 @@ struct signal_info siginfo_static; /* GLOBAL */
 
 struct signame {
     int value;
+    int priority;
     const char *upper;
     const char *lower;
 };
 
 static const struct signame signames[] = {
-    { SIGINT,  "SIGINT",  "sigint"},
-    { SIGTERM, "SIGTERM", "sigterm" },
-    { SIGHUP,  "SIGHUP",  "sighup" },
-    { SIGUSR1, "SIGUSR1", "sigusr1" },
-    { SIGUSR2, "SIGUSR2", "sigusr2" }
+    { SIGINT, 5, "SIGINT",  "sigint"},
+    { SIGTERM, 4, "SIGTERM", "sigterm" },
+    { SIGHUP, 3, "SIGHUP",  "sighup" },
+    { SIGUSR1, 2, "SIGUSR1", "sigusr1" },
+    { SIGUSR2, 1, "SIGUSR2", "sigusr2" }
 };
 
 int
@@ -73,6 +74,19 @@ parse_signal(const char *signame)
     return -1;
 }
 
+static int
+signal_priority(int sig)
+{
+    for (size_t i = 0; i < SIZE(signames); ++i)
+    {
+        if (sig == signames[i].value)
+        {
+            return signames[i].priority;
+        }
+    }
+    return -1;
+}
+
 const char *
 signal_name(const int sig, const bool upper)
 {
@@ -103,16 +117,22 @@ signal_description(const int signum, const char *sigtext)
 void
 throw_signal(const int signum)
 {
-    siginfo_static.signal_received = signum;
-    siginfo_static.source = SIG_SOURCE_HARD;
+    if (signal_priority(signum) >= signal_priority(siginfo_static.signal_received))
+    {
+        siginfo_static.signal_received = signum;
+        siginfo_static.source = SIG_SOURCE_HARD;
+    }
 }
 
 void
 throw_signal_soft(const int signum, const char *signal_text)
 {
-    siginfo_static.signal_received = signum;
-    siginfo_static.source = SIG_SOURCE_SOFT;
-    siginfo_static.signal_text = signal_text;
+    if (signal_priority(signum) >= signal_priority(siginfo_static.signal_received))
+    {
+        siginfo_static.signal_received = signum;
+        siginfo_static.source = SIG_SOURCE_SOFT;
+        siginfo_static.signal_text = signal_text;
+    }
 }
 
 void
@@ -472,9 +492,10 @@ process_signal(struct context *c)
 void
 register_signal(struct signal_info *si, int sig, const char *text)
 {
-    if (si->signal_received != SIGTERM)
+    if (signal_priority(sig) >= signal_priority(si->signal_received))
     {
         si->signal_received = sig;
+        si->signal_text = text;
+        si->source = SIG_SOURCE_SOFT;
     }
-    si->signal_text = text;
 }
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index faaa2748..59d89352 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2277,8 +2277,12 @@ link_socket_init_phase2(struct context *c)
 done:
     if (sig_save.signal_received)
     {
-        /* This can potentially lose a saved high priority signal -- to be fixed */
-        if (!sig_info->signal_received)
+        /* Always restore the saved signal -- register/throw_signal will handle priority */
+        if (sig_save.source == SIG_SOURCE_HARD && sig_info == &siginfo_static)
+        {
+            throw_signal(sig_save.signal_received);
+        }
+        else
         {
             register_signal(sig_info, sig_save.signal_received, sig_save.signal_text);
         }
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index b2ca3744..8f2ae226 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -499,11 +499,8 @@ establish_socks_proxy_passthru(struct socks_proxy_info *p,
     return;
 
 error:
-    if (!sig_info->signal_received)
-    {
-        /* SOFT-SIGUSR1 -- socks error */
-        register_signal(sig_info, SIGUSR1, "socks-error");
-    }
+    /* SOFT-SIGUSR1 -- socks error */
+    register_signal(sig_info, SIGUSR1, "socks-error");
     return;
 }
 
@@ -543,11 +540,8 @@ establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
     return;
 
 error:
-    if (!sig_info->signal_received)
-    {
-        /* SOFT-SIGUSR1 -- socks error */
-        register_signal(sig_info, SIGUSR1, "socks-error");
-    }
+    /* SOFT-SIGUSR1 -- socks error */
+    register_signal(sig_info, SIGUSR1, "socks-error");
     return;
 }
 
-- 
2.34.1


