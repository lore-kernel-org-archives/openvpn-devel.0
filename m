From: Arne Schwabe <arne@...1227...>
Date: Tue, 11 Oct 2022 13:49:35 +0200
Message-Id: <20221011114935.1802202-1-arne@...1227...>
In-Reply-To: <YydCIP5l0WwH5OX+@greenie.muc.de>
References: <YydCIP5l0WwH5OX+@greenie.muc.de>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Change exit notification in P2P to be a
 SIGUSR1 instead of a SIGTERM signal
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

From the implemention and the fact that it is a an OCC message
(basically the rudimentary predecessor to control channel),
this message is very old.

I think in the past this feature fit nicely to the weird inetd + openvpn mode
that seems to have far to many hacks still left in our code. With inetd,
it made sense that the server instance quits if you press C-c on the client.

In our current state where inetd is no longer supported, this behaviour
to exit makes little sense and this patch changes the behaviour to SIGUSR1.

The P2MP mode nees to keep the SIGTERM behaviour to terminate that client
session, so we use different signals based on the mode.

Patch v2: use different signals for p2mp and p2p

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/occ.c  | 12 ++++++++++--
 src/openvpn/push.c | 11 ++++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 1ed0d3771..75703fc70 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -431,8 +431,16 @@ process_received_occ_msg(struct context *c)
 
         case OCC_EXIT:
             dmsg(D_PACKET_CONTENT, "RECEIVED OCC_EXIT");
-            c->sig->signal_received = SIGTERM;
-            c->sig->signal_text = "remote-exit";
+            /* in server mode we want the instance to be terminated. But for a
+             * standalone p2p, SIGTERM would terminate the program */
+            if (c->options.mode == MODE_SERVER)
+            {
+                c->sig->signal_received = SIGTERM;
+            }
+            else
+            {
+                c->sig->signal_received = SIGUSR1;
+            }            c->sig->signal_text = "remote-exit";
             break;
     }
     c->c2.buf.len = 0; /* don't pass packet on */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 26259c6b8..ec909c630 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -193,7 +193,16 @@ void
 receive_exit_message(struct context *c)
 {
     dmsg(D_STREAM_ERRORS, "Exit message received by peer");
-    c->sig->signal_received = SIGTERM;
+    /* in server mode we want the instance to be terminated. But for a
+     * standalone p2p, SIGTERM would terminate the program */
+    if (c->options.mode == MODE_SERVER)
+    {
+        c->sig->signal_received = SIGTERM;
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


