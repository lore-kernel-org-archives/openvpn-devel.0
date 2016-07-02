From: Selva Nair <selva.nair@...277...>
Date: Sat,  2 Jul 2016 19:34:48 -0400
Message-Id: <1467502488-31549-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1467430368-25437-1-git-send-email-selva.nair@...277...>
References: <1467430368-25437-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Exponentially back off on repeated
	connect retries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

- When the number of retries per remote exceeds a limit
  (hard coded to 5), double the restart pause interval
  for each additional retry per remote.
- Trigger a SIGHUP to reset the retry count when the pause
  interval exceeds 1024 times the base value of restart pause.
  (removed in v2 of the patch)

The base value of restart pause is set using --connect-retry
(5 seconds by default).

v2 changes (based on suggestions from Arne Schwabe <arne@...1227...>)

- Do not throw SIGHUP.
- Add an optional argument to "--connect-retry n [m]" where 'm'
  specifies the max value of restart pause interval (default
  300 sec).
  E.g., "--connect-retry 5 1800" will cause the restart pause to
  scale up starting at 5 until it exceeds 1800 seconds at which
  point it gets capped at 1800.
- If n == m no slow down will occur.
- While at it, fix typos and clarify the description of connect-retry-max
  in the man page and Changes.rst

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 Changes.rst           |    8 ++++++--
 doc/openvpn.8         |   19 ++++++++++++-------
 src/openvpn/init.c    |    8 ++++++++
 src/openvpn/options.c |   13 ++++++++++---
 src/openvpn/options.h |    1 +
 5 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index d12cdad..59722e2 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -75,8 +75,8 @@ User-visible Changes
   In --static mode connect-timeout specifies the timeout for TCP and
   proxy connection establishment
 
-- connect-retry now specifies the maximum number of unsucessfully
-  trying all remote/connection entries before exiting.
+- connect-retry-max now specifies the maximum number of unsuccessful
+  attempts of each remote/connection entry before exiting.
 
 - sndbuf and recvbuf default now to OS default instead of 64k
 
@@ -120,6 +120,10 @@ User-visible Changes
 - --http-proxy-retry and --sock-proxy-retry have been removed. Proxy connections
     will now behave like regular connection entries and generate a USR1 on failure.
 
+- --connect-retry gets a optional third argument that specifies the maximum
+  time in seconds to wait between reconnection attempts when an exponential
+  backoff is triggered due to repeated retries. Default = 300 seconds.
+
 Maintainer-visible changes
 --------------------------
 - OpenVPN no longer supports building with crypto support, but without TLS
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 64cc934..3ca6f50 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -462,22 +462,27 @@ application-level UDP protocols, or tunneling protocols which don't
 possess a built-in reliability layer.
 .\"*********************************************************
 .TP
-.B \-\-connect\-retry n
+.B \-\-connect\-retry n [max]
 Wait
 .B n
-seconds  between connection attempts (default=5).
+seconds  between connection attempts (default=5). Repeated reconnection
+attempts are slowed down after 5 retries per remote by doubling the wait
+time after each unsuccessful attempt. The optional argument
+.B max
+specifies the maximum value of wait time in seconds at which it gets
+capped (default=300).
 .\"*********************************************************
 .TP
 .B \-\-connect\-retry\-max n
 .B n
-specifies the number of times all
+specifies the number of times each
 .B \-\-remote
-respectively
+or
 .B <connection>
-statements are tried. Specifiying
+entry is tried. Specifying
 .B n
-as one would try each entry exactly once. A sucessful connection
-resets the counter. (default=umlimited).
+as one would try each entry exactly once. A successful connection
+resets the counter. (default=unlimited).
 .\"*********************************************************
 .TP
 .B \-\-show\-proxy\-settings
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 498d36f..247a526 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1955,6 +1955,7 @@ static void
 socket_restart_pause (struct context *c)
 {
   int sec = 2;
+  int backoff = 0;
 
   switch (c->options.ce.proto)
     {
@@ -1977,6 +1978,13 @@ socket_restart_pause (struct context *c)
     sec = 10;
 #endif
 
+  /* Slow down reconnection after 5 retries per remote */
+  backoff = (c->options.unsuccessful_attempts / c->options.connection_list->len) - 4;
+  if (backoff > 0 && sec < 1<<16)
+    sec = max_int (sec, 1) << min_int (backoff, 15);
+  if (sec > c->options.ce.connect_retry_seconds_max)
+    sec = c->options.ce.connect_retry_seconds_max;
+
   if (c->persist.restart_sleep_seconds > 0 && c->persist.restart_sleep_seconds > sec)
     sec = c->persist.restart_sleep_seconds;
   else if (c->persist.restart_sleep_seconds == -1)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cf971a6..09fe9ed 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -123,8 +123,10 @@ static const char usage_message[] =
   "                  p = udp (default), tcp-server, or tcp-client\n"
   "--proto-force p : only consider protocol p in list of connection profiles.\n"
   "                  p = udp6, tcp6-server, or tcp6-client (ipv6)\n"
-  "--connect-retry n : For --proto tcp-client, number of seconds to wait\n"
-  "                    between connection retries (default=%d).\n"
+  "--connect-retry n [m] : For client, number of seconds to wait between\n"
+  "                  connection retries (default=%d). On repeated retries\n"
+  "                  the wait time is exponentially increased to a maximum of m\n"
+  "                  (default=%d).\n"
   "--connect-retry-max n : Maximum connection attempt retries, default infinite.\n"
   "--http-proxy s p [up] [auth] : Connect to remote host\n"
   "                  through an HTTP proxy at address s and port p.\n"
@@ -770,6 +772,7 @@ init_options (struct options *o, const bool init_gc)
   o->ce.af = AF_UNSPEC;
   o->ce.bind_ipv6_only = false;
   o->ce.connect_retry_seconds = 5;
+  o->ce.connect_retry_seconds_max = 300;
   o->ce.connect_timeout = 120;
   o->connect_retry_max = 0;
   o->ce.local_port = o->ce.remote_port = OPENVPN_PORT;
@@ -3479,6 +3482,7 @@ usage (void)
   fprintf (fp, usage_message,
 	   title_string,
 	   o.ce.connect_retry_seconds,
+	   o.ce.connect_retry_seconds_max,
 	   o.ce.local_port, o.ce.remote_port,
 	   TUN_MTU_DEFAULT, TAP_MTU_EXTRA_DEFAULT,
 	   o.verbosity,
@@ -4724,10 +4728,13 @@ add_option (struct options *options,
       if (p[1])
 	options->ip_remote_hint=p[1];
     }
-  else if (streq (p[0], "connect-retry") && p[1] && !p[2])
+  else if (streq (p[0], "connect-retry") && p[1] && !p[3])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
       options->ce.connect_retry_seconds = positive_atoi (p[1]);
+      if (p[2])
+         options->ce.connect_retry_seconds_max =
+            max_int (positive_atoi (p[2]), options->ce.connect_retry_seconds);
     }
   else if ((streq (p[0], "connect-timeout") || streq (p[0], "server-poll-timeout"))
 	    && p[1] && !p[2])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 7bb36c9..486bf5d 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -96,6 +96,7 @@ struct connection_entry
   bool bind_ipv6_only;
   bool bind_local;
   int connect_retry_seconds;
+  int connect_retry_seconds_max;
   int connect_timeout;
   struct http_proxy_options *http_proxy_options;
   const char *socks_proxy_server;
-- 
1.7.10.4


