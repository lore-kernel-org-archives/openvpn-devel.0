From: David Sommerseth <openvpn.list@...1114...>
Date: Mon,  8 Dec 2014 22:35:41 +0100
Message-Id: <1418074541-24987-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] plugin, down-root: Fix compiler warnings
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

From: David Sommerseth <davids@...1347...>

Removed a few compiler warnings:
  down-root.c:164:4: warning: implicit declaration of function 'warn' [-Wimplicit-function-declaration]
  down-root.c:239:5: warning: implicit declaration of function 'err' [-Wimplicit-function-declaration]
  down-root.c:461:7: warning: unused variable 'i' [-Wunused-variable]
  down-root.c:460:15: warning: unused variable 'p' [-Wunused-variable]

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/plugins/down-root/down-root.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index ed2636a..f7a49a0 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -42,6 +42,7 @@
 #include <signal.h>
 #include <syslog.h>
 #include <errno.h>
+#include <err.h>
 
 #include <openvpn-plugin.h>
 
@@ -457,9 +458,6 @@ openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
 static void
 down_root_server (const int fd, char * const *argv, char * const *envp, const int verb)
 {
-  const char *p[3];
-  int i;
-
   /*
    * Do initialization
    */
-- 
1.8.3.1


