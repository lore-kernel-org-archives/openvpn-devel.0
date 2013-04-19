From: David Sommerseth <dazo@...384...>
Date: Fri, 19 Apr 2013 14:40:12 +0200
Message-Id: <1366375212-14886-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] Improve the git revision tracking
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

This removes the single 'git revision' line from the --version screen and
moves this information on the top, together with the OpenVPN version.

In addition this patch adds two git flags after the git committish.  If
there exists changed but unstaged files when the build was done, a '+' is
appended after the committish.  If there exists staged files (files which
have been added with 'git add') a '*' will be appended.  These flags are
not exclusive.

This also simplifies the config-version.h generation by not using
sed parsing a template.  It's just two lines which are generated, so
no need to complicate things more than needed.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 Makefile.am           |    9 ++++++---
 config-version.h.in   |    1 -
 src/openvpn/options.c |    6 +++---
 version.m4            |    2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index c580579..1a30aa5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -66,7 +66,6 @@ dist_doc_DATA = \
 dist_noinst_DATA = \
 	.gitignore \
 	.gitattributes \
-	config-version.h.in \
 	PORTS \
 	README.IPv6 TODO.IPv6 \
 	README.polarssl \
@@ -91,8 +90,12 @@ root_DATA = version.sh
 endif
 
 config-version.h:
-	@CONFIGURE_GIT_REVISION="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) rev-parse --symbolic-full-name HEAD`/`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) rev-parse --short=16 HEAD`"; \
-		$(SED) "s#@CONFIGURE_GIT_REVISION[@]#$${CONFIGURE_GIT_REVISION}#g" "$(srcdir)/config-version.h.in" > config-version.h.tmp
+	@CONFIGURE_GIT_CHFILES="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) diff-files --name-status -r --ignore-submodules --quiet -- || echo \"+\"`"; \
+	CONFIGURE_GIT_UNCOMMITTED="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) diff-index --cached  --quiet --ignore-submodules HEAD || echo \"*\"`"; \
+	CONFIGURE_GIT_REVISION="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) rev-parse --symbolic-full-name HEAD | cut -d/ -f3-`/`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) rev-parse --short=16 HEAD`"; \
+	echo "#define CONFIGURE_GIT_REVISION \"$${CONFIGURE_GIT_REVISION}\"" > config-version.h.tmp; \
+	echo "#define CONFIGURE_GIT_FLAGS \"$${CONFIGURE_GIT_CHFILES}$${CONFIGURE_GIT_UNCOMMITTED}\"" >> config-version.h.tmp
+
 	@if ! [ -f config-version.h ] || ! cmp -s config-version.h.tmp config-version.h; then \
 		echo "replacing config-version.h"; \
 		mv config-version.h.tmp config-version.h; \
diff --git a/config-version.h.in b/config-version.h.in
deleted file mode 100644
index 27ee36a..0000000
--- a/config-version.h.in
+++ /dev/null
@@ -1 +0,0 @@
-#define CONFIGURE_GIT_REVISION "@CONFIGURE_GIT_REVISION@"
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ec39212..05c6da2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -64,6 +64,9 @@
 
 const char title_string[] =
   PACKAGE_STRING
+#ifdef CONFIGURE_GIT_REVISION
+        " [git:" CONFIGURE_GIT_REVISION CONFIGURE_GIT_FLAGS "]"
+#endif
   " " TARGET_ALIAS
 #ifdef ENABLE_CRYPTO
 #ifdef ENABLE_SSL
@@ -3426,9 +3429,6 @@ usage_version (void)
 #ifdef CONFIGURE_SPECIAL_BUILD
   msg (M_INFO|M_NOPREFIX, "special build: %s", CONFIGURE_SPECIAL_BUILD);
 #endif
-#ifdef CONFIGURE_GIT_REVISION
-  msg (M_INFO|M_NOPREFIX, "git revision: %s", CONFIGURE_GIT_REVISION);
-#endif
 #endif
   openvpn_exit (OPENVPN_EXIT_STATUS_USAGE); /* exit point */
 }
diff --git a/version.m4 b/version.m4
index 1ea1c32..376661f 100644
--- a/version.m4
+++ b/version.m4
@@ -1,7 +1,7 @@
 dnl define the OpenVPN version
 define([PRODUCT_NAME], [OpenVPN])
 define([PRODUCT_TARNAME], [openvpn])
-define([PRODUCT_VERSION], [2.3_master])
+define([PRODUCT_VERSION], [2.3_git])
 define([PRODUCT_BUGREPORT], [openvpn-users@lists.sourceforge.net])
 define([PRODUCT_VERSION_RESOURCE], [2,3,0,0])
 dnl define the TAP version
-- 
1.7.10.2


