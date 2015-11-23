From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 23 Nov 2015 13:38:13 +0200
Message-Id: <1448278693-29322-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Client-side part for server restart
	notification
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

When client receives "RESTART,N", it advances to the next remote.

Whole patch (server + client) has been merged to master and will be part of 2.4.

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/push.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 11505cb..e4f3984 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -103,6 +103,7 @@ server_pushed_signal (struct context *c, const struct buffer *buffer, const bool
 	m = BSTR (&buf);
 
       /* preserve cached passwords? */
+      /* advance to next server? */
       {
 	bool purge = true;
 
@@ -113,6 +114,12 @@ server_pushed_signal (struct context *c, const struct buffer *buffer, const bool
 	      {
 		if (m[i] == 'P')
 		  purge = false;
+		else if (m[i] == 'N')
+		  {
+		    /* next server? */
+		    if (c->options.connection_list)
+		      c->options.connection_list->no_advance = false;
+		  }
 	      }
 	  }
 	if (purge)
-- 
1.9.1


