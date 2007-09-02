From: Maximilian Wilhelm <max@...1047...>
Date: Mon,  3 Sep 2007 01:13:56 +0200
Message-Id: <11887748431896-git-send-email-max@...1047...>
In-Reply-To: <11887748431930-git-send-email-max@...1047...>
References: <11887748431930-git-send-email-max@...1047...>
Subject: [Openvpn-devel] [PATCH] Let multi.c call wtmp_* routines when
	ENABLE_WTMP is defined.
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
 multi.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/multi.c b/multi.c
index fa924f1..2c23a44 100644
--- a/multi.c
+++ b/multi.c
@@ -42,6 +42,10 @@
 
 #include "forward-inline.h"
 
+#ifdef ENABLE_WTMP
+#include "wtmp.h"
+#endif
+
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@ -457,6 +461,10 @@ multi_close_instance (struct multi_context *m,
 
   dmsg (D_MULTI_DEBUG, "MULTI: multi_close_instance called");
 
+#ifdef ENABLE_WTMP
+  wtmp_stop (mi);
+#endif
+
   /* prevent dangling pointers */
   if (m->pending == mi)
     multi_set_pending (m, NULL);
@@ -1444,6 +1452,10 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	}
 #endif
 
+#ifdef ENABLE_WTMP
+      wtmp_start (mi);
+#endif
+
       /*
        * Run --client-connect script.
        */
@@ -2289,6 +2301,10 @@ tunnel_server (struct context *top)
 {
   ASSERT (top->options.mode == MODE_SERVER);
 
+#ifdef ENABLE_WTMP
+  wtmp_init();
+#endif
+
   switch (top->options.proto) {
   case PROTO_UDPv4:
     tunnel_server_udp (top);
-- 
1.5.2.4


