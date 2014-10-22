From: samuli@...515...
Date: Wed, 22 Oct 2014 10:07:40 +0300
Message-Id: <1413961660-19251-3-git-send-email-samuli@...515...>
In-Reply-To: <1413961660-19251-1-git-send-email-samuli@...515...>
References: <1413961660-19251-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 2/2] Revised fix for code=995 sped bug.
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
Cc: TDivine <tdivine@...1939...>

From: TDivine <tdivine@...1939...>

---
 src/openvpn/forward.c |  9 +++++++++
 src/openvpn/tun.h     | 34 ++++++++++++++++++++--------------
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 39f66e3..27b775f 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -948,6 +948,15 @@ read_incoming_tun (struct context *c)
       return;		  
     }
 
+  /* Was TUN/TAP I/O operation aborted? */
+  if (tuntap_abort(c->c2.buf.len))
+  {
+     register_signal(c, SIGTERM, "tun-abort");
+     msg(M_FATAL, "TUN/TAP I/O operation aborted, exiting");
+     perf_pop();
+     return;
+  }
+
   /* Check the status return from read() */
   check_status (c->c2.buf.len, "read from TUN/TAP", NULL, c->c1.tuntap);
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index d84b777..7712568 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -378,28 +378,34 @@ int tun_write_queue (struct tuntap *tt, struct buffer *buf);
 int tun_finalize (HANDLE h, struct overlapped_io *io, struct buffer *buf);
 
 static inline bool
-tuntap_stop (int status)
+tuntap_stop(int status)
+{
+   /*
+   * This corresponds to the STATUS_NO_SUCH_DEVICE
+   * error in tapdrvr.c.
+   */
+   if (status < 0)
+   {
+      return openvpn_errno() == ERROR_FILE_NOT_FOUND;
+   }
+   return false;
+}
+
+static inline bool
+tuntap_abort(int status)
 {
    /*
-    * This corresponds to the STATUS_NO_SUCH_DEVICE
-    * error in tapdrvr.c.
-    */
+   * Typically generated when driver is halted.
+   */
    if (status < 0)
    {
-      status = openvpn_errno();
-      switch (status)
-      {
-      case ERROR_FILE_NOT_FOUND:
-      case ERROR_OPERATION_ABORTED:
-         return true;
-
-      default:
-         return false;
-      }
+      return openvpn_errno() == ERROR_OPERATION_ABORTED;
    }
    return false;
 }
 
+
+
 static inline int
 tun_write_win32 (struct tuntap *tt, struct buffer *buf)
 {
-- 
1.9.1


