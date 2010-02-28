From: David Sommerseth <openvpn.list@...1114...>
Date: Sun, 28 Feb 2010 13:50:35 +0100
Message-Id: <1267361435-11982-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] Add CID to the management status overview
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
Cc: David Sommerseth <dazo@...384...>

From: Arne Schwabe <arne@...1227...>

There are commands in the management interface which require the cid. The
only way at the moment to get the cid of connected clients is to have
always a management connection established. The patch adds the CID to the
status output.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 multi.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/multi.c b/multi.c
index 342871a..f8adb46 100644
--- a/multi.c
+++ b/multi.c
@@ -777,7 +777,7 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 
 	  status_printf (so, "END");
 	}
-      else if (version == 2 || version == 3)
+      else if (version == 2 || version == 3 )
 	{
 	  const char sep = (version == 3) ? '\t' : ',';
 
@@ -786,8 +786,8 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 	   */
 	  status_printf (so, "TITLE%c%s", sep, title_string);
 	  status_printf (so, "TIME%c%s%c%u", sep, time_string (now, 0, false, &gc_top), sep, (unsigned int)now);
-	  status_printf (so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)",
-			 sep, sep, sep, sep, sep, sep, sep, sep);
+	  status_printf (so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cCID",
+			 sep, sep, sep, sep, sep, sep, sep, sep, sep);
 	  hash_iterator_init (m->hash, &hi, true);
 	  while ((he = hash_iterator_next (&hi)))
 	    {
@@ -796,14 +796,15 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 
 	      if (!mi->halt)
 		{
-		  status_printf (so, "CLIENT_LIST%c%s%c%s%c%s%c" counter_format "%c" counter_format "%c%s%c%u",
+		  status_printf (so, "CLIENT_LIST%c%s%c%s%c%s%c" counter_format "%c" counter_format "%c%s%c%u%c%u",
 				 sep, tls_common_name (mi->context.c2.tls_multi, false),
 				 sep, mroute_addr_print (&mi->real, &gc),
 				 sep, print_in_addr_t (mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc),
 				 sep, mi->context.c2.link_read_bytes,
 				 sep, mi->context.c2.link_write_bytes,
 				 sep, time_string (mi->created, 0, false, &gc),
-				 sep, (unsigned int)mi->created);
+				 sep, (unsigned int)mi->created,
+				 sep, mi->context.c2.mda_context.cid);
 		}
 	      gc_free (&gc);
 	    }
-- 
1.6.6.1


