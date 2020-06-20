From: Gert Doering <gert@...1296...>
Date: Sat, 20 Jun 2020 19:23:03 +0200
Message-Id: <20200620172303.15010-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Change timestamps in file-based logging to
 ISO 8601 time format.
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

Replace existing ctime() output which is hard to sort and compare
with ISO 8601 / RFC 3399 "YYYY-MM-DD hh:mm:dd" format for file-based
logging (stderr or --log file).

RFC 3399 5.6 permits use of a space for full-date-full-time separation,
which is used to enhance readability.

Sylog or --machine-readable-timestamps are not affected.

Trac: #719

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/otime.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 759a7fb5..28683459 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -127,8 +127,11 @@ time_string(time_t t, int usec, bool show_usec, struct gc_arena *gc)
     }
 
     t = tv.tv_sec;
-    buf_printf(&out, "%s", ctime(&t));
-    buf_rmtail(&out, '\n');
+    struct tm * tm = localtime(&t);
+
+    buf_printf(&out, "%04d-%02d-%02d %02d:%02d:%02d",
+                tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
+                tm->tm_hour, tm->tm_min, tm->tm_sec);
 
     if (show_usec && tv.tv_usec)
     {
-- 
2.26.2


