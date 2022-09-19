From: Antonio Quartulli <a@...2181...>
Date: Mon, 19 Sep 2022 15:41:08 +0200
Message-Id: <20220919134108.31316-1-a@...2181...>
In-Reply-To: <20220917231030.22565-1-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] implement --session-timeout
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
Cc: Dmitry Zelenkovsky <dmitry@...2697...>

From: Dmitry Zelenkovsky <dmitry@...2697...>

Disconnect clients after session-timeout expires.
session-timeout can be defined in ccd files in order to limit
per-user connection time.

Signed-off-by: Dmitry Zelenkovsky <dmitry@...2697...>
---
Changes from v1:
* added documentation to manpage
* added entry in Changes.rst
---
 Changes.rst                         |  6 ++++++
 doc/man-sections/link-options.rst   | 15 +++++++++++++++
 doc/man-sections/server-options.rst |  2 +-
 src/openvpn/forward.c               | 22 ++++++++++++++++++++++
 src/openvpn/init.c                  |  7 +++++++
 src/openvpn/openvpn.h               |  2 ++
 src/openvpn/options.c               |  7 +++++++
 src/openvpn/options.h               |  2 ++
 8 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/Changes.rst b/Changes.rst
index 2daa97fb..7c45a042 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -93,6 +93,12 @@ Inline auth username and password
     missing OpenVPN will prompt for input via stdin. This applies to inline'd
     http-proxy-user-pass too.
 
+Session timeout
+    It is now possible to terminate a session (or all) after a specified amount
+    of seconds has passed session commencement. This behaviour can be configured
+    using ``--session-timeout``. This option can be configured on the server, on
+    the client or can also be pushed.
+
 
 Deprecated features
 -------------------
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 373193aa..5b310d92 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -427,6 +427,21 @@ the local and the remote host.
   default) and you are using either ``--secret`` (shared-secret key mode)
   or TLS mode with ``--tls-auth``.
 
+--session-timeout n
+  Raises :code:`SIGTERM` for the client instance after ``n`` seconds since
+  the beginning of the session, forcing OpenVPN to disconnect.
+  In client mode, OpenVPN will disconnect and exit, while in server mode
+  all client sessions are terminated.
+
+  This option can also be specified in a client instance config file
+  using ``--client-config-dir`` or dynamically generated using a
+  ``--client-connect`` script. In these cases, only the related client
+  session is terminated.
+
+  When using option on the server side, it may be useful to push
+  ``--explicit-exit-notify`` in order to terminate a client session
+  and be informed about it.
+
 --socket-flags flags
   Apply the given flags to the OpenVPN transport socket. Currently, only
   :code:`TCP_NODELAY` is supported.
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 54ea8b66..9d0c73b6 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -426,7 +426,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   ``--inactive``, ``--ping``, ``--ping-exit``, ``--ping-restart``,
   ``--setenv``, ``--auth-token``, ``--persist-key``, ``--persist-tun``,
   ``--echo``, ``--comp-lzo``, ``--socket-flags``, ``--sndbuf``,
-  ``--rcvbuf``
+  ``--rcvbuf``, ``--session-timeout``
 
 --push-remove opt
   Selectively remove all ``--push`` options matching "opt" from the option
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index e5cee665..810cb8a7 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -630,6 +630,21 @@ encrypt_sign(struct context *c, bool comp_frag)
     buffer_turnover(orig_buf, &c->c2.to_link, &c->c2.buf, &b->read_tun_buf);
 }
 
+/*
+ * Should we exit due to session timeout?
+ */
+static void
+check_session_timeout(struct context *c)
+{
+    if (c->options.session_timeout
+        && event_timeout_trigger(&c->c2.session_interval, &c->c2.timeval,
+                                 ETT_DEFAULT))
+    {
+        msg(M_INFO, "Session timeout, exiting");
+        register_signal(c, SIGTERM, "session-timeout");
+    }
+}
+
 /*
  * Coarse timers work to 1 second resolution.
  */
@@ -681,6 +696,13 @@ process_coarse_timers(struct context *c)
         return;
     }
 
+    /* kill session if time is over */
+    check_session_timeout(c);
+    if (c->sig->signal_received)
+    {
+        return;
+    }
+
     /* restart if ping not received */
     check_ping_restart(c);
     if (c->sig->signal_received)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f2db8dd9..7b817612 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1322,6 +1322,13 @@ do_init_timers(struct context *c, bool deferred)
         event_timeout_init(&c->c2.inactivity_interval, c->options.inactivity_timeout, now);
     }
 
+    /* initialize inactivity timeout */
+    if (c->options.session_timeout)
+    {
+        event_timeout_init(&c->c2.session_interval, c->options.session_timeout,
+                           now);
+    }
+
     /* initialize pings */
     if (dco_enabled(&c->options))
     {
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 00cd652f..f74125aa 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -288,6 +288,8 @@ struct context_2
     struct event_timeout inactivity_interval;
     int64_t inactivity_bytes;
 
+    struct event_timeout session_interval;
+
     /* the option strings must match across peers */
     char *options_string_local;
     char *options_string_remote;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 93db0865..4566172b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -261,6 +261,7 @@ static const char usage_message[] =
     "                  for m seconds.\n"
     "--inactive n [bytes] : Exit after n seconds of activity on tun/tap device\n"
     "                  produces a combined in/out byte count < bytes.\n"
+    "--session-timeout n: Limit connection time to n seconds.\n"
     "--ping-exit n   : Exit if n seconds pass without reception of remote ping.\n"
     "--ping-restart n: Restart if n seconds pass without reception of remote ping.\n"
     "--ping-timer-rem: Run the --ping-exit/--ping-restart timer only if we have a\n"
@@ -1823,6 +1824,7 @@ show_settings(const struct options *o)
     SHOW_INT(keepalive_ping);
     SHOW_INT(keepalive_timeout);
     SHOW_INT(inactivity_timeout);
+    SHOW_INT(session_timeout);
     SHOW_INT64(inactivity_minimum_bytes);
     SHOW_INT(ping_send_timeout);
     SHOW_INT(ping_rec_timeout);
@@ -6598,6 +6600,11 @@ add_option(struct options *options,
             }
         }
     }
+    else if (streq(p[0], "session-timeout") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_TIMER);
+        options->session_timeout = positive_atoi(p[1]);
+    }
     else if (streq(p[0], "proto") && p[1] && !p[2])
     {
         int proto;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 4332acd3..2fb85b58 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -317,6 +317,8 @@ struct options
     int inactivity_timeout;     /* --inactive */
     int64_t inactivity_minimum_bytes;
 
+    int session_timeout;        /* Kill session after n seconds, regardless activity */
+
     int ping_send_timeout;      /* Send a TCP/UDP ping to remote every n seconds */
     int ping_rec_timeout;       /* Expect a TCP/UDP ping from remote at least once every n seconds */
     bool ping_timer_remote;     /* Run ping timer only if we have a remote address */
-- 
2.35.1


