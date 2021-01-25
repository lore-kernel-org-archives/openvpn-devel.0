From: Arne Schwabe <arne@...1227...>
Date: Mon, 25 Jan 2021 13:56:18 +0100
Message-Id: <20210125125628.30364-2-arne@...1227...>
In-Reply-To: <20210125125628.30364-1-arne@...1227...>
References: <20210125125628.30364-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 01/11] Change pull request timeout use a
 timeout rather than a number
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

This commit changes the count n_sent_push_requests to time_t based
push_request_timeout. This is more in line to our other timeouts which
are also time based instead of number retries based.

This does not change the behaviour but it prepares allowing to extend
the pull request timeout during a pending authentication. As a user
visible change we print the the time we waited for a timeout instead

Also update the man page to actually document that hand-window controls
this timeout.

Patch V2: grammar fix in manual page

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/tls-options.rst | 3 +++
 src/openvpn/forward.c            | 1 +
 src/openvpn/openvpn.h            | 2 +-
 src/openvpn/push.c               | 9 ++++++---
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 28cf6f1e..e13fb3c8 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -200,6 +200,9 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   will still use our expiring key for up to ``--tran-window`` seconds to
   maintain continuity of transmission of tunnel data.
 
+  The ``--hand-window`` parameter also controls the amount of time that
+  the OpenVPN client repeats the pull request until it times out.
+
 --key file
   Local peer's private key in .pem format. Use the private key which was
   generated when you built your peer's certificate (see ``--cert file``
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 67615a6b..76f5a032 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -299,6 +299,7 @@ check_connection_established(struct context *c)
             }
 #endif
             /* fire up push request right away (already 1s delayed) */
+            c->c2.push_request_timeout = now + c->options.handshake_window;
             event_timeout_init(&c->c2.push_request_interval, 0, now);
             reset_coarse_timers(c);
         }
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 4ca89ba9..e9bc7dad 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -462,7 +462,7 @@ struct context_2
     enum client_connect_status context_auth;
 
     struct event_timeout push_request_interval;
-    int n_sent_push_requests;
+    time_t push_request_timeout;
     bool did_pre_pull_restore;
 
     /* hash of pulled options, so we can compare when options change */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 26a6201f..fb6b9d17 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -369,14 +369,17 @@ cleanup:
 bool
 send_push_request(struct context *c)
 {
-    const int max_push_requests = c->options.handshake_window / PUSH_REQUEST_INTERVAL;
-    if (++c->c2.n_sent_push_requests <= max_push_requests)
+    struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+    struct key_state *ks = &session->key[KS_PRIMARY];
+
+    if (c->c2.push_request_timeout > now)
     {
         return send_control_channel_string(c, "PUSH_REQUEST", D_PUSH);
     }
     else
     {
-        msg(D_STREAM_ERRORS, "No reply from server after sending %d push requests", max_push_requests);
+        msg(D_STREAM_ERRORS, "No reply from server to push requests in %ds",
+            (int)(now - ks->established));
         c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- server-pushed connection reset */
         c->sig->signal_text = "no-push-reply";
         return false;
-- 
2.30.0


