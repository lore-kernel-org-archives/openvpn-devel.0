From: Selva Nair <selva.nair@...277...>
Date: Wed,  4 Nov 2015 13:59:38 -0500
Message-Id: <1446663578-14471-1-git-send-email-selva.nair@...277...>
In-Reply-To: <20151104162034.GH24952@...1296...>
References: <20151104162034.GH24952@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix termination when windows suspends/sleeps
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

When TUN/TAP I/O operation is aborted, restart with a SIGHUP instead of
terminate. The abort error from TAP is often triggered by system suspend
which is fully recoverable on resume. Catastrophic events will get caught
later during the restart.  This solves the abnormal termination during
suspend/resume.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/forward.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 62eb6fc..cef063d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -958,8 +958,9 @@ read_incoming_tun (struct context *c)
   /* Was TUN/TAP I/O operation aborted? */
   if (tuntap_abort(c->c2.buf.len))
   {
-     register_signal(c, SIGTERM, "tun-abort");
-     msg(M_FATAL, "TUN/TAP I/O operation aborted, exiting");
+     register_signal(c, SIGHUP, "tun-abort");
+     c->persist.restart_sleep_seconds = 10;
+     msg(M_INFO, "TUN/TAP I/O operation aborted, restarting");
      perf_pop();
      return;
   }
-- 
2.6.2


