From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 11 Jul 2012 15:38:49 +0200
Message-ID: <1342013929-10940-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] remove unused show_connection_list debug
	function
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

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/init.c |   25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f86fc38..81800d3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -316,30 +316,6 @@ init_connection_list (struct context *c)
     }
 }
 
-#if 0 /* fixme -- disable for production */
-static void
-show_connection_list (const struct connection_list *l)
-{
-  int i;
-  dmsg (M_INFO, "CONNECTION_LIST len=%d current=%d",
-	l->len, l->current);
-  for (i = 0; i < l->len; ++i)
-    {
-      dmsg (M_INFO, "[%d] %s:%d proto=%s http_proxy=%d",
-	    i,
-	    l->array[i]->remote,
-	    l->array[i]->remote_port,
-	    proto2ascii(l->array[i]->proto, true),
-	    BOOL_CAST(l->array[i]->http_proxy_options));
-    }
-}
-#else
-static inline void
-show_connection_list (const struct connection_list *l)
-{
-}
-#endif
-
 /*
  * Increment to next connection entry
  */
@@ -374,7 +350,6 @@ next_connection_entry (struct context *c)
 
 	    if (l->current == 0)
 	      newcycle = true;
-	    show_connection_list(l);
 	  }
 
 	ce = l->array[l->current];
-- 
1.7.9.5


