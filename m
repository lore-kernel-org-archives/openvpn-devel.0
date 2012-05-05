From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat,  5 May 2012 09:39:43 +0300
Message-Id: <1336199983-9916-2-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz2X_E=ODTGZ2mu-1Q1NkF4DaM=jLPoiKsDXmJ9KN3tZ6Q@...278...>
References: <CAOazyz2X_E=ODTGZ2mu-1Q1NkF4DaM=jLPoiKsDXmJ9KN3tZ6Q@...278...>
Subject: [Openvpn-devel] [PATCH 2/2] build: add --with-special-build to
	provide special build string
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

Special build string is printed when --version is specified.

This is handy when building a snapshot or if not git repository.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac          |    6 ++++++
 src/openvpn/options.c |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index d2851f6..926a270 100644
--- a/configure.ac
+++ b/configure.ac
@@ -229,6 +229,12 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_WITH(
+	[special-build],
+	[AS_HELP_STRING([--with-special-build=STRING], [specify special build string])],
+	[AC_DEFINE_UNQUOTED([CONFIGURE_SPECIAL_BUILD], ["${withval}"], [special build string])]
+)
+
+AC_ARG_WITH(
 	[mem-check],
 	[AS_HELP_STRING([--with-mem-check=TYPE], [build with debug memory checking, TYPE=no|dmalloc|valgrind|ssl @<:@default=no@:>@])],
 	[
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4ee2f31..9e77463 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3484,6 +3484,9 @@ usage_version (void)
 #ifdef CONFIGURE_DEFINES
   msg (M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
 #endif
+#ifdef CONFIGURE_SPECIAL_BUILD
+  msg (M_INFO|M_NOPREFIX, "special build: %s", CONFIGURE_SPECIAL_BUILD);
+#endif
 #ifdef CONFIGURE_GIT_REVISION
   msg (M_INFO|M_NOPREFIX, "git revision: %s", CONFIGURE_GIT_REVISION);
 #endif
-- 
1.7.3.4


