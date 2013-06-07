From: David Sommerseth <dazo@...384...>
Date: Fri,  7 Jun 2013 12:15:30 +0200
Message-Id: <1370600130-6075-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 3/3] autoconf: Fix typo
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

In config.h, it would state:

      /* Enable systemd support */
      #define ENABLE_PLUGIN 1

instead of

      /* Enable plug-in support */
      #define ENABLE_PLUGIN 1

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index b1dd30e..5f67fad 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1012,7 +1012,7 @@ fi
 
 if test "${enable_plugins}" = "yes"; then
 	OPTIONAL_DL_LIBS="${DL_LIBS}"
-	AC_DEFINE([ENABLE_PLUGIN], [1], [Enable systemd support])
+	AC_DEFINE([ENABLE_PLUGIN], [1], [Enable plug-in support])
 else
 	enable_plugin_auth_pam="no"
 	enable_plugin_down_root="no"
-- 
1.7.10.2


