From: Antonio Quartulli <a@...2181...>
Date: Tue, 21 Mar 2023 11:28:42 +0100
Message-Id: <20230321102842.10780-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] multi: don't call DCO APIs if DCO is
 disabled
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
Cc: Antonio Quartulli <a@...2181...>, Lev Stipakov <lev@...515...>

The agreement with the DCO submodule is that no API should be called if
DCO is actually disabled. For this reason, every invocation must happen
only after having checked that dco_enabled() returns true.

Add missing checks before invoking dco_get_peer_stats_multi()

Reported-by: Lev Stipakov <lev@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/multi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 53c17b3a..1f0a9c01 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -549,7 +549,10 @@ multi_del_iroutes(struct multi_context *m,
 static void
 setenv_stats(struct multi_context *m, struct context *c)
 {
-    dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m);
+    if (dco_enabled(&m->top.options))
+    {
+        dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m);
+    }
 
     setenv_counter(c->c2.es, "bytes_received", c->c2.link_read_bytes + c->c2.dco_read_bytes);
     setenv_counter(c->c2.es, "bytes_sent", c->c2.link_write_bytes + c->c2.dco_write_bytes);
@@ -849,7 +852,10 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
 
         status_reset(so);
 
-        dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m);
+        if (dco_enabled(&m->top.options))
+        {
+            dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m);
+        }
 
         if (version == 1)
         {
-- 
2.39.2


