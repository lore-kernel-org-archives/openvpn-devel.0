From: Arne Schwabe <arne@...1227...>
Date: Fri, 31 Aug 2012 16:19:13 +0200
Message-Id: <1346422753-19520-1-git-send-email-arne@...1227...>
In-Reply-To: <5040C27C.5010006@...1227...>
References: <5040C27C.5010006@...1227...>
Subject: [Openvpn-devel] [PATCH] Add the client id (CID) to the output of
	the status command
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

This add adds CID which is needed by a few other management commands to the status output. This will change the output of status in the same way commit ca18a638aa7cf316611f893127ba44131e57083c did.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9876b80..e5df432 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -807,8 +807,8 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 	   */
 	  status_printf (so, "TITLE%c%s", sep, title_string);
 	  status_printf (so, "TIME%c%s%c%u", sep, time_string (now, 0, false, &gc_top), sep, (unsigned int)now);
-	  status_printf (so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cUsername",
-			 sep, sep, sep, sep, sep, sep, sep, sep, sep);
+	  status_printf (so, "HEADER%cCLIENT_LIST%cCommon Name%cReal Address%cVirtual Address%cBytes Received%cBytes Sent%cConnected Since%cConnected Since (time_t)%cUsername%cClient ID",
+			 sep, sep, sep, sep, sep, sep, sep, sep, sep, sep);
 	  hash_iterator_init (m->hash, &hi);
 	  while ((he = hash_iterator_next (&hi)))
 	    {
@@ -817,7 +817,7 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 
 	      if (!mi->halt)
 		{
-		  status_printf (so, "CLIENT_LIST%c%s%c%s%c%s%c" counter_format "%c" counter_format "%c%s%c%u%c%s",
+		  status_printf (so, "CLIENT_LIST%c%s%c%s%c%s%c" counter_format "%c" counter_format "%c%s%c%u%c%s%c%u",
 				 sep, tls_common_name (mi->context.c2.tls_multi, false),
 				 sep, mroute_addr_print (&mi->real, &gc),
 				 sep, print_in_addr_t (mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc),
@@ -825,7 +825,8 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 				 sep, mi->context.c2.link_write_bytes,
 				 sep, time_string (mi->created, 0, false, &gc),
 				 sep, (unsigned int)mi->created,
-				 sep, tls_username (mi->context.c2.tls_multi, false));
+				 sep, tls_username (mi->context.c2.tls_multi, false),
+                 sep, mi->context.c2.mda_context.cid);
 		}
 	      gc_free (&gc);
 	    }
-- 
1.7.9.6 (Apple Git-31.1)


