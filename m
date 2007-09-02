From: Maximilian Wilhelm <max@...1047...>
Date: Mon,  3 Sep 2007 01:13:58 +0200
Message-Id: <11887748432250-git-send-email-max@...1047...>
In-Reply-To: <11887748431930-git-send-email-max@...1047...>
References: <11887748431930-git-send-email-max@...1047...>
Subject: [Openvpn-devel] [PATCH] Let OpenVPN write wtmp entries if
	configured so.
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

Signed-off-by: Maximilian Wilhelm <max@...1047...>
---
 multi.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/multi.c b/multi.c
index 2c23a44..5d8c80e 100644
--- a/multi.c
+++ b/multi.c
@@ -462,7 +462,9 @@ multi_close_instance (struct multi_context *m,
   dmsg (D_MULTI_DEBUG, "MULTI: multi_close_instance called");
 
 #ifdef ENABLE_WTMP
-  wtmp_stop (mi);
+  if (m->top.options.log_wtmp == 1)
+    wtmp_stop (mi);
+
 #endif
 
   /* prevent dangling pointers */
@@ -1453,7 +1455,8 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 #endif
 
 #ifdef ENABLE_WTMP
-      wtmp_start (mi);
+      if (m->top.options.log_wtmp == 1)
+        wtmp_start (mi);
 #endif
 
       /*
@@ -2302,7 +2305,8 @@ tunnel_server (struct context *top)
   ASSERT (top->options.mode == MODE_SERVER);
 
 #ifdef ENABLE_WTMP
-  wtmp_init();
+  if (top->options.log_wtmp == 1)
+    wtmp_init(top->options.wtmp_server_id, top->options.wtmp_file);
 #endif
 
   switch (top->options.proto) {
-- 
1.5.2.4


