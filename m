From: David Sommerseth <openvpn.list@...1114...>
Date: Sat, 17 Apr 2010 21:06:08 +0200
Message-Id: <1271531169-10293-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH 1/2] Removed no longer needed delete_file()
	call
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
To: Openvpn-devel@lists.sourceforge.net
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

Fabian Knittel noticed that this delete_file() calls should have been
removed in commit b963a17efc10512db442443234731a70b1f56f84

Signed-off-by: David Sommerseth <dazo@...384...>
---
 multi.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/multi.c b/multi.c
index 826a113..c4276f5 100644
--- a/multi.c
+++ b/multi.c
@@ -1538,7 +1538,6 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
           }
 
 	  argv_printf (&argv, "%s", dc_file);
-	  delete_file (dc_file);
 	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	    {
 	      msg (M_WARN, "WARNING: client-connect plugin call failed");
-- 
1.6.6.1


