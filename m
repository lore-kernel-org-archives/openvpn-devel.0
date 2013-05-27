From: Arne Schwabe <arne@...1227...>
Date: Mon, 27 May 2013 14:28:03 +0200
Message-Id: <1369657683-11489-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Add reporting of UI version to basic
	push-peer-info set.
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

If a GUIs sets IV_OPENVPN_GUI_VERSION the version will be pushed to the server.

Also fix implicit declaration of function 'multi_output_peer_info_env'  by including multi.h into ssl.c

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 12da365..75b81fc 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -67,6 +67,7 @@
 #include "ssl.h"
 #include "ssl_verify.h"
 #include "ssl_backend.h"
+#include "multi.h"
 
 #include "memdbg.h"
 
@@ -1817,15 +1818,17 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 	  get_default_gateway (&rgi);
 	  if (rgi.flags & RGI_HWADDR_DEFINED)
 	    buf_printf (&out, "IV_HWADDR=%s\n", format_hex_ex (rgi.hwaddr, 6, 0, 1, ":", &gc));
+        }
 
-	  /* push env vars that begin with UV_ */
-	  for (e=es->list; e != NULL; e=e->next)
+      /* push env vars that begin with UV_ and IV_OPENVPN_GUI_VERSION*/
+      for (e=es->list; e != NULL; e=e->next)
+	{
+	  if (e->string)
 	    {
-	      if (e->string)
-		{
-		  if (!strncmp(e->string, "UV_", 3) && buf_safe(&out, strlen(e->string)+1))
-		    buf_printf (&out, "%s\n", e->string);
-		}
+	      if (((strncmp(e->string, "UV_", 3)==0 && session->opt->push_peer_info_detail >= 2)
+		   || (strcmp(e->string,"IV_OPENVPN_GUI_VERSION")==0))
+		  && buf_safe(&out, strlen(e->string)+1))
+		buf_printf (&out, "%s\n", e->string);
 	    }
 	}
 
-- 
1.7.9.5


