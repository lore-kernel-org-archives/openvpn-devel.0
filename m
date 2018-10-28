From: Steffan Karger <steffan@...1856...>
Date: Sun, 28 Oct 2018 15:54:49 +0100
Message-Id: <20181028145449.12676-1-steffan@...1856...>
In-Reply-To: <c47c98fc-7c75-8dcf-555d-e934fb70d702@...2080...>
References: <c47c98fc-7c75-8dcf-555d-e934fb70d702@...2080...>
Subject: [Openvpn-devel] [PATCH v2] cmocka: use relative paths
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
v2: rebase on master, fix in-source builds (thanks dazo for spotting)

 .gitignore         |  2 +-
 configure.ac       | 11 ++---------
 vendor/Makefile.am | 16 ++++++++--------
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/.gitignore b/.gitignore
index 25009d81..5ef9c14d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -56,7 +56,7 @@ doc/openvpn.8.html
 distro/rpm/openvpn.spec
 distro/systemd/*.service
 sample/sample-keys/sample-ca/
-vendor/.build
+vendor/cmocka_build
 vendor/dist
 build/msvc/msvc-generate/version.m4
 
diff --git a/configure.ac b/configure.ac
index 1e6891b1..7fe9b6e6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1353,15 +1353,8 @@ AC_SUBST([sampledir])
 AC_SUBST([systemdunitdir])
 AC_SUBST([tmpfilesdir])
 
-VENDOR_SRC_ROOT="\$(abs_top_srcdir)/vendor/"
-VENDOR_DIST_ROOT="\$(abs_top_builddir)/vendor/dist"
-VENDOR_BUILD_ROOT="\$(abs_top_builddir)/vendor/.build"
-AC_SUBST([VENDOR_SRC_ROOT])
-AC_SUBST([VENDOR_BUILD_ROOT])
-AC_SUBST([VENDOR_DIST_ROOT])
-
-TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_LIBS} -lcmocka -L\$(abs_top_builddir)/vendor/dist/lib -Wl,-rpath,\$(abs_top_builddir)/vendor/dist/lib"
-TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_CFLAGS} -I\$(top_srcdir)/include -I\$(abs_top_builddir)/vendor/dist/include"
+TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} -lcmocka -L\$(top_builddir)/vendor/dist/lib -Wl,-rpath,\$(top_builddir)/vendor/dist/lib"
+TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} -I\$(top_srcdir)/include -I\$(top_builddir)/vendor/dist/include"
 
 AC_SUBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
diff --git a/vendor/Makefile.am b/vendor/Makefile.am
index 674784ab..46072c3c 100644
--- a/vendor/Makefile.am
+++ b/vendor/Makefile.am
@@ -1,18 +1,18 @@
-# needs an absolute path bc. of the cmake invocation
-cmockasrc     = "@VENDOR_SRC_ROOT@/cmocka"
-cmockabuild   = "@VENDOR_BUILD_ROOT@/cmocka"
-cmockainstall = "@VENDOR_DIST_ROOT@"
+cmockasrc   = $(srcdir)/cmocka
+# Not just '$(builddir)/cmocka', because cmocka requires an out-of-source build
+cmockabuild = $(builddir)/cmocka_build
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
+	(cd $(cmockabuild) && cmake -DCMAKE_INSTALL_PREFIX=../$(cmockadist) ../$(cmockasrc) && make && make install)
 endif
 
 check: libcmocka
-- 
2.17.1


