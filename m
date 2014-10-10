Sender: Fabian Knittel <fabian@...1547...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sat, 11 Oct 2014 00:09:21 +0200
Message-Id: <1412978966-15392-5-git-send-email-fabian.knittel@...1547...>
In-Reply-To: <1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
References: <5437B156.1020408@...1114...>
	<1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
Subject: [Openvpn-devel] [PATCH 4/9] client-connect: Move
	multi_client_connect_setenv into early_setup
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

This patch moves multi_client_connect_setenv into
multi_client_connect_early_setup and makes sure that every client-connect
handling function updates the virtual address selection.

Background: This unifies how the client-connect handling functions work.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/multi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 757e687..a34f985 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1635,15 +1635,6 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 
       multi_client_connect_source_ccd (m, mi, &option_types_found);
 
-      /*
-       * Select a virtual address from either --ifconfig-push in
-       * --client-config-dir file or --ifconfig-pool.
-       */
-      multi_select_virtual_addr (m, mi);
-
-      /* do --client-connect setenvs */
-      multi_client_connect_setenv (m, mi);
-
       multi_client_connect_call_plugin_v1 (m, mi, &option_types_found,
 					   &cc_succeeded, &cc_succeeded_count);
 
@@ -1700,6 +1691,10 @@ multi_client_connect_early_setup (struct multi_context *m,
 
   /* reset pool handle to null */
   mi->vaddr_handle = -1;
+
+  /* do --client-connect setenvs */
+  multi_select_virtual_addr (m, mi);
+  multi_client_connect_setenv (m, mi);
 }
 
 /*
@@ -1742,6 +1737,12 @@ multi_client_connect_source_ccd (struct multi_context *m,
 				 option_types_found,
 				 mi->context.c2.es);
 
+	  /*
+	   * Select a virtual address from either --ifconfig-push in
+	   * --client-config-dir file or --ifconfig-pool.
+	   */
+	  multi_select_virtual_addr (m, mi);
+	  multi_set_virtual_addr_env (m, mi);
 	}
 
       gc_free (&gc);
-- 
2.1.1


