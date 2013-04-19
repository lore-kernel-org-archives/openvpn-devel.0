From: Gert Doering <gert@...1296...>
Date: Fri, 19 Apr 2013 19:41:08 +0200
Message-Id: <1366393268-27392-6-git-send-email-gert@...1296...>
In-Reply-To: <1366393268-27392-1-git-send-email-gert@...1296...>
References: <1366393268-27392-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 5/5] Fix usage of "compression ..." from
	global config.
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

The new compression framework introduced by SVN r8206 only works for
a P2MP server if the compression settings are re-installed for each
client via management interface, ccd/ file or client-connect script,
but the "global" settings get lost due to (needlessly) clearing the
c2.comp_context in the per-client instance.  Fixed.  (also trac#273)

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 16501fd..b5bad65 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3643,10 +3643,6 @@ inherit_context_child (struct context *dest,
       dest->c2.link_socket_info->lsa = &dest->c1.link_socket_addr;
       dest->c2.link_socket_info->connection_established = false;
     }
-
-#ifdef USE_COMP
-  dest->c2.comp_context = NULL;
-#endif
 }
 
 void
-- 
1.8.1.5


