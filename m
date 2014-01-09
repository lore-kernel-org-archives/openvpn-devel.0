From: Gert Doering <gert@...1296...>
Date: Thu,  9 Jan 2014 20:48:11 +0100
Message-Id: <1389296891-1487-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Reduce IV_OPENVPN_GUI_VERSION= to
	IV_GUI_VER=
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

Use shorter variable name to signal the same thing (see f3a2cd255a3bc73)
to save space in the buffer used the collective IV_ info sent to server.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/ssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 93222c4..15518ca 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1825,13 +1825,13 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 	    buf_printf (&out, "IV_HWADDR=%s\n", format_hex_ex (rgi.hwaddr, 6, 0, 1, ":", &gc));
         }
 
-      /* push env vars that begin with UV_ and IV_OPENVPN_GUI_VERSION */
+      /* push env vars that begin with UV_ and IV_GUI_VER */
       for (e=es->list; e != NULL; e=e->next)
 	{
 	  if (e->string)
 	    {
 	      if (((strncmp(e->string, "UV_", 3)==0 && session->opt->push_peer_info_detail >= 2)
-		   || (strncmp(e->string,"IV_OPENVPN_GUI_VERSION=",sizeof("IV_OPENVPN_GUI_VERSION=")-1)==0))
+		   || (strncmp(e->string,"IV_GUI_VER=",sizeof("IV_GUI_VER=")-1)==0))
 		  && buf_safe(&out, strlen(e->string)+1))
 		buf_printf (&out, "%s\n", e->string);
 	    }
-- 
1.8.3.2


