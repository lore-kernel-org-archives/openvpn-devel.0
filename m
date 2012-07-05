From: Arne Schwabe <arne@...1227...>
Date: Thu,  5 Jul 2012 11:17:15 +0200
Message-Id: <1341479835-12963-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix compiling with --disable-management
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

Some of the  MANAGEMENT_QUERY_REMOTE were actually needed. Put #ifdef ENABLE_MANAGMENT in their place

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f67745f..f86fc38 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -206,6 +206,7 @@ management_callback_http_proxy_fallback_cmd (void *arg, const char *server, cons
 
 #endif
 
+#ifdef ENABLE_MANAGEMENT
 static bool
 management_callback_remote_cmd (void *arg, const char **p)
 {
@@ -285,6 +286,7 @@ ce_management_query_remote (struct context *c, const char *remote_ip_hint)
   gc_free (&gc);
   return ret;
 }
+#endif /* ENABLE_MANAGEMENT */
 
 /*
  * Initialize and possibly randomize connection list.
@@ -396,7 +398,7 @@ next_connection_entry (struct context *c)
 	  ce_defined = false;
 
 	c->options.ce = *ce;
-
+#ifdef ENABLE_MANAGEMENT
 	if (ce_defined && management && management_query_remote_enabled(management))
 	  {
 	    /* allow management interface to override connection entry details */
@@ -404,6 +406,7 @@ next_connection_entry (struct context *c)
 	    if (IS_SIG (c))
 	      break;
 	  } else
+#endif
 	if (remote_ip_hint)
 	  c->options.ce.remote = remote_ip_hint;
 
@@ -3168,7 +3171,9 @@ init_management_callback_p2p (struct context *c)
 #if HTTP_PROXY_FALLBACK
       cb.http_proxy_fallback_cmd = management_callback_http_proxy_fallback_cmd;
 #endif
+#ifdef ENABLE_MANAGEMENT
       cb.remote_cmd = management_callback_remote_cmd;
+#endif
       management_set_callback (management, &cb);
     }
 #endif
-- 
1.7.7.5 (Apple Git-26)


