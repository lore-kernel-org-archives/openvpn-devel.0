From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:48 +0300
Message-Id: <1336850389-23719-16-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 15/16] cleanup: syshead: move
	ENABLE_MEMSTATS to autoconf
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac          |    1 +
 src/openvpn/syshead.h |    7 -------
 2 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 193d287..cca9508 100644
--- a/configure.ac
+++ b/configure.ac
@@ -270,6 +270,7 @@ case "$host" in
 	*-*-linux*)
 		AC_DEFINE([TARGET_LINUX], [1], [Are we running on Linux?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["L"], [Target prefix])
+		AC_DEFINE([ENABLE_MEMSTATS], [1], [Enable --memstats option])
 		;;
 	*-*-solaris*)
 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index c4dfd0b..d5a9af1 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -613,11 +613,4 @@
  */
 #define ENABLE_CLIENT_NAT
 
-/*
- * Enable --memstats option
- */
-#ifdef TARGET_LINUX
-#define ENABLE_MEMSTATS
-#endif
-
 #endif
-- 
1.7.3.4


