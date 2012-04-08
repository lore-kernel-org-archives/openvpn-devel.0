From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sun,  8 Apr 2012 13:04:45 +0300
Message-Id: <1333879485-2417-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz0nDj78COr6sd4FAMPz3sML0+-5ZNOx7s_62qtk12tnag@...278...>
References: <CAOazyz0nDj78COr6sd4FAMPz3sML0+-5ZNOx7s_62qtk12tnag@...278...>
Subject: [Openvpn-devel] [PATCH] crash: packet_id_debug_print: sl may be null
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Program received signal SIGSEGV, Segmentation fault.
packet_id_debug_print (msglevel=1174405255, p=0xa36bd0718,
pin=0x3de5feec1b0,
message=0xa330dde80 "PID_TEST", value=0) at
../../../src/openvpn/packet_id.c:504
504       for (i = 0; i < sl->x_size; ++i)

(gdb) print sl
$2 = (const struct seq_list *) 0x0

Reported in the past[1].

[1] http://thread.gmane.org/gmane.network.openvpn.devel/5466

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/packet_id.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 0102129..baa4966 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -501,7 +501,7 @@ packet_id_debug_print (int msglevel,
 
   buf_printf (&out, "%s [%d]", message, value);
   buf_printf (&out, " [%s-%d] [", p->name, p->unit);
-  for (i = 0; i < sl->x_size; ++i)
+  for (i = 0; sl != NULL && i < sl->x_size; ++i)
     {
       char c;
       time_t v;
@@ -538,11 +538,15 @@ packet_id_debug_print (int msglevel,
 	      p->time_backtrack,
 	      p->max_backtrack_stat,
 	      (int)p->initialized);
-  buf_printf (&out, " sl=[%d,%d,%d,%d]",
-	      sl->x_head,
-	      sl->x_size,
-	      sl->x_cap,
-	      sl->x_sizeof);
+  if (sl != NULL)
+    {
+	  buf_printf (&out, " sl=[%d,%d,%d,%d]",
+		      sl->x_head,
+		      sl->x_size,
+		      sl->x_cap,
+		      sl->x_sizeof);
+    }
+
 
   msg (msglevel, "%s", BSTR(&out));
   gc_free (&gc);
-- 
1.7.3.4


