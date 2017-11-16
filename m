From: Steffan Karger <steffan@...1856...>
Date: Thu, 16 Nov 2017 15:09:58 +0100
Message-Id: <20171116140958.12847-1-steffan@...1856...>
In-Reply-To: <830a17f8babbca92e21d64c1324a15b1.squirrel@...2257...>
References: <830a17f8babbca92e21d64c1324a15b1.squirrel@...2257...>
Subject: [Openvpn-devel] [PATCH v4] Add per session pseudo-random jitter to
 --reneg-sec intervals
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

From: Simon Matter <simon.matter@...2249...>

While we were suffering from the "TLS Renegotiation Slowdown" bug here
https://community.openvpn.net/openvpn/ticket/854 we realized that there is
still room for improvement in our use case.

It appears that TLS renegotiation is getting more and more expensive in
terms of CPU cycles with recent changes for more security. To make things
worse, we realized that most renegotiation procedures took place at almost
the same time and increased the CPU load too much during these periods.
That's especially true on large, multi-instance openvpn setups.

I've created attached patch to add a per session pseudo-random component to
the --reneg-sec intervals so that renegotiation is evenly spread over time.
It is configured by simply adding a second value to --reneg-sec as
described in the --help text:

--reneg-sec max [min] : Renegotiate data chan. key after at most max
                  (default=3600) and at least min (default 90% of max on
                  servers and equal to max on clients).

The jitter is only enabled by default on servers, because the actual reneg
time is min(reneg_server, reneg_client).  Introducing jitter at both ends
would bias the actual reneg time to the min value.

Note that the patch also slightly changes the log output to show the sec
value in the same way as the bytes/pkts values:

TLS: soft reset sec=3084/3084 bytes=279897/-1 pkts=1370/0

The idea and first versions of this patch are from Simon Matter.  Steffan
Karger later incorporated the mailing list comments into this patch.  So
credits go to Simon, and all bugs are Steffan's fault ;-)

Signed-off-by: Simon Matter <simon.matter@...2249...>
Signed-off-by: Steffan Karger <steffan@...1856...>
---
v3: incorporate comments from openvpn-devel@, don't add jitter by
    default on the client side.
v4: fix printing of reneg interval, clarify/typofix comments

 doc/openvpn.8         | 26 +++++++++++++++++++++-----
 src/openvpn/init.c    | 15 ++++++++++++++-
 src/openvpn/options.c | 11 +++++++++--
 src/openvpn/options.h |  1 +
 src/openvpn/ssl.c     |  6 +++---
 5 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a4189ac2..eb5258f9 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -33,7 +33,7 @@
 .\" .ft -- normal face
 .\" .in +|-{n} -- indent
 .\"
-.TH openvpn 8 "25 August 2016"
+.TH openvpn 8 "04 April 2017"
 .\"*********************************************************
 .SH NAME
 openvpn \- secure IP tunnel daemon.
@@ -4957,10 +4957,26 @@ Renegotiate data channel key after
 packets sent and received (disabled by default).
 .\"*********************************************************
 .TP
-.B \-\-reneg\-sec n
-Renegotiate data channel key after
-.B n
-seconds (default=3600).
+.B \-\-reneg\-sec max [min]
+Renegotiate data channel key after at most
+.B max
+seconds (default=3600) and at least
+.B min
+seconds (default is 90% of
+.B max
+for servers, and equal to
+.B max
+for clients).
+
+The effective
+.B reneg\-sec
+value used is per session pseudo-uniform-randomized between
+.B min
+and
+.B max\fR.
+
+With the default value of 3600 this results in an effective per session value
+in the range of 3240..3600 seconds for servers, or just 3600 for clients.
 
 When using dual\-factor authentication, note that this default value may
 cause the end user to be challenged to reauthorize once per hour.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1ed2c55e..a4dd2c87 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2693,7 +2693,20 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.packet_timeout = options->tls_timeout;
     to.renegotiate_bytes = options->renegotiate_bytes;
     to.renegotiate_packets = options->renegotiate_packets;
-    to.renegotiate_seconds = options->renegotiate_seconds;
+    if (options->renegotiate_seconds_min < 0)
+    {
+        /* Add 10% jitter to reneg-sec by default (server side only) */
+        int auto_jitter = options->mode != MODE_SERVER ? 0 :
+                get_random() % max_int(options->renegotiate_seconds / 10, 1);
+        to.renegotiate_seconds = options->renegotiate_seconds - auto_jitter;
+    }
+    else
+    {
+        /* Add user-specified jitter to reneg-sec */
+        to.renegotiate_seconds = options->renegotiate_seconds -
+                (get_random() % max_int(options->renegotiate_seconds
+                                        - options->renegotiate_seconds_min, 1));
+    }
     to.single_session = options->single_session;
     to.mode = options->mode;
     to.pull = options->pull;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 49ed004b..0a5c6a64 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -603,7 +603,9 @@ static const char usage_message[] =
     "                  if no ACK from remote within n seconds (default=%d).\n"
     "--reneg-bytes n : Renegotiate data chan. key after n bytes sent and recvd.\n"
     "--reneg-pkts n  : Renegotiate data chan. key after n packets sent and recvd.\n"
-    "--reneg-sec n   : Renegotiate data chan. key after n seconds (default=%d).\n"
+    "--reneg-sec max [min] : Renegotiate data chan. key after at most max (default=%d)\n"
+    "                  and at least min (defaults to 90%% of max on servers and equal\n"
+    "                  to max on clients).\n"
     "--hand-window n : Data channel key exchange must finalize within n seconds\n"
     "                  of handshake initiation by any peer (default=%d).\n"
     "--tran-window n : Transition window -- old key can live this many seconds\n"
@@ -870,6 +872,7 @@ init_options(struct options *o, const bool init_gc)
     o->tls_timeout = 2;
     o->renegotiate_bytes = -1;
     o->renegotiate_seconds = 3600;
+    o->renegotiate_seconds_min = -1;
     o->handshake_window = 60;
     o->transition_window = 3600;
     o->ecdh_curve = NULL;
@@ -8001,10 +8004,14 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
         options->renegotiate_packets = positive_atoi(p[1]);
     }
-    else if (streq(p[0], "reneg-sec") && p[1] && !p[2])
+    else if (streq(p[0], "reneg-sec") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
         options->renegotiate_seconds = positive_atoi(p[1]);
+        if (p[2])
+        {
+            options->renegotiate_seconds_min = positive_atoi(p[2]);
+        }
     }
     else if (streq(p[0], "hand-window") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 496c1143..a74dc94d 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -548,6 +548,7 @@ struct options
     int renegotiate_bytes;
     int renegotiate_packets;
     int renegotiate_seconds;
+    int renegotiate_seconds_min;
 
     /* Data channel key handshake must finalize
      * within n seconds of handshake initiation. */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cb94229a..27f81cf3 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2732,9 +2732,9 @@ tls_process(struct tls_multi *multi,
                 && ks->n_packets >= session->opt->renegotiate_packets)
             || (packet_id_close_to_wrapping(&ks->crypto_options.packet_id.send))))
     {
-        msg(D_TLS_DEBUG_LOW,
-            "TLS: soft reset sec=%d bytes=" counter_format "/%d pkts=" counter_format "/%d",
-            (int)(ks->established + session->opt->renegotiate_seconds - now),
+        msg(D_TLS_DEBUG_LOW, "TLS: soft reset sec=%d/%d bytes=" counter_format
+            "/%d pkts=" counter_format "/%d",
+            (int) (now - ks->established), session->opt->renegotiate_seconds,
             ks->n_bytes, session->opt->renegotiate_bytes,
             ks->n_packets, session->opt->renegotiate_packets);
         key_state_soft_reset(session);
-- 
2.14.1


