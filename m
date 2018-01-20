From: Steffan Karger <steffan@...1856...>
Date: Sat, 20 Jan 2018 17:41:14 +0100
Message-Id: <20180120164114.12478-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Enable extra compiler warnings by default
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

This by default enables the compiler warnings any could previously
enable using the --enable-strict configure option.  I think it is
okay to do so now, because we've taken care of many warnings in the
more standard builds.  (Most of those were totally harmless, but they
prevented us from spotting new more serious mistakes.)

Those who prefer a more silent build can use --disable-strict to revert
to the old default behaviour.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2c1937e5..2b5fa533 100644
--- a/configure.ac
+++ b/configure.ac
@@ -209,9 +209,9 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[strict],
-	[AS_HELP_STRING([--enable-strict], [enable strict compiler warnings (debugging option) @<:@default=no@:>@])],
+	[AS_HELP_STRING([--disable-strict], [enable strict compiler warnings (debugging option) @<:@default=yes@:>@])],
 	,
-	[enable_strict="no"]
+	[enable_strict="yes"]
 )
 
 AC_ARG_ENABLE(
-- 
2.14.1


