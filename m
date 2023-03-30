From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 30 Mar 2023 11:42:26 +0200
Message-Id: <20230330094226.487951-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] version.sh: remove
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

This was added back in commit
6187644b660ce284d0a706811eae2dce7cb411b2
to support the NSIS windows installer.

It is now unused.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .gitignore    | 1 -
 Makefile.am   | 5 -----
 configure.ac  | 1 -
 version.sh.in | 4 ----
 4 files changed, 11 deletions(-)
 delete mode 100644 version.sh.in

Fallout of my quest to understand all users of version.m4

diff --git a/.gitignore b/.gitignore
index 813413fe..bedbf519 100644
--- a/.gitignore
+++ b/.gitignore
@@ -46,7 +46,6 @@ m4/ltversion.m4
 m4/lt~obsolete.m4
 vcpkg_installed
 
-version.sh
 msvc-env-local.bat
 config-msvc-local.h
 config-msvc-version.h
diff --git a/Makefile.am b/Makefile.am
index 4ffe5118..297c3399 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -70,11 +70,6 @@ dist_noinst_HEADERS = \
 	config-msvc.h \
 	config-msvc-version.h.in
 
-if WIN32
-rootdir=$(prefix)
-root_DATA = version.sh
-endif
-
 config-version.h:
 	@CONFIGURE_GIT_CHFILES="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) diff-files --name-status -r --ignore-submodules --quiet -- || echo \"+\"`"; \
 	CONFIGURE_GIT_UNCOMMITTED="`GIT_DIR=\"$(top_srcdir)/.git\" $(GIT) diff-index --cached  --quiet --ignore-submodules HEAD || echo \"*\"`"; \
diff --git a/configure.ac b/configure.ac
index e1e79ebf..50bccc72 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1502,7 +1502,6 @@ AC_SUBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
 
 AC_CONFIG_FILES([
-	version.sh
 	Makefile
 	build/Makefile
 	build/msvc/Makefile
diff --git a/version.sh.in b/version.sh.in
deleted file mode 100644
index 2af5a364..00000000
--- a/version.sh.in
+++ /dev/null
@@ -1,4 +0,0 @@
-OPENVPN_PACKAGE_NAME="@PACKAGE_NAME@"
-OPENVPN_PACKAGE_TARNAME="@PACKAGE_TARNAME@"
-OPENVPN_PACKAGE_VERSION="@PACKAGE_VERSION@"
-OPENVPN_PACKAGE_HOST="@host@"
-- 
2.34.1


