From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 26 Jun 2012 16:02:06 +0300
Message-Id: <1340715726-14670-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] build: plugins: set default to no in Windows
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Both plugins cannot be compiled on Windows anyway.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index db19d4a..7235a87 100644
--- a/configure.ac
+++ b/configure.ac
@@ -195,16 +195,26 @@ AC_ARG_ENABLE(
 
 AC_ARG_ENABLE(
 	[plugin-auth-pam],
-	[AS_HELP_STRING([--disable-plugin-auth-pam], [disable auth-pam plugin @<:@default=yes@:>@])],
+	[AS_HELP_STRING([--disable-plugin-auth-pam], [disable auth-pam plugin @<:@default=yes for POSIX@:>@])],
 	,
-	[enable_plugin_auth_pam="yes"]
+	[
+		case "$host" in
+			*-mingw*) enable_plugin_auth_pam="no";;
+			*) enable_plugin_auth_pam="yes";;
+		esac
+	]
 )
 
 AC_ARG_ENABLE(
 	[plugin-down-root],
-	[AS_HELP_STRING([--disable-plugin-down-root], [disable down-root plugin @<:@default=yes@:>@])],
+	[AS_HELP_STRING([--disable-plugin-down-root], [disable down-root plugin @<:@default=yes for POSIX@:>@])],
 	,
-	[enable_plugin_down_root="yes"]
+	[
+		case "$host" in
+			*-mingw*) enable_plugin_down_root="no";;
+			*) enable_plugin_down_root="yes";;
+		esac
+	]
 )
 
 AC_ARG_ENABLE(
-- 
1.7.3.4


