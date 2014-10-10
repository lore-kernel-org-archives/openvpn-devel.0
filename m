Sender: Fabian Knittel <fabian@...1547...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sat, 11 Oct 2014 00:09:23 +0200
Message-Id: <1412978966-15392-7-git-send-email-fabian.knittel@...1547...>
In-Reply-To: <1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
References: <5437B156.1020408@...1114...>
	<1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
Subject: [Openvpn-devel] [PATCH 6/9] client-connect: Refactor client-connect
	handling to calling a bunch of hooks in a loop
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

This patch changes the calling of the client-connect functions into an array
of hooks and a block of code that calls them in a loop.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/multi.c | 57 +++++++++++++++--------------------------------------
 1 file changed, 16 insertions(+), 41 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4ead41e..7815146 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1627,6 +1627,18 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 {
   if (tls_authentication_status (mi->context.c2.tls_multi, 0) == TLS_AUTHENTICATION_SUCCEEDED)
     {
+      typedef enum client_connect_return_t (*multi_client_connect_handler)(struct multi_context *m, struct multi_instance *mi, unsigned int *option_types_found);
+
+      multi_client_connect_handler handlers[] = {
+	  multi_client_connect_source_ccd,
+	  multi_client_connect_call_plugin_v1,
+	  multi_client_connect_call_plugin_v2,
+	  multi_client_connect_call_script,
+	  multi_client_connect_mda,
+	  NULL
+      };
+
+      int cur_handler = 0;
       unsigned int option_types_found = 0;
       int cc_succeeded = true; /* client connect script status */
       int cc_succeeded_count = 0;
@@ -1634,51 +1646,14 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 
       multi_client_connect_early_setup (m, mi);
 
-      if (cc_succeeded)
+      while (succeeded && handlers[cur_handler])
 	{
-	  ret = multi_client_connect_source_ccd (m, mi, &option_types_found);
+	  ret = handlers[cur_handler] (m, mi, &option_types_found);
 	  if (ret == CC_RET_SUCCEEDED)
 	    ++cc_succeeded_count;
 	  else if (ret == CC_RET_FAILED)
-	    cc_succeeded = false;
-	}
-
-      if (cc_succeeded)
-	{
-	  ret = multi_client_connect_call_plugin_v1 (m, mi,
-						     &option_types_found);
-	  if (ret == CC_RET_SUCCEEDED)
-	    ++cc_succeeded_count;
-	  else if (ret == CC_RET_FAILED)
-	    cc_succeeded = false;
-	}
-
-      if (cc_succeeded)
-	{
-	  ret = multi_client_connect_call_plugin_v2 (m, mi,
-						     &option_types_found);
-	  if (ret == CC_RET_SUCCEEDED)
-	    ++cc_succeeded_count;
-	  else if (ret == CC_RET_FAILED)
-	    cc_succeeded = false;
-	}
-
-      if (cc_succeeded)
-	{
-	  ret = multi_client_connect_call_script (m, mi, &option_types_found);
-	  if (ret == CC_RET_SUCCEEDED)
-	    ++cc_succeeded_count;
-	  else if (ret == CC_RET_FAILED)
-	    cc_succeeded = false;
-	}
-
-      if (cc_succeeded)
-	{
-	  ret = multi_client_connect_mda (m, mi, &option_types_found);
-	  if (ret == CC_RET_SUCCEEDED)
-	    ++cc_succeeded_count;
-	  else if (ret == CC_RET_FAILED)
-	    cc_succeeded = false;
+	    succeeded = false;
+	  ++cur_handler;
 	}
 
       multi_client_connect_late_setup (m, mi, option_types_found, cc_succeeded,
-- 
2.1.1


