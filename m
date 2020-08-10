From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:36:57 +0200
Message-Id: <20200810143707.5834-8-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 07/17] Split pf_check_reload check and check
 timer in process_coarse_timers
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

This move the timer check into process_coarse_timers and makes in line
with the other functions. The the pf.enabled check is also moved
process_coarse_timers to make it more clear this only is used if
pf is enabled at all.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 6 +++++-
 src/openvpn/pf.c      | 4 +---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 7ac878f9..27a40b0c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -679,7 +679,11 @@ process_coarse_timers(struct context *c)
 #endif
 
 #ifdef PLUGIN_PF
-    pf_check_reload(c);
+    if (c->c2.pf.enabled
+        && event_timeout_trigger(&c->c2.pf.reload, &c->c2.timeval, ETT_DEFAULT))
+    {
+        pf_check_reload(c);
+    }
 #endif
 
     /* process --route options */
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index b8da26e4..f9bbfb50 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -547,9 +547,7 @@ pf_check_reload(struct context *c)
     const int wakeup_transition = 60;
     bool reloaded = false;
 
-    if (c->c2.pf.enabled
-        && c->c2.pf.filename
-        && event_timeout_trigger(&c->c2.pf.reload, &c->c2.timeval, ETT_DEFAULT))
+    if (c->c2.pf.filename)
     {
         platform_stat_t s;
         if (!platform_stat(c->c2.pf.filename, &s))
-- 
2.26.2


