From: Arne Schwabe <arne@...1227...>
Date: Sun, 16 Oct 2022 17:49:53 +0200
Message-Id: <20221016154953.2483509-1-arne@...1227...>
In-Reply-To: <YydCIP5l0WwH5OX+@greenie.muc.de>
References: <YydCIP5l0WwH5OX+@greenie.muc.de>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Change exit signal in P2P to be a
 SIGUSR1 and delay CC exit in P2MP
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

From the implemention of explicit-notify and the fact that it is a an
OCC message (basically the rudimentary predecessor to control channel),
this message is very old.

I think in the past this feature fit nicely to the weird inetd + openvpn mode
that seems to have far to many hacks still left in our code. With inetd,
it made sense that the server instance quits if you press C-c on the client.

In our current state where inetd is no longer supported, this behaviour
to exit makes little sense and this patch changes the behaviour to SIGUSR1.

Testing this lead to a confused v2 of the patch and also finally the insight
that if a CC channel exit is triggered too early the remaining control channel
packets that come after that can trigger the HMAC code to open a sessions
again if the whole session lasted less than two minutes (with default
settings).

Patch v2: use different signals for p2mp and p2p
Patch v3: use dealyed exit for P2MP/CC exit and USR1 for everything else

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/occ.c  |  2 +-
 src/openvpn/push.c | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 1ed0d3771..eb1f2fae7 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -431,7 +431,7 @@ process_received_occ_msg(struct context *c)
 
         case OCC_EXIT:
             dmsg(D_PACKET_CONTENT, "RECEIVED OCC_EXIT");
-            c->sig->signal_received = SIGTERM;
+            c->sig->signal_received = SIGUSR1;
             c->sig->signal_text = "remote-exit";
             break;
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 26259c6b8..d9fa64870 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -193,7 +193,25 @@ void
 receive_exit_message(struct context *c)
 {
     dmsg(D_STREAM_ERRORS, "Exit message received by peer");
-    c->sig->signal_received = SIGTERM;
+    /* With control channel exit notification, we want the session to give
+     * enough time to handle retransmits and acknowledgment, so lat coming
+     * retries from the client to resend the exit or ACKs do not trigger
+     * a new session since we already killed it but the packet still has
+     * a valid HMAC. This can only happen for the period for the HMAC
+     * timeslot is still valid but waiting five seconds here does not
+     * hurt much and is the better alternative.
+     *
+     * This does not affect OCC exit since the HMAC session code will
+     * ignore DATA packets
+     * */
+    if (c->options.mode == MODE_SERVER)
+    {
+        schedule_exit(c, c->options.scheduled_exit_interval, SIGTERM);
+    }
+    else
+    {
+        c->sig->signal_received = SIGUSR1;
+    }
     c->sig->signal_text = "remote-exit";
 #ifdef ENABLE_MANAGEMENT
     if (management)
-- 
2.37.0 (Apple Git-136)


