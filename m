From: Gert Doering <gert@...1296...>
Date: Sun, 23 Jun 2019 20:01:57 +0200
Message-Id: <20190623180157.29390-1-gert@...1296...>
In-Reply-To: <20190620200935.38042-1-gert@...1296...>
References: <20190620200935.38042-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Remove cmocka submodule,
 rely on system-wide installation instead.
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

We used to ship git submodule instructions to build a local copy of
cmocka in vendor/cmocka/ and use that (if cmake is installed) to build
unit tests.  With the network test driver this turns out to be a
LD_LIBRARY_PATH vs. SUDO complication which is really outweighing the
benefit of a local build today - so, use the system-wide installation
if available (querying pgk-config).  Do not build unit-tests otherwise.

v2: (inspired by patch from David Sommerseth)
  introduce "configure --disable-unit-test" switch
  simplify configure.ac logic
  use CMOCKA_LIBS and CMOCKA_INCLUDE (set by PKG_CHECK)

Signed-off-by: Gert Doering <gert@...1296...>
---
 .gitmodules                  |  4 ----
 INSTALL                      | 14 +++++++++++++
 Makefile.am                  |  2 +-
 configure.ac                 | 38 ++++++++++++++++++------------------
 tests/unit_tests/Makefile.am |  2 +-
 vendor/Makefile.am           | 22 ---------------------
 vendor/README.md             |  8 --------
 vendor/cmocka                |  1 -
 8 files changed, 35 insertions(+), 56 deletions(-)
 delete mode 100644 .gitmodules
 delete mode 100644 vendor/Makefile.am
 delete mode 100644 vendor/README.md
 delete mode 160000 vendor/cmocka

diff --git a/.gitmodules b/.gitmodules
deleted file mode 100644
index c1ff36e1..00000000
--- a/.gitmodules
+++ /dev/null
@@ -1,4 +0,0 @@
-[submodule "vendor/cmocka"]
-	path = vendor/cmocka
-	url = https://git.cryptomilk.org/projects/cmocka.git
-	branch = master
diff --git a/INSTALL b/INSTALL
index 0ba3bba6..50123e05 100644
--- a/INSTALL
+++ b/INSTALL
@@ -156,6 +156,20 @@ Test SSL/TLS negotiations (runs for 2 minutes):
 For more thorough client-server tests you can configure your own, private test
 environment. See tests/t_client.rc-sample for details.
 
+To do the C unit tests, you need to have the "cmocka" test framework
+installed on your system.  More recent distributions already ship this
+as part of their packages/ports.  If your system does not have it,
+you can install cmocka with these commands:
+
+  $ git clone https://git.cryptomilk.org/projects/cmocka.git
+  $ cd cmocka
+  $ mkdir build
+  $ cd build
+  $ cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Debug ..
+  $ make
+  $ sudo make install
+
+
 *************************************************************************
 
 OPTIONS for ./configure:
diff --git a/Makefile.am b/Makefile.am
index a4dbb34b..439120e4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -53,7 +53,7 @@ BUILT_SOURCES = \
 	config-version.h
 endif
 
-SUBDIRS = build distro include src sample doc vendor tests
+SUBDIRS = build distro include src sample doc tests
 
 dist_doc_DATA = \
 	README \
diff --git a/configure.ac b/configure.ac
index 8c95e310..ed632a16 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1361,27 +1361,28 @@ AC_SUBST([sampledir])
 AC_SUBST([systemdunitdir])
 AC_SUBST([tmpfilesdir])
 
-TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} -lcmocka -L\$(top_builddir)/vendor/dist/lib -Wl,-rpath,\$(top_builddir)/vendor/dist/lib"
-TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} -I\$(top_srcdir)/include -I\$(top_builddir)/vendor/dist/include"
+AC_ARG_ENABLE(
+     [unit-tests],
+     [AS_HELP_STRING([--disable-unit-tests],
+                     [Disables building and running the unit tests suite])],
+     [],
+     [enable_unit_tests="yes"]
+)
 
-AC_SUBST([TEST_LDFLAGS])
-AC_SUBST([TEST_CFLAGS])
+# Check if cmocka is available - needed for unit testing
+PKG_CHECK_MODULES(
+	[CMOCKA], [cmocka],
+	[have_cmocka="yes"],
+	[AC_MSG_WARN([cmocka.pc not found on the system.  Unit tests disabled])]
+)
+AM_CONDITIONAL([ENABLE_UNITTESTS], [test "${enable_unit_tests}" = "yes" -a "${have_cmocka}" = "yes" ])
+AC_SUBST([ENABLE_UNITTESTS])
 
-# Check if cmake is available and cmocka git submodule is initialized,
-# needed for unit testing
-AC_CHECK_PROGS([CMAKE], [cmake])
-if test -n "${CMAKE}"; then
-   if test -f "${srcdir}/vendor/cmocka/CMakeLists.txt"; then
-      AM_CONDITIONAL([CMOCKA_INITIALIZED], [true])
-   else
-      AM_CONDITIONAL([CMOCKA_INITIALIZED], [false])
-      AC_MSG_RESULT([!! WARNING !! The cmoka git submodule has not been initialized or updated.  Unit testing cannot be performed.])
-   fi
-else
-   AC_MSG_RESULT([!! WARNING !! CMake is NOT available.  Unit testing cannot be performed.])
-   AM_CONDITIONAL([CMOCKA_INITIALIZED], [false])
-fi
+TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${CMOCKA_LIBS}"
+TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_INCLUDE}"
 
+AC_SUBST([TEST_LDFLAGS])
+AC_SUBST([TEST_CFLAGS])
 
 AC_CONFIG_FILES([
 	version.sh
@@ -1410,7 +1411,6 @@ AC_CONFIG_FILES([
         tests/unit_tests/openvpn/Makefile
         tests/unit_tests/plugins/Makefile
         tests/unit_tests/plugins/auth-pam/Makefile
-        vendor/Makefile
 	sample/Makefile
 ])
 AC_CONFIG_FILES([tests/t_client.sh], [chmod +x tests/t_client.sh])
diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
index 31d37b89..33fefaac 100644
--- a/tests/unit_tests/Makefile.am
+++ b/tests/unit_tests/Makefile.am
@@ -1,5 +1,5 @@
 AUTOMAKE_OPTIONS = foreign
 
-if CMOCKA_INITIALIZED
+if ENABLE_UNITTESTS
 SUBDIRS = example_test openvpn plugins
 endif
diff --git a/vendor/Makefile.am b/vendor/Makefile.am
deleted file mode 100644
index 46072c3c..00000000
--- a/vendor/Makefile.am
+++ /dev/null
@@ -1,22 +0,0 @@
-cmockasrc   = $(srcdir)/cmocka
-# Not just '$(builddir)/cmocka', because cmocka requires an out-of-source build
-cmockabuild = $(builddir)/cmocka_build
-cmockadist  = $(builddir)/dist
-
-MAINTAINERCLEANFILES = \
-	$(srcdir)/Makefile.in \
-	"$(cmockabuild)" \
-	"$(cmockadist)"
-
-libcmocka:
-if CMOCKA_INITIALIZED
-	mkdir -p $(cmockabuild) $(cmockadist)
-	## Compensate for the cd in the paths
-	(cd $(cmockabuild) && cmake -DCMAKE_INSTALL_PREFIX=../$(cmockadist) ../$(cmockasrc) && make && make install)
-endif
-
-check: libcmocka
-
-clean:
-	rm -rf $(cmockabuild)
-	rm -rf $(cmockainstall)
diff --git a/vendor/README.md b/vendor/README.md
deleted file mode 100644
index cede99b6..00000000
--- a/vendor/README.md
+++ /dev/null
@@ -1,8 +0,0 @@
-Vendor
-========
-
-Vendor source libraries are included in this directory. Libraries are included
-when there is no good way to ensure that the package is available on all
-systems.
-
-`Makefile.am` compiles these libraries and installs them into ./dist.
diff --git a/vendor/cmocka b/vendor/cmocka
deleted file mode 160000
index b2732b52..00000000
--- a/vendor/cmocka
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit b2732b52202ae48f866a024c633466efdbb8e85a
-- 
2.21.0


