From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 15 Mar 2023 15:38:08 +0200
Message-Id: <20230315133808.1550-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Support --inactive option for DCO
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

When DCO is in use, userland doesn't see any traffic
which breaks --inactive option.

Fix by adding inactivity check to inactivity timeout
callback. Get the cumulative tun bytes count (ping packets
are excluded) from DCO and compare it to the previous value
stored in c2.inactivity_bytes. Reset inactivity timer and
update c2.inactivity_bytes if amount of new bytes exceeds
inactivity_minimum_bytes, otherwise terminate session
due to inactivity.

Fixes https://github.com/OpenVPN/openvpn/issues/228

Currently works only on Windows, since we don't yet have
single peer stats implementation for Linux and FreeBSD.

Change-Id: Ib417b965bc4a2c17b51935b43c9627b106716526
Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/dco_win.c |  2 ++
 src/openvpn/forward.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 0931fb30..aae6b4b5 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -431,6 +431,8 @@ dco_get_peer_stats(struct context *c)
 
     c->c2.dco_read_bytes = stats.TransportBytesReceived;
     c->c2.dco_write_bytes = stats.TransportBytesSent;
+    c->c2.tun_read_bytes = stats.TunBytesReceived;
+    c->c2.tun_write_bytes = stats.TunBytesSent;
 
     return 0;
 }
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 257c7c75..923c04f2 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -464,6 +464,20 @@ check_add_routes(struct context *c)
 static void
 check_inactivity_timeout(struct context *c)
 {
+    if (dco_enabled(&c->options) && dco_get_peer_stats(c) == 0)
+    {
+        int64_t tot_bytes = c->c2.tun_read_bytes + c->c2.tun_write_bytes;
+        int64_t new_bytes = tot_bytes - c->c2.inactivity_bytes;
+
+        if (new_bytes >= c->options.inactivity_minimum_bytes)
+        {
+            c->c2.inactivity_bytes = tot_bytes;
+            event_timeout_reset(&c->c2.inactivity_interval);
+
+            return;
+        }
+    }
+
     msg(M_INFO, "Inactivity timeout (--inactive), exiting");
     register_signal(c->sig, SIGTERM, "inactive");
 }
-- 
2.38.1.windows.1


