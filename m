From: Thomas Veerman <thomas.veerman@...1862...>
Date: Fri,  7 Jul 2017 21:59:41 +0200
Message-Id: <20170707195941.61773-1-thomas.veerman@...1862...>
Subject: [Openvpn-devel] [PATCH] Fix socks_proxy_port pointing to invalid
 data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

When setting the SOCKS proxy through the management interface, the
socks_proxy_port pointer would be set to a value that's no longer valid
by the time it's used by do_preresolve_host.

Signed-off-by: Thomas Veerman <thomas.veerman@...1862...>
---
 src/openvpn/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a54307ad..80a8f5fa 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -150,7 +150,7 @@ management_callback_proxy_cmd(void *arg, const char **p)
         else if (streq(p[1], "SOCKS"))
         {
             ce->socks_proxy_server = string_alloc(p[2], gc);
-            ce->socks_proxy_port = p[3];
+            ce->socks_proxy_port = string_alloc(p[3], gc);
             ret = true;
         }
     }
-- 
2.11.0 (Apple Git-81)


