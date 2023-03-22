From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 22 Mar 2023 13:32:49 +0200
Message-Id: <20230322113249.2039-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Print DCO client stats on SIGUSR2
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

Change-Id: I465febdf7ee5fe573e88255844f718efb60f8e8a
Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/sig.c | 13 +++++++++----
 src/openvpn/sig.h |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 5b89bb42..05c0054b 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -300,18 +300,23 @@ restore_signal_state(void)
  * Triggered by SIGUSR2 or F2 on Windows.
  */
 void
-print_status(const struct context *c, struct status_output *so)
+print_status(struct context *c, struct status_output *so)
 {
     struct gc_arena gc = gc_new();
 
     status_reset(so);
 
+    if (dco_enabled(&c->options))
+    {
+        dco_get_peer_stats(c);
+    }
+
     status_printf(so, "OpenVPN STATISTICS");
     status_printf(so, "Updated,%s", time_string(0, 0, false, &gc));
     status_printf(so, "TUN/TAP read bytes," counter_format, c->c2.tun_read_bytes);
     status_printf(so, "TUN/TAP write bytes," counter_format, c->c2.tun_write_bytes);
-    status_printf(so, "TCP/UDP read bytes," counter_format, c->c2.link_read_bytes);
-    status_printf(so, "TCP/UDP write bytes," counter_format, c->c2.link_write_bytes);
+    status_printf(so, "TCP/UDP read bytes," counter_format, c->c2.link_read_bytes + c->c2.dco_read_bytes);
+    status_printf(so, "TCP/UDP write bytes," counter_format, c->c2.link_write_bytes + c->c2.dco_write_bytes);
     status_printf(so, "Auth read bytes," counter_format, c->c2.link_read_bytes_auth);
 #ifdef USE_COMP
     if (c->c2.comp_context)
@@ -402,7 +407,7 @@ remap_signal(struct context *c)
 }
 
 static void
-process_sigusr2(const struct context *c)
+process_sigusr2(struct context *c)
 {
     struct status_output *so = status_open(NULL, 0, M_INFO, NULL, 0);
     print_status(c, so);
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 4858eb93..b09dfab6 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -69,7 +69,7 @@ void restore_signal_state(void);
 
 void print_signal(const struct signal_info *si, const char *title, int msglevel);
 
-void print_status(const struct context *c, struct status_output *so);
+void print_status(struct context *c, struct status_output *so);
 
 void remap_signal(struct context *c);
 
-- 
2.38.1.windows.1


