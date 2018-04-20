From: Antonio Quartulli <a@...2181...>
Date: Fri, 20 Apr 2018 19:16:22 +0800
Message-Id: <20180420111624.7230-7-a@...2181...>
In-Reply-To: <20180420111624.7230-1-a@...2181...>
References: <20180420111624.7230-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 6/8] configure: don't check for
 route/ifconfig on linux
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 626b4dd4..98be7243 100644
--- a/configure.ac
+++ b/configure.ac
@@ -298,6 +298,7 @@ case "$host" in
 	*-*-linux*)
 		AC_DEFINE([TARGET_LINUX], [1], [Are we running on Linux?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["L"], [Target prefix])
+		have_sitnl="yes"
 		;;
 	*-*-solaris*)
 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
@@ -1254,7 +1255,7 @@ if test "${enable_iproute2}" = "yes"; then
 	test -z "${IPROUTE}" && AC_MSG_ERROR([ip utility is required but missing])
 	AC_DEFINE([ENABLE_IPROUTE], [1], [enable iproute2 support])
 else
-	if test "${WIN32}" != "yes"; then
+	if test "${WIN32}" != "yes" -a "${have_sitnl}" != "yes"; then
 		test -z "${ROUTE}" && AC_MSG_ERROR([route utility is required but missing])
 		test -z "${IFCONFIG}" && AC_MSG_ERROR([ifconfig utility is required but missing])
 	fi
-- 
2.17.0


