From: Selva Nair <selva.nair@...277...>
Date: Fri,  1 Jul 2016 23:32:48 -0400
Message-Id: <1467430368-25437-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Exponentially backoff on repeated connect
	retries
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

- When the number of retries per remote exceeds a limit
  (hard coded to 5), double the restart pause interval
  for each additional retry per remote.
- Trigger a SIGHUP to reset the retry count when the pause
  interval exceeds 1024 times the base value of restart pause.

The base value of restart pause is set using --connect-retry
(5 seconds by default). If it is set to zero no slow-down
will happen.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/init.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 498d36f..45e8878 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1955,6 +1955,7 @@ static void
 socket_restart_pause (struct context *c)
 {
   int sec = 2;
+  int backoff = 0;
 
   switch (c->options.ce.proto)
     {
@@ -1977,6 +1978,17 @@ socket_restart_pause (struct context *c)
     sec = 10;
 #endif
 
+  /* Slow down reconnection after 5 retries per remote */
+  backoff = (c->options.unsuccessful_attempts / c->options.connection_list->len) - 5;
+  if (backoff > 0)
+    sec <<= min_int (backoff, 10);
+
+  if (backoff > 10 && sec > 0)
+    {
+      register_signal (c, SIGHUP, "Too many restarts");
+      return;
+    }
+
   if (c->persist.restart_sleep_seconds > 0 && c->persist.restart_sleep_seconds > sec)
     sec = c->persist.restart_sleep_seconds;
   else if (c->persist.restart_sleep_seconds == -1)
-- 
1.7.10.4


