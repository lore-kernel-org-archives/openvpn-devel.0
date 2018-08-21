From: Steffan Karger <steffan@...1856...>
Date: Wed, 22 Aug 2018 00:08:42 +0200
Message-Id: <20180821220842.4193-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] cmocka: use relative paths
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

Simplifies the build scripts, and fixes my CI, where paths on the test
slave can be different from paths on the build slave.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac       | 11 ++---------
 vendor/Makefile.am | 15 +++++++--------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9c31435b..76d9f182 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1381,15 +1381,8 @@ AC_SUBST([sampledir])
 AC_SUBST([systemdunitdir])
 AC_SUBST([tmpfilesdir])
 
-VENDOR_SRC_ROOT="\$(abs_top_srcdir)/vendor/"
-VENDOR_DIST_ROOT="\$(abs_top_builddir)/vendor/dist"
-VENDOR_BUILD_ROOT="\$(abs_top_builddir)/vendor/.build"
-AC_SUBST([VENDOR_SRC_ROOT])
-AC_SUBST([VENDOR_BUILD_ROOT])
-AC_SUBST([VENDOR_DIST_ROOT])
-
-TEST_LDFLAGS="-lcmocka -L\$(abs_top_builddir)/vendor/dist/lib -Wl,-rpath,\$(abs_top_builddir)/vendor/dist/lib"
-TEST_CFLAGS="-I\$(top_srcdir)/include -I\$(abs_top_builddir)/vendor/dist/include"
+TEST_LDFLAGS="-lcmocka -L\$(top_builddir)/vendor/dist/lib -Wl,-rpath,\$(top_builddir)/vendor/dist/lib"
+TEST_CFLAGS="-I\$(top_srcdir)/include -I\$(top_builddir)/vendor/dist/include"
 
 AC_SUBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
diff --git a/vendor/Makefile.am b/vendor/Makefile.am
index 674784ab..b68d0311 100644
--- a/vendor/Makefile.am
+++ b/vendor/Makefile.am
@@ -1,18 +1,17 @@
-# needs an absolute path bc. of the cmake invocation
-cmockasrc     = "@VENDOR_SRC_ROOT@/cmocka"
-cmockabuild   = "@VENDOR_BUILD_ROOT@/cmocka"
-cmockainstall = "@VENDOR_DIST_ROOT@"
+cmockasrc   = $(srcdir)/cmocka
+cmockabuild = $(builddir)/cmocka
+cmockadist  = $(builddir)/dist
 
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in \
 	"$(cmockabuild)" \
-	"$(cmockainstall)" \
-	"@VENDOR_BUILD_ROOT@"
+	"$(cmockadist)"
 
 libcmocka:
 if CMOCKA_INITIALIZED
-	mkdir -p $(cmockabuild) $(cmockainstall)
-	(cd $(cmockabuild) && cmake -DCMAKE_INSTALL_PREFIX=$(cmockainstall) $(cmockasrc) && make && make install)
+	mkdir -p $(cmockabuild) $(cmockadist)
+	## Compensate for the cd in the paths
+	(cd cmocka && cmake -DCMAKE_INSTALL_PREFIX=../$(cmockadist) ../$(cmockasrc) && make && make install)
 endif
 
 check: libcmocka
-- 
2.17.1


