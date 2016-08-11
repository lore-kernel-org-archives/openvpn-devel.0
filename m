From: Gert Doering <gert@...1296...>
Date: Thu, 11 Aug 2016 21:23:40 +0200
Message-Id: <1470943420-15103-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Change timestamps to POSIX format.
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

All our timestams used to be "what ctime()" produces, which is

  "Thu Aug 11 21:15:27 2016"

Changed to use POSIX standard format, which is

  "2016-08-11 21:15:27"

this applies to logging (except to syslog or if --machine-readable-ouput
is used) and to various other places where informational timestamps are
produced.  Among these are the status files / status to management
interface, so applications parsing these time stamp need to be adjusted.

trac#719

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/otime.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 2c1e5b1..c10a6a8 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -112,6 +112,7 @@ time_string (time_t t, int usec, bool show_usec, struct gc_arena *gc)
 {
   struct buffer out = alloc_buf_gc (64, gc);
   struct timeval tv;
+  struct tm *tm;
 
   if (t)
     {
@@ -124,8 +125,10 @@ time_string (time_t t, int usec, bool show_usec, struct gc_arena *gc)
     }
 
   t = tv.tv_sec;
-  buf_printf (&out, "%s", ctime(&t));
-  buf_rmtail (&out, '\n');
+  tm = localtime(&t);
+  buf_printf (&out, "%04d-%02d-%02d %02d:%02d:%02d",
+		tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
+		tm->tm_hour, tm->tm_min, tm->tm_sec );
 
   if (show_usec && tv.tv_usec)
     buf_printf (&out, " us=%d", (int)tv.tv_usec);
-- 
2.7.3


