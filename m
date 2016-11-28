From: Christian Hesse <list@...1798...>
Date: Mon, 28 Nov 2016 17:16:23 +0100
Message-Id: <20161128161625.11972-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH 1/2] show correct default for plugin dir in
	configure help
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
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

Signed-off-by: Christian Hesse <mail@...1798...>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index f4073d0..d0fe889 100644
--- a/configure.ac
+++ b/configure.ac
@@ -303,7 +303,7 @@ AC_ARG_WITH(
 
 AC_ARG_WITH(
 	[plugindir],
-	[AS_HELP_STRING([--with-plugindir], [plugin directory @<:@default=LIBDIR/openvpn@:>@])],
+	[AS_HELP_STRING([--with-plugindir], [plugin directory @<:@default=LIBDIR/openvpn/plugins@:>@])],
 	,
 	[with_plugindir="\$(libdir)/openvpn/plugins"]
 )
-- 
2.10.2


