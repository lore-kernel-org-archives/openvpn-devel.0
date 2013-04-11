From: Arne Schwabe <arne@...1227...>
Date: Thu, 11 Apr 2013 13:17:14 +0200
Message-Id: <1365679034-1402-1-git-send-email-arne@...1227...>
In-Reply-To: <201304110933.r3B9XwPT011987@...1729...>
References: <201304110933.r3B9XwPT011987@...1729...>
Subject: [Openvpn-devel] [PATCH] Print client id only if compiled with man
	agent support. Otherwise print an empty string.
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

Also use %lu instead of %u for printing unsigned long int

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 1dbdb7f..a2a18c9 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -817,7 +817,7 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 
 	      if (!mi->halt)
 		{
-		  status_printf (so, "CLIENT_LIST%c%s%c%s%c%s%c" counter_format "%c" counter_format "%c%s%c%u%c%s%c%u",
+		  status_printf (so, "CLIENT_LIST%c%s%c%s%c%s%c" counter_format "%c" counter_format "%c%s%c%u%c%s%c%lu",
 				 sep, tls_common_name (mi->context.c2.tls_multi, false),
 				 sep, mroute_addr_print (&mi->real, &gc),
 				 sep, print_in_addr_t (mi->reporting_addr, IA_EMPTY_IF_UNDEF, &gc),
@@ -826,7 +826,11 @@ multi_print_status (struct multi_context *m, struct status_output *so, const int
 				 sep, time_string (mi->created, 0, false, &gc),
 				 sep, (unsigned int)mi->created,
 				 sep, tls_username (mi->context.c2.tls_multi, false),
-                 sep, mi->context.c2.mda_context.cid);
+#ifdef MANAGEMENT_DEF_AUTH
+				 sep, mi->context.c2.mda_context.cid);
+#else
+				 sep, "");
+#endif
 		}
 	      gc_free (&gc);
 	    }
-- 
1.7.9.5


